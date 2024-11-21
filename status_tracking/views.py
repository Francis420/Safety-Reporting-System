from django.shortcuts import render
from incidents.models import IncidentReport
from django.shortcuts import render, get_object_or_404

def user_reports_view(request):
    reports = IncidentReport.objects.filter(user=request.user)
    return render(request, 'status_tracking/user_reports.html', {'reports': reports})

def report_detail_view(request, report_id):
    report = get_object_or_404(IncidentReport, id=report_id, user=request.user)
    return render(request, 'status_tracking/report_detail.html', {'report': report})
