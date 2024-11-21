from django.shortcuts import render, redirect
from .models import Notification

def notifications_list_view(request):
    notifications = Notification.objects.filter(user=request.user).order_by('-created_at')
    return render(request, 'notifications/notifications_list.html', {'notifications': notifications})

def mark_as_read_view(request, notification_id):
    notification = Notification.objects.get(id=notification_id, user=request.user)
    notification.read = True
    notification.save()
    return redirect('notifications_list')
