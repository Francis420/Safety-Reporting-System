from django.urls import path
from .views import analytics_view
from .views import incident_list_view, user_list_view, incident_detail_view, update_status_view, dashboard_view, update_category_view, toggle_account_status_view, update_remarks_view, toggle_admin_status_view


app_name = 'admin_panel'

urlpatterns = [
    path('incidents/', incident_list_view, name='incident_list'),
    path('incidents/<int:pk>/', incident_detail_view, name='incident_detail'),
    path('incidents/update_status/<int:pk>/', update_status_view, name='update_status'),
    path('incidents/update_category/<int:pk>/', update_category_view, name='update_category'),
    path('users/', user_list_view, name='user_list'),
    path('dashboard/', dashboard_view, name='dashboard'),
    path('analytics/', analytics_view, name='analytics'),
    path('toggle_account_status/<int:user_id>/', toggle_account_status_view, name='toggle_account_status'),
    path('update_remarks/<int:user_id>/', update_remarks_view, name='update_remarks'),
    path('toggle_admin_status/<int:user_id>/', toggle_admin_status_view, name='toggle_admin_status'),

]