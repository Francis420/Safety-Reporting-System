from django.db import models
from accounts.models import CustomUser
from django.urls import reverse

class IncidentReport(models.Model):
    CATEGORY_CHOICES = [
        ('Crime', 'Crime'),
        ('Traffic Accident', 'Traffic Accident'),
        ('Unsafe Condition', 'Unsafe Condition'),
    ]

    STATUS_CHOICES = [
        ('Received', 'Received'),
        ('Acknowledged', 'Acknowledged'),
        ('Resolved', 'Resolved'),
    ]

    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE, related_name='incident_reports')
    category = models.CharField(max_length=50, choices=CATEGORY_CHOICES)
    description = models.TextField()
    location = models.CharField(max_length=255)
    latitude = models.FloatField()
    longitude = models.FloatField()
    status = models.CharField(max_length=50, choices=STATUS_CHOICES, default='Received')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.category} - {self.status}"

    def get_absolute_url(self):
        return reverse('incident_detail', args=[str(self.id)])

    def get_dirty_fields(self):
        dirty_fields = {}
        for field in self._meta.fields:
            field_name = field.name
            if hasattr(self, '_original_' + field_name):
                original_value = getattr(self, '_original_' + field_name)
                current_value = getattr(self, field_name)
                if original_value != current_value:
                    dirty_fields[field_name] = original_value
        return dirty_fields

    def save(self, *args, **kwargs):
        if self.pk:
            for field in self._meta.fields:
                field_name = field.name
                if not hasattr(self, '_original_' + field_name):
                    setattr(self, '_original_' + field_name, getattr(self, field_name))
        super().save(*args, **kwargs)