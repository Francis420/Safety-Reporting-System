from django.urls import path
from .views import signup_view, login_view, custom_logout_view, update_profile_view, CustomPasswordChangeView, profile_view

urlpatterns = [
    path('signup/', signup_view, name='signup'),
    path('login/', login_view, name='login'),
    path('logout/', custom_logout_view, name='logout'),
    path('update_profile/', update_profile_view, name='update_profile'),
    path('change_password/', CustomPasswordChangeView.as_view(), name='change_password'),
    path('profile/', profile_view, name='profile'), 
]