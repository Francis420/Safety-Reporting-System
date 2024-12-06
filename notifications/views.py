from django.shortcuts import render, redirect
from .models import Notification

def notifications_view(request):
    notifications = request.user.notifications.filter(read=False)
    return render(request, 'notifications.html', {'notifications': notifications})

def mark_notification_as_read(request, pk):
    notification = Notification.objects.get(pk=pk)
    notification.mark_as_read()
    return redirect('notifications')