from django.shortcuts import render, redirect
from .models import AuditLog
from incidents.forms import IncidentReportForm  # Correct import statement
from audit_trail.utils import log_action  # Ensure this import is correct

def audit_log_list_view(request):
    logs = AuditLog.objects.all().order_by('-timestamp')
    return render(request, 'audit_trail/audit_log_list.html', {'logs': logs})

def report_incident_view(request):
    if request.method == 'POST':
        form = IncidentReportForm(request.POST)
        if form.is_valid():
            incident = form.save(commit=False)
            incident.user = request.user
            incident.save()
            log_action(request.user, 'Created Incident Report', f"Report ID: {incident.id}")
            return redirect('user_reports')
    else:
        form = IncidentReportForm()
    return render(request, 'incidents/report_incident.html', {'form': form})