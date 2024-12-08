from django.urls import path
from .views import submit_feedback_view, feedback_thank_you_view, feedback_list_view

urlpatterns = [
    path('submit/', submit_feedback_view, name='submit_feedback'),
    path('thanks/', feedback_thank_you_view, name='feedback_thanks'),
    path('list/', feedback_list_view, name='feedback_list'),
]