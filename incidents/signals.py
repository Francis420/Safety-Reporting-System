from django.db.models.signals import pre_save, post_save
from django.dispatch import receiver
from .models import IncidentReport
from notifications.utils import notify
from accounts.models import CustomUser

@receiver(pre_save, sender=IncidentReport)
def check_status_category_change(sender, instance, **kwargs):
    if instance.pk:
        previous = IncidentReport.objects.get(pk=instance.pk)
        instance._status_changed = previous.status != instance.status
        instance._category_changed = previous.category != instance.category

@receiver(post_save, sender=IncidentReport)
def send_notification(sender, instance, created, **kwargs):
    if created:
        # Notify all admin users when a new report is submitted
        admin_users = CustomUser.objects.filter(is_admin=True)
        for admin in admin_users:
            notify(
                sender=instance.user,
                user=admin,
                message='New report submitted',
                target=instance
            )
    else:
        # Notify user when their report status or category is updated
        if getattr(instance, '_status_changed', False):
            notify(
                sender=instance.user,
                user=instance.user,
                message=f'Report {instance.description} status updated to {instance.status}',
                target=instance
            )
        if getattr(instance, '_category_changed', False):
            notify(
                sender=instance.user,
                user=instance.user,
                message=f'Report {instance.description} category changed to {instance.category}',
                target=instance
            )