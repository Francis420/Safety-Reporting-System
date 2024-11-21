from django.shortcuts import render
from incidents.models import IncidentReport
from django.db.models import Count

def dashboard_view(request):
    category_counts = IncidentReport.objects.values('category').annotate(count=Count('category'))
    status_counts = IncidentReport.objects.values('status').annotate(count=Count('status'))

    context = {
        'category_counts': category_counts,
        'status_counts': status_counts,
    }
    return render(request, 'dashboard/dashboard.html', context)