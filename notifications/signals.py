from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Notification
from .utils import notify

@receiver(post_save, sender=Notification)
def notify_user(sender, instance, created, **kwargs):
    if created:
        print(f"Notification created for {instance.user} - {instance.message}")