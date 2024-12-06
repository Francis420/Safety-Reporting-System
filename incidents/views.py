from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from .forms import IncidentReportForm
from .models import IncidentReport
from django.db.models import Q
from datetime import datetime
import json


@login_required
def report_incident_view(request):
    if request.method == 'POST':
        form = IncidentReportForm(request.POST)
        if form.is_valid():
            incident = form.save(commit=False)
            incident.user = request.user
            incident.save()
            return redirect('incidents:user_incident_detail', pk=incident.pk)
    else:
        form = IncidentReportForm()
    return render(request, 'incidents/report_incident.html', {'form': form})

@login_required
def user_incident_list_view(request):
    incidents = IncidentReport.objects.filter(user=request.user)
    return render(request, 'incidents/user_incident_list.html', {'incidents': incidents})

@login_required
def user_incident_detail_view(request, pk):
    incident = get_object_or_404(IncidentReport, pk=pk, user=request.user)
    return render(request, 'incidents/user_incident_detail.html', {'incident': incident})

@login_required
def update_incident_view(request, pk):
    incident = get_object_or_404(IncidentReport, pk=pk, user=request.user)
    if request.method == 'POST':
        form = IncidentReportForm(request.POST, instance=incident)
        if form.is_valid():
            form.save()
            return redirect('incidents:user_incident_detail', pk=incident.pk)
    else:
        form = IncidentReportForm(instance=incident)
    return render(request, 'incidents/update_incident.html', {'form': form, 'incident': incident})

@login_required
def delete_incident_view(request, pk):
    incident = get_object_or_404(IncidentReport, pk=pk, user=request.user)
    if request.method == 'POST':
        incident.delete()
        return redirect('incidents:user_incident_list')
    return render(request, 'incidents/delete_incident.html', {'incident': incident})

@login_required
def user_dashboard_view(request):
    incidents = IncidentReport.objects.filter(user=request.user)
    
    # Search and filter
    query = request.GET.get('q')
    category = request.GET.get('category')
    status = request.GET.get('status')
    start_date = request.GET.get('start_date')
    end_date = request.GET.get('end_date')
    start_time = request.GET.get('start_time')
    end_time = request.GET.get('end_time')
    
    if query:
        incidents = incidents.filter(
            Q(description__icontains=query) | Q(location__icontains=query)
        )
    if category:
        incidents = incidents.filter(category=category)
    if status:
        incidents = incidents.filter(status=status)
    if start_date and end_date:
        start_datetime = datetime.strptime(f"{start_date} {start_time or '00:00'}", '%Y-%m-%d %H:%M')
        end_datetime = datetime.strptime(f"{end_date} {end_time or '23:59'}", '%Y-%m-%d %H:%M')
        incidents = incidents.filter(created_at__range=(start_datetime, end_datetime))
    
    incidents_json = json.dumps(list(incidents.values('id', 'latitude', 'longitude', 'category', 'description')))
    return render(request, 'incidents/user_dashboard.html', {'incidents': incidents, 'incidents_json': incidents_json})