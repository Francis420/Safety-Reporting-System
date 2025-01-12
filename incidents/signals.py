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
        print(f"Status changed: {instance._status_changed}, Category changed: {instance._category_changed}")

@receiver(post_save, sender=IncidentReport)
def send_notification(sender, instance, created, **kwargs):
    print("send_notification signal triggered")  # Check if the signal is triggered
    if created:
        admin_users = CustomUser.objects.filter(is_admin=True)
        for admin in admin_users:
            notify(
                sender=instance.user,
                user=admin,
                message='New report submitted',
                receiver=instance
            )
            print(f"Notification sent to admin {admin.id} for new report by {instance.user.id}")
    else:
        if getattr(instance, '_status_changed', False):
            notify(
                sender=instance.user,
                user=instance.user,
                message=f'Report {instance.description} status updated to {instance.status}',
                receiver=instance
            )
            print(f"Notification sent to user {instance.user.id} for status update")
        if getattr(instance, '_category_changed', False):
            notify(
                sender=instance.user,
                user=instance.user,
                message=f'Report {instance.description} category changed to {instance.category}',
                receiver=instance
            )
            print(f"Notification sent to user {instance.user.id} for category change")