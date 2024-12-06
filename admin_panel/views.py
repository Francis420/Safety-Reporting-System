from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required, user_passes_test
from incidents.models import IncidentReport
from accounts.models import CustomUser
from django.db.models import Q
from datetime import datetime
import json
from django.views.decorators.http import require_POST
from django.db.models import Count

def is_admin(user):
    return user.is_admin

def analytics_view(request):
    # Get filter parameters
    start_date = request.GET.get('start_date')
    end_date = request.GET.get('end_date')
    start_time = request.GET.get('start_time')
    end_time = request.GET.get('end_time')

    # Filter incidents based on the provided parameters
    incidents = IncidentReport.objects.all()
    if start_date and end_date:
        start_datetime = datetime.strptime(f"{start_date} {start_time or '00:00'}", '%Y-%m-%d %H:%M')
        end_datetime = datetime.strptime(f"{end_date} {end_time or '23:59'}", '%Y-%m-%d %H:%M')
        incidents = incidents.filter(created_at__range=(start_datetime, end_datetime))

    # Aggregate data for analytics
    category_data = incidents.values('category').annotate(count=Count('category'))
    monthly_data = incidents.extra(select={'month': "DATE_FORMAT(created_at, '%%Y-%%m')"}).values('month', 'category').annotate(count=Count('id')).order_by('month', 'category')

    # Convert data to JSON for use in JavaScript
    category_data_json = json.dumps(list(category_data))
    monthly_data_json = json.dumps(list(monthly_data))

    return render(request, 'admin_panel/analytics.html', {
        'category_data': category_data_json,
        'monthly_data': monthly_data_json,
        'start_date': start_date,
        'end_date': end_date,
        'start_time': start_time,
        'end_time': end_time,
    })

@require_POST
def update_category_view(request, pk):
    incident = get_object_or_404(IncidentReport, pk=pk)
    category = request.POST.get('category')
    if category in dict(IncidentReport.CATEGORY_CHOICES):
        incident.category = category
        incident.save()
    return redirect('admin_panel:incident_list')

@login_required
@user_passes_test(is_admin)
def incident_list_view(request):
    incidents = IncidentReport.objects.all()
    
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
    
    return render(request, 'admin_panel/incident_list.html', {'incidents': incidents})

@login_required
@user_passes_test(is_admin)
def user_list_view(request):
    users = CustomUser.objects.all()
    return render(request, 'admin_panel/user_list.html', {'users': users})

@login_required
@user_passes_test(is_admin)
def incident_detail_view(request, pk):
    incident = get_object_or_404(IncidentReport, pk=pk)
    return render(request, 'admin_panel/incident_detail.html', {'incident': incident})

@login_required
@user_passes_test(is_admin)
def update_status_view(request, pk):
    if request.method == 'POST':
        incident = get_object_or_404(IncidentReport, pk=pk)
        new_status = request.POST.get('status')
        if new_status in dict(IncidentReport.STATUS_CHOICES):
            incident.status = new_status
            incident.save()
        return redirect('admin_panel:incident_list')
    
@login_required
@user_passes_test(is_admin)
def dashboard_view(request):
    incidents = IncidentReport.objects.all()
    
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
            Q(description__icontains=query) |
            Q(location__icontains=query)
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
    
    return render(request, 'admin_panel/dashboard.html', {'incidents': incidents, 'incidents_json': incidents_json})