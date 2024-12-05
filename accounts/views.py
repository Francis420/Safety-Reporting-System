from django.shortcuts import render, redirect
from django.contrib.auth import login
from .forms import CustomUserCreationForm
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth import logout
from django.urls import reverse
from django.contrib.auth.views import PasswordChangeView
from django.urls import reverse_lazy
from .forms import CustomUserUpdateForm
from django.contrib.auth.decorators import login_required

def signup_view(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect('home')
    else:
        form = CustomUserCreationForm()
    return render(request, 'accounts/signup.html', {'form': form})

def login_view(request):
    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            if user.is_admin:
                return redirect(reverse('admin_panel:dashboard'))
            else:
                return redirect(reverse('user_dashboard'))
    else:
        form = AuthenticationForm()
    return render(request, 'accounts/login.html', {'form': form})

def custom_logout_view(request):
    logout(request)
    return redirect('home')

@login_required
def update_profile_view(request):
    if request.method == 'POST':
        form = CustomUserUpdateForm(request.POST, instance=request.user)
        if form.is_valid():
            form.save()
            return redirect('profile') 
    else:
        form = CustomUserUpdateForm(instance=request.user)
    return render(request, 'accounts/update_profile.html', {'form': form})

@login_required
def profile_view(request):
    return render(request, 'accounts/profile.html')

class CustomPasswordChangeView(PasswordChangeView):
    template_name = 'accounts/change_password.html'
    success_url = reverse_lazy('profile')