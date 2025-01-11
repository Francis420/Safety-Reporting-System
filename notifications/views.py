from django.shortcuts import render, redirect
from .models import Notification

def notifications_view(request):
    notification_count = Notification.objects.filter(user=request.user, read=False).count()
    notifications = request.user.notifications.order_by('-timestamp')  # List all notifications
    return render(request, 'notifications/notifications.html', {'notifications': notifications, 'notification_count': notification_count})

def mark_notification_as_read(request, pk):
    notification = Notification.objects.get(pk=pk)
    notification.mark_as_read()
    return redirect('notifications')

def mark_notification_as_unread(request, pk):
    notification = Notification.objects.get(pk=pk)
    notification.read = False
    notification.save()
    return redirect('notifications')