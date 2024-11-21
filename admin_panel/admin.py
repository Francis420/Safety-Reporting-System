from django.contrib import admin
from .models import IncidentReport

@admin.register(IncidentReport)
class IncidentReportAdmin(admin.ModelAdmin):
    list_display = ('user', 'category', 'status', 'created_at', 'updated_at')
    list_filter = ('category', 'status')
    search_fields = ('user__username', 'description', 'location')