from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync
from .models import Notification

def notify(sender, user, message, receiver=None):
    print("notify function called")  # Check if the function is called
    notification = Notification.objects.create(user=user, message=message, receiver=receiver)
    print(f"Notification created: {notification}")  # Check if the notification is created
    channel_layer = get_channel_layer()
    async_to_sync(channel_layer.group_send)(
        f"notifications_{user.id}",
        {
            "type": "send_notification",
            "message": message
        }
    )
    print(f"Notification sent to group notifications_{user.id} with message: {message}")