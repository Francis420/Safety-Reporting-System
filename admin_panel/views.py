from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required, user_passes_test
from incidents.models import IncidentReport
from accounts.models import CustomUser
from django.db.models import Q
from datetime import datetime
import json
from django.views.decorators.http import require_POST
from django.db.models import Count
from django.contrib import messages
from .forms import ConfirmAdminPasswordForm
from django.contrib.auth import authenticate
from django.db import connection
from django.db.models.signals import post_save
from notifications.utils import notify



def is_admin(user):
    return user.is_admin


@login_required 
@user_passes_test(is_admin)
@require_POST
def toggle_admin_status_view(request, user_id):
    with connection.cursor() as cursor:
        cursor.execute("SELECT id, username, is_admin FROM accounts_customuser WHERE id = %s", [user_id])
        user = cursor.fetchone()
    
    if request.method == 'POST':
        form = ConfirmAdminPasswordForm(request.POST)
        if form.is_valid():
            password = form.cleaned_data['password']
            admin_user = authenticate(username=request.user.username, password=password)
            if admin_user is not None:
                new_admin_status = not user[2]  # Toggle admin status
                
                with connection.cursor() as cursor:
                    # Set the current user ID as a session variable
                    cursor.execute("SET @current_user_id = %s", [request.user.id])
                    cursor.execute("UPDATE accounts_customuser SET is_admin = %s WHERE id = %s", [new_admin_status, user_id])
                
                messages.success(request, 'Admin status updated successfully.')
                return redirect('admin_panel:user_list')
            else:
                messages.error(request, 'Incorrect password. Please try again.')
    else:
        form = ConfirmAdminPasswordForm()
    
    return render(request, 'admin_panel/toggle_admin_status.html', {'form': form, 'user': {'id': user[0], 'username': user[1]}})



@login_required
@user_passes_test(is_admin)
@require_POST
def toggle_account_status_view(request, user_id):
    with connection.cursor() as cursor:
        cursor.execute("SELECT id, is_active FROM accounts_customuser WHERE id = %s", [user_id])
        user = cursor.fetchone()
    
    new_active_status = not user[1]  # Toggle active status
    
    with connection.cursor() as cursor:
        # Set the current user ID as a session variable
        cursor.execute("SET @current_user_id = %s", [request.user.id])
        cursor.execute(
            "UPDATE accounts_customuser SET is_active = %s WHERE id = %s",
            [new_active_status, user_id]
        )
    
    return redirect('admin_panel:user_list')


@login_required
@user_passes_test(is_admin)
@require_POST
def update_remarks_view(request, user_id):
    new_remark = request.POST.get('remark')
    
    with connection.cursor() as cursor:
        # Set the current user ID as a session variable
        cursor.execute("SET @current_user_id = %s", [request.user.id])
        cursor.execute("UPDATE accounts_customuser SET remarks = %s WHERE id = %s", [new_remark, user_id])
    
    return redirect('admin_panel:user_list')

def is_admin(user):
    return user.is_admin

def analytics_view(request):
    # Get filter parameters
    start_datetime = request.GET.get('start_datetime')
    end_datetime = request.GET.get('end_datetime')

    # Filter incidents based on the provided parameters
    query = "SELECT id, category, created_at FROM incidents_incidentreport"
    params = []
    if start_datetime and end_datetime:
        query += " WHERE created_at BETWEEN %s AND %s"
        params.extend([start_datetime, end_datetime])

    with connection.cursor() as cursor:
        cursor.execute(query, params)
        incidents = cursor.fetchall()

    # Aggregate data for analytics
    category_data = {}
    monthly_data = {}
    for incident in incidents:
        category = incident[1]
        created_at = incident[2]  # Already a datetime object
        month = created_at.strftime('%Y-%m')
        category_data[category] = category_data.get(category, 0) + 1
        if month not in monthly_data:
            monthly_data[month] = {}
        monthly_data[month][category] = monthly_data[month].get(category, 0) + 1

    # Convert data to JSON for use in JavaScript
    category_data_json = json.dumps([{'category': k, 'count': v} for k, v in category_data.items()])
    monthly_data_json = json.dumps([{'month': k, 'category': cat, 'count': cnt} for k, v in monthly_data.items() for cat, cnt in v.items()])

    return render(request, 'admin_panel/analytics.html', {
        'category_data': category_data_json,
        'monthly_data': monthly_data_json,
        'start_datetime': start_datetime,
        'end_datetime': end_datetime,
    })


@login_required
@user_passes_test(is_admin)
@require_POST
def update_category_view(request, pk):
    category = request.POST.get('category')
    if category in dict(IncidentReport.CATEGORY_CHOICES):
        with connection.cursor() as cursor:
            cursor.execute("SELECT category FROM incidents_incidentreport WHERE id = %s", [pk])
            old_category = cursor.fetchone()[0]
            
            cursor.execute("SET @current_user_id = %s", [request.user.id])
            cursor.execute("UPDATE incidents_incidentreport SET category = %s WHERE id = %s", [category, pk])
        
        # Manually check for category change and trigger notification logic
        if old_category != category:
            incident = IncidentReport.objects.get(pk=pk)
            notify(
                sender=incident.user,
                user=incident.user,
                message=f'Report {incident.description} category changed to {category}',
                receiver=incident
            )
            print(f"Notification sent to user {incident.user.id} for category change")

    return redirect('admin_panel:incident_list')

@login_required
@user_passes_test(is_admin)
def incident_list_view(request):
    query = request.GET.get('q')
    category = request.GET.get('category')
    status = request.GET.get('status')
    start_date = request.GET.get('start_date')
    end_date = request.GET.get('end_date')
    start_time = request.GET.get('start_time')
    end_time = request.GET.get('end_time')

    sql_query = "SELECT id, description, location, status, category FROM incidents_incidentreport WHERE 1=1"
    params = []

    if query:
        if query.isdigit():
            sql_query += " AND id = %s"
            params.append(query)
        else:
            sql_query += " AND (description LIKE %s OR location LIKE %s)"
            params.extend([f"%{query}%", f"%{query}%"])
    if category:
        sql_query += " AND category = %s"
        params.append(category)
    if status:
        sql_query += " AND status = %s"
        params.append(status)
    if start_date and end_date:
        start_datetime = f"{start_date} {start_time or '00:00'}"
        end_datetime = f"{end_date} {end_time or '23:59'}"
        sql_query += " AND created_at BETWEEN %s AND %s"
        params.extend([start_datetime, end_datetime])

    with connection.cursor() as cursor:
        cursor.execute(sql_query, params)
        incidents = cursor.fetchall()

    # Fetch category and status choices
    category_choices = IncidentReport.CATEGORY_CHOICES
    status_choices = IncidentReport.STATUS_CHOICES

    return render(request, 'admin_panel/incident_list.html', {
        'incidents': incidents,
        'category_choices': category_choices,
        'status_choices': status_choices,
    })


@login_required
@user_passes_test(lambda u: u.is_admin)
def user_list_view(request):
    id_query = request.GET.get('id_q')
    general_query = request.GET.get('q')

    sql_query = """
        SELECT id, username, email, address, phone_number, is_active, is_admin, 
        COALESCE(remarks, '') AS remarks 
        FROM accounts_customuser WHERE 1=1
    """
    params = []

    if id_query:
        sql_query += " AND id LIKE %s"
        params.append(f"%{id_query}%")

    if general_query:
        sql_query += " AND (username LIKE %s OR email LIKE %s OR address LIKE %s OR phone_number LIKE %s)"
        params.extend([f"%{general_query}%", f"%{general_query}%", f"%{general_query}%", f"%{general_query}%"])

    with connection.cursor() as cursor:
        cursor.execute(sql_query, params)
        users = cursor.fetchall()

    # Convert the result to a list of dictionaries
    users = [
        {
            'id': user[0],
            'username': user[1],
            'email': user[2],
            'address': user[3],
            'phone_number': user[4],
            'is_active': user[5],
            'is_admin': user[6],
            'remarks': user[7]  # Include remarks
        }
        for user in users
    ]

    return render(request, 'admin_panel/user_list.html', {'users': users})


@login_required
@user_passes_test(lambda u: u.is_admin)
def incident_detail_view(request, pk):
    STATUS_CHOICES = IncidentReport.STATUS_CHOICES
    incident = None

    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT ir.id, ir.category, ir.description, ir.location, ir.latitude, ir.longitude, ir.status, ir.created_at, ir.updated_at, cu.username
            FROM incidents_incidentreport ir
            JOIN accounts_customuser cu ON ir.user_id = cu.id
            WHERE ir.id = %s
        """, [pk])
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
                'user': {'username': row[9]}
            }

    if request.method == 'POST':
        new_status = request.POST.get('status')
        if new_status in dict(STATUS_CHOICES):
            with connection.cursor() as cursor:
                cursor.execute("UPDATE incidents_incidentreport SET status = %s WHERE id = %s", [new_status, pk])
                # Refresh the incident data after update
                cursor.execute("""
                    SELECT ir.id, ir.category, ir.description, ir.location, ir.latitude, ir.longitude, ir.status, ir.created_at, ir.updated_at, cu.username
                    FROM incidents_incidentreport ir
                    JOIN accounts_customuser cu ON ir.user_id = cu.id
                    WHERE ir.id = %s
                """, [pk])
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
                        'user': {'username': row[9]}
                    }
            
            # Manually trigger the post_save signal
            incident = IncidentReport.objects.get(pk=pk)
            post_save.send(sender=IncidentReport, instance=incident, created=False)

    return render(request, 'admin_panel/incident_detail.html', {'incident': incident, 'STATUS_CHOICES': STATUS_CHOICES})

@login_required
@user_passes_test(is_admin)
@require_POST
def update_status_view(request, pk):
    new_status = request.POST.get('status')
    if new_status in dict(IncidentReport.STATUS_CHOICES):
        with connection.cursor() as cursor:
            cursor.execute("SELECT status FROM incidents_incidentreport WHERE id = %s", [pk])
            old_status = cursor.fetchone()[0]
            
            cursor.execute("UPDATE incidents_incidentreport SET status = %s WHERE id = %s", [new_status, pk])
        
        # Manually check for status change and trigger notification logic
        if old_status != new_status:
            incident = IncidentReport.objects.get(pk=pk)
            notify(
                sender=incident.user,
                user=incident.user,
                message=f'Report {incident.description} status updated to {new_status}',
                receiver=incident
            )
            print(f"Notification sent to user {incident.user.id} for status update")

    return redirect('admin_panel:incident_list')
    
@login_required
@user_passes_test(lambda u: u.is_admin)
def dashboard_view(request):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM incidents_incidentreport")
        rows = cursor.fetchall()
        incidents = []
        for row in rows:
            incidents.append({
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
            })
    
    # Search and filter
    id_query = request.GET.get('id_q')
    general_query = request.GET.get('q')
    category = request.GET.get('category')
    status = request.GET.get('status')
    start_datetime = request.GET.get('start_datetime')
    end_datetime = request.GET.get('end_datetime')
    
    filters = []
    params = []
    
    if id_query:
        filters.append("id = %s")
        params.append(id_query)
    
    if general_query:
        filters.append("(description LIKE %s OR location LIKE %s)")
        params.extend([f"%{general_query}%", f"%{general_query}%"])
    
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
        query = f"SELECT * FROM incidents_incidentreport WHERE {filter_query}"
        with connection.cursor() as cursor:
            cursor.execute(query, params)
            rows = cursor.fetchall()
            incidents = []
            for row in rows:
                incidents.append({
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
                })
    
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
    
    return render(request, 'admin_panel/dashboard.html', {
        'incidents': incidents,
        'incidents_json': incidents_json,
        'CATEGORY_CHOICES': CATEGORY_CHOICES,
        'STATUS_CHOICES': STATUS_CHOICES
    })