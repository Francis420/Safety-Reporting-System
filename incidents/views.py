from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from .forms import IncidentReportForm
from .models import IncidentReport
from django.db.models import Q
from datetime import datetime
import json
from django.db import connection, transaction
from django.db.models.signals import post_save
from django.contrib import messages


@login_required
def report_incident_view(request):
    if request.method == 'POST':
        form = IncidentReportForm(request.POST)
        if form.is_valid():
            try:
                with connection.cursor() as cursor:
                    cursor.execute("SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;")
                    cursor.execute("START TRANSACTION;")
                    
                    cursor.execute("""
                        INSERT INTO incidents_incidentreport (category, description, location, latitude, longitude, status, created_at, updated_at, user_id)
                        VALUES (%s, %s, %s, %s, %s, %s, NOW(), NOW(), %s)
                    """, [
                        form.cleaned_data['category'],
                        form.cleaned_data['description'],
                        form.cleaned_data['location'],
                        form.cleaned_data['latitude'],
                        form.cleaned_data['longitude'],
                        'Received',
                        request.user.id
                    ])
                    incident_id = cursor.lastrowid
                    cursor.execute("COMMIT;")
                
                incident = IncidentReport.objects.get(pk=incident_id)
                post_save.send(sender=IncidentReport, instance=incident, created=True)
                
                return redirect('incidents:user_incident_detail', pk=incident_id)
            except Exception as e:
                with connection.cursor() as cursor:
                    cursor.execute("ROLLBACK;")
                print(f"Error reporting incident: {e}")
                messages.error(request, 'An error occurred while reporting the incident. Please try again.')
    else:
        form = IncidentReportForm()
    return render(request, 'incidents/report_incident.html', {'form': form})

@login_required
def user_incident_list_view(request):
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT id, category, description, location, latitude, longitude, status, created_at, updated_at
            FROM incidents_incidentreport
            WHERE user_id = %s
            ORDER BY created_at DESC
        """, [request.user.id])
        rows = cursor.fetchall()
        incidents = [
            {
                'id': row[0],
                'category': row[1],
                'description': row[2],
                'location': row[3],
                'latitude': row[4],
                'longitude': row[5],
                'status': row[6],
                'created_at': row[7],
                'updated_at': row[8]
            }
            for row in rows
        ]
    
    return render(request, 'incidents/user_incident_list.html', {'incidents': incidents})

@login_required
def user_incident_detail_view(request, pk):
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT ir.id, ir.category, ir.description, ir.location, ir.latitude, ir.longitude, ir.status, ir.created_at, ir.updated_at, cu.username
            FROM incidents_incidentreport ir
            JOIN accounts_customuser cu ON ir.user_id = cu.id
            WHERE ir.id = %s AND ir.user_id = %s
        """, [pk, request.user.id])
        row = cursor.fetchone()
        if row:
            category_display = dict(IncidentReport.CATEGORY_CHOICES).get(row[1], row[1])
            status_display = dict(IncidentReport.STATUS_CHOICES).get(row[6], row[6])
            incident = {
                'id': row[0],
                'category': row[1],
                'category_display': category_display,
                'description': row[2],
                'location': row[3],
                'latitude': row[4],
                'longitude': row[5],
                'status': row[6],
                'status_display': status_display,
                'created_at': row[7],
                'updated_at': row[8],
                'user': {'username': row[9]}
            }
        else:
            incident = None
    
    return render(request, 'incidents/user_incident_detail.html', {'incident': incident})

@login_required
def update_incident_view(request, pk):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM incidents_incidentreport WHERE id = %s AND user_id = %s", [pk, request.user.id])
        row = cursor.fetchone()
        if row:
            incident = {
                'id': row[0],
                'category': row[1],
                'description': row[2],
                'location': row[3],
                'latitude': row[4],
                'longitude': row[5],
                'status': row[6],
                'created_at': row[7],
                'updated_at': row[8],
                'user_id': row[9]
            }
        else:
            incident = None

    if request.method == 'POST':
        form = IncidentReportForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
            data['status'] = incident['status']
            try:
                with connection.cursor() as cursor:
                    cursor.execute("SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;")
                    cursor.execute("START TRANSACTION;")
                    
                    cursor.execute("""
                        UPDATE incidents_incidentreport
                        SET category = %s, description = %s, location = %s, latitude = %s, longitude = %s, status = %s, updated_at = NOW()
                        WHERE id = %s AND user_id = %s
                    """, [
                        data['category'], data['description'], data['location'], data['latitude'], data['longitude'], data['status'], pk, request.user.id
                    ])
                    cursor.execute("COMMIT;")
                
                return redirect('incidents:user_incident_detail', pk=pk)
            except Exception as e:
                with connection.cursor() as cursor:
                    cursor.execute("ROLLBACK;")
                print(f"Error updating incident: {e}")
                messages.error(request, 'An error occurred while updating the incident. Please try again.')
    else:
        form = IncidentReportForm(initial={
            'category': incident['category'],
            'description': incident['description'],
            'location': incident['location'],
            'latitude': incident['latitude'],
            'longitude': incident['longitude'],
            'status': incident['status']
        })

    return render(request, 'incidents/update_incident.html', {'form': form, 'incident': incident})



@login_required
def delete_incident_view(request, pk):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM incidents_incidentreport WHERE id = %s AND user_id = %s", [pk, request.user.id])
        row = cursor.fetchone()
        if row:
            incident = {
                'id': row[0],
                'category': row[1],
                'description': row[2],
                'location': row[3],
                'latitude': row[4],
                'longitude': row[5],
                'status': row[6],
                'created_at': row[7],
                'updated_at': row[8],
                'user_id': row[9]
            }
        else:
            incident = None

    if request.method == 'POST':
        try:
            with connection.cursor() as cursor:
                cursor.execute("SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;")
                cursor.execute("START TRANSACTION;")
                
                cursor.execute("DELETE FROM notifications_notification WHERE incident_id = %s OR receiver_id = %s", [pk, pk])
                cursor.execute("DELETE FROM incidents_incidentreport WHERE id = %s AND user_id = %s", [pk, request.user.id])
                
                cursor.execute("COMMIT;")
            
            return redirect('incidents:user_incident_list')
        except Exception as e:
            with connection.cursor() as cursor:
                cursor.execute("ROLLBACK;")
            print(f"Error deleting incident: {e}")
            messages.error(request, 'An error occurred while deleting the incident. Please try again.')

    return render(request, 'incidents/delete_incident.html', {'incident': incident})

@login_required
def user_dashboard_view(request):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM incidents_incidentreport WHERE user_id = %s", [request.user.id])
        rows = cursor.fetchall()
        incidents = [
            {
                'id': row[0],
                'category': row[1],
                'description': row[2],
                'location': row[3],
                'latitude': row[4],
                'longitude': row[5],
                'status': row[6],
                'created_at': row[7],
                'updated_at': row[8],
                'user_id': row[9]
            }
            for row in rows
        ]
    
    query = request.GET.get('q')
    category = request.GET.get('category')
    status = request.GET.get('status')
    start_datetime = request.GET.get('start_datetime')
    end_datetime = request.GET.get('end_datetime')
    
    filters = []
    params = []
    
    if query:
        filters.append("(description LIKE %s OR location LIKE %s)")
        params.extend([f"%{query}%", f"%{query}%"])
    
    if category:
        filters.append("category = %s")
        params.append(category)
    
    if status:
        filters.append("status = %s")
        params.append(status)
    
    if start_datetime and end_datetime:
        filters.append("created_at BETWEEN %s AND %s")
        params.extend([start_datetime, end_datetime])
    
    if filters:
        filter_query = " AND ".join(filters)
        query = f"SELECT * FROM incidents_incidentreport WHERE user_id = %s AND {filter_query}"
        params.insert(0, request.user.id)
        with connection.cursor() as cursor:
            cursor.execute(query, params)
            rows = cursor.fetchall()
            incidents = [
                {
                    'id': row[0],
                    'category': row[1],
                    'description': row[2],
                    'location': row[3],
                    'latitude': row[4],
                    'longitude': row[5],
                    'status': row[6],
                    'created_at': row[7],
                    'updated_at': row[8],
                    'user_id': row[9]
                }
                for row in rows
            ]
    
    incidents_json = json.dumps([
        {
            'id': incident['id'],
            'latitude': incident['latitude'],
            'longitude': incident['longitude'],
            'category': incident['category'],
            'description': incident['description']
        } for incident in incidents
    ])
    
    CATEGORY_CHOICES = IncidentReport.CATEGORY_CHOICES
    STATUS_CHOICES = IncidentReport.STATUS_CHOICES
    
    return render(request, 'incidents/user_dashboard.html', {
        'incidents': incidents,
        'incidents_json': incidents_json,
        'CATEGORY_CHOICES': CATEGORY_CHOICES,
        'STATUS_CHOICES': STATUS_CHOICES
    })