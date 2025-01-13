from django.shortcuts import render, redirect
from .forms import FeedbackForm
from django.contrib.auth.decorators import login_required, user_passes_test
from .models import Feedback
from django.db.models import Q
from datetime import datetime
from django.db import connection
from django.core.paginator import Paginator



def is_admin(user):
    return user.is_admin


@login_required 
@user_passes_test(is_admin)
def feedback_list_view(request):
    query = request.GET.get('q', '')
    from_datetime = request.GET.get('from')
    to_datetime = request.GET.get('to')
    page = request.GET.get('page', 1)

    sql = """
    SELECT f.id, f.feedback_message, f.user_id, f.created_at, u.username
    FROM feedback_feedback f
    JOIN accounts_customuser u ON f.user_id = u.id
    WHERE 1=1
    """
    params = []

    if query:
        sql += " AND (f.feedback_message LIKE %s OR u.username LIKE %s)"
        params.extend([f"%{query}%", f"%{query}%"])

    if from_datetime:
        sql += " AND f.created_at >= %s"
        params.append(datetime.strptime(from_datetime, '%Y-%m-%dT%H:%M'))

    if to_datetime:
        sql += " AND f.created_at <= %s"
        params.append(datetime.strptime(to_datetime, '%Y-%m-%dT%H:%M'))

    sql += " ORDER BY f.created_at DESC"

    with connection.cursor() as cursor:
        cursor.execute(sql, params)
        feedbacks = cursor.fetchall()

    feedback_list = [
        {
            'id': feedback[0],
            'feedback_message': feedback[1],
            'user_id': feedback[2],
            'created_at': feedback[3],
            'username': feedback[4]
        }
        for feedback in feedbacks
    ]

    paginator = Paginator(feedback_list, 10)  # Show 10 feedbacks per page
    feedbacks_page = paginator.get_page(page)

    return render(request, 'feedback/feedback_list.html', {
        'feedbacks': feedbacks_page,
        'from_datetime': from_datetime,
        'to_datetime': to_datetime,
        'query': query
    })


@login_required
def submit_feedback_view(request):
    if request.method == 'POST':
        form = FeedbackForm(request.POST)
        if form.is_valid():
            feedback_message = form.cleaned_data['feedback_message']
            user_id = request.user.id

            sql = "INSERT INTO feedback_feedback (feedback_message, user_id, created_at) VALUES (%s, %s, NOW())"
            params = [feedback_message, user_id]

            with connection.cursor() as cursor:
                cursor.execute(sql, params)

            return redirect('feedback_thanks')
    else:
        form = FeedbackForm()
    return render(request, 'feedback/submit_feedback.html', {'form': form})


def feedback_thank_you_view(request):
    return render(request, 'feedback/feedback_thanks.html')


def feedback_detail_view(request, pk):
    sql = """
    SELECT f.id, f.feedback_message, f.created_at, u.username
    FROM feedback_feedback f
    JOIN accounts_customuser u ON f.user_id = u.id
    WHERE f.id = %s
    """
    params = [pk]

    with connection.cursor() as cursor:
        cursor.execute(sql, params)
        feedback = cursor.fetchone()

    if feedback:
        feedback_data = {
            'id': feedback[0],
            'feedback_message': feedback[1],
            'created_at': feedback[2],
            'username': feedback[3]
        }
    else:
        feedback_data = None

    return render(request, 'feedback/feedback_detail.html', {'feedback': feedback_data})