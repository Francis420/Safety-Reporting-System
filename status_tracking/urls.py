from django.urls import path
from .views import user_reports_view, report_detail_view

urlpatterns = [
    path('my_reports/', user_reports_view, name='user_reports'),
    path('report/<int:report_id>/', report_detail_view, name='report_detail'),
]