from django.shortcuts import render, redirect
from .forms import IncidentReportForm

def report_incident_view(request):
    if request.method == 'POST':
        form = IncidentReportForm(request.POST)
        if form.is_valid():
            incident = form.save(commit=False)
            incident.user = request.user
            incident.save()
            return redirect('incident_list')
    else:
        form = IncidentReportForm()
    return render(request, 'incidents/report_incident.html', {'form': form})