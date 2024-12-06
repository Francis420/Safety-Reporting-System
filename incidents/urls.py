from django.urls import path
from .views import (
    report_incident_view, user_incident_list_view, user_incident_detail_view,
    update_incident_view, delete_incident_view, user_dashboard_view
)

app_name = 'incidents'

urlpatterns = [
    path('report/', report_incident_view, name='report_incident'),
    path('reported_incidents/', user_incident_list_view, name='user_incident_list'),
    path('incident/<int:pk>/', user_incident_detail_view, name='user_incident_detail'),
    path('incident/<int:pk>/update/', update_incident_view, name='update_incident'),
    path('incident/<int:pk>/delete/', delete_incident_view, name='delete_incident'),
    path('dashboard/', user_dashboard_view, name='user_dashboard'),
]