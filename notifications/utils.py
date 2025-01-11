from .models import Notification
from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync

def notify(sender, user, message, target=None):
    Notification.objects.create(user=user, message=message, target=target)
    channel_layer = get_channel_layer()
    async_to_sync(channel_layer.group_send)(
        f"notifications_{user.id}",
        {
            "type": "send_notification",
            "message": message
        }
    )