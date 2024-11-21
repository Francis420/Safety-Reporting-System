from django.urls import path
from .views import incident_list_view

urlpatterns = [
    path('incidents/', incident_list_view, name='incident_list'),
]