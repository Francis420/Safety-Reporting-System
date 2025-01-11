from django.conf import settings
from django.db import models

class Notification(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='notifications')
    message = models.CharField(max_length=255)
    incident = models.ForeignKey('incidents.IncidentReport', on_delete=models.CASCADE, null=True, blank=True)
    receiver = models.ForeignKey('incidents.IncidentReport', on_delete=models.CASCADE, related_name='notifications', null=True, blank=True)  # Changed this line
    read = models.BooleanField(default=False)
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'Notification for {self.user} - {self.message}'

    def mark_as_read(self):
        self.read = True
        self.save()