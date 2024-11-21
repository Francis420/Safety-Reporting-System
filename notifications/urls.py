from django.urls import path
from .views import notifications_list_view, mark_as_read_view

urlpatterns = [
    path('', notifications_list_view, name='notifications_list'),
    path('mark_as_read/<int:notification_id>/', mark_as_read_view, name='mark_as_read'),
]