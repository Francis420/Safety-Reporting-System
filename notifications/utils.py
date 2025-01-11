from .models import Notification
from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync

def notify(sender, user, message, receiver=None):  # Changed this line
    Notification.objects.create(user=user, message=message, receiver=receiver)  # Changed this line
    channel_layer = get_channel_layer()
    async_to_sync(channel_layer.group_send)(
        f"notifications_{user.id}",
        {
            "type": "send_notification",
            "message": message
        }
    )