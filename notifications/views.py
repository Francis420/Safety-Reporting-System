from django.shortcuts import render, redirect
from .models import Notification

def notifications_view(request):
    notification_count = Notification.objects.filter(recipient=request.user, read=False).count()
    notifications = request.user.notifications.filter(read=False)
    return render(request, 'notifications.html', {'notifications': notifications, 'notification_count': notification_count})

def mark_notification_as_read(request, pk):
    notification = Notification.objects.get(pk=pk)
    notification.mark_as_read()
    return redirect('notifications')