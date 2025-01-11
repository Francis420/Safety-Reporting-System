from django.shortcuts import render, redirect
from .models import Notification
from django.db import connection

def notifications_view(request):
    from django.db import connection

    with connection.cursor() as cursor:
        cursor.execute("SELECT COUNT(*) FROM notifications_notification WHERE user_id = %s AND `read` = 0", [request.user.id])
        notification_count = cursor.fetchone()[0]

        cursor.execute("""
            SELECT n.id, n.timestamp, n.message, n.receiver_id, n.`read`, r.user_id, r.category, r.description, r.location, u.username
            FROM notifications_notification n
            LEFT JOIN incidents_incidentreport r ON n.receiver_id = r.id
            LEFT JOIN accounts_customuser u ON r.user_id = u.id
            WHERE n.user_id = %s
            ORDER BY n.timestamp DESC
        """, [request.user.id])
        notifications = cursor.fetchall()

    notifications = [
        {
            'id': notification[0],
            'timestamp': notification[1],
            'message': notification[2],
            'receiver_id': notification[3],
            'read': notification[4],
            'receiver': {
                'id': notification[3],
                'user_id': notification[5],
                'category': notification[6],
                'description': notification[7],
                'location': notification[8],
                'username': notification[9]
            } if notification[3] else None
        }
        for notification in notifications
    ]

    return render(request, 'notifications/notifications.html', {'notifications': notifications, 'notification_count': notification_count})

def mark_notification_as_read(request, pk):
    from django.db import connection

    with connection.cursor() as cursor:
        cursor.execute("UPDATE notifications_notification SET `read` = 1 WHERE id = %s", [pk])

    return redirect('notifications')

def mark_notification_as_unread(request, pk):
    from django.db import connection

    with connection.cursor() as cursor:
        cursor.execute("UPDATE notifications_notification SET `read` = 0 WHERE id = %s", [pk])

    return redirect('notifications')