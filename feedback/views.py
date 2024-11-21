from django.shortcuts import render, redirect
from .forms import UserFeedbackForm
from .models import UserFeedback

def submit_feedback_view(request):
    if request.method == 'POST':
        form = UserFeedbackForm(request.POST)
        if form.is_valid():
            feedback = form.save(commit=False)
            feedback.user = request.user
            feedback.save()
            return redirect('feedback_thanks')
    else:
        form = UserFeedbackForm()
    return render(request, 'feedback/submit_feedback.html', {'form': form})

def feedback_thanks_view(request):
    return render(request, 'feedback/feedback_thanks.html')

def feedback_list_view(request):
    feedbacks = UserFeedback.objects.all().order_by('-created_at')
    return render(request, 'feedback/feedback_list.html', {'feedbacks': feedbacks})