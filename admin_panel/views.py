from django.shortcuts import render
from .models import IncidentReport

def incident_list_view(request):
    incidents = IncidentReport.objects.all()
    return render(request, 'admin_panel/incident_list.html', {'incidents': incidents})
