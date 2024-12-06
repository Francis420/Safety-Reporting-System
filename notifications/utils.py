from .models import Notification

def notify(sender, recipient, verb, target=None):
    Notification.objects.create(recipient=recipient, verb=verb, target=target)