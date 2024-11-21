from django.urls import path
from .views import report_incident_view

urlpatterns = [
    path('report/', report_incident_view, name='report_incident'),
]