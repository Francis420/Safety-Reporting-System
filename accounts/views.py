from django.db import connection
from django.shortcuts import render, redirect
from django.contrib.auth import login, logout, authenticate
from django.contrib.auth.forms import AuthenticationForm
from django.urls import reverse
from django.contrib.auth.views import PasswordChangeView
from django.urls import reverse_lazy
from .forms import CustomUserCreationForm, CustomUserUpdateForm
from django.contrib.auth.decorators import login_required
from django.contrib.auth.hashers import make_password

def signup_view(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
            hashed_password = make_password(data['password1'])
            with connection.cursor() as cursor:
                cursor.execute(
                    "INSERT INTO accounts_customuser (password, username, first_name, last_name, email, is_staff, is_active, date_joined, is_admin, is_superuser) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                    [hashed_password, data['username'], data['first_name'], data['last_name'], data['email'], False, True, '2025-01-11 00:00:00', False, False]  # Include is_superuser
)
            user = authenticate(username=data['username'], password=data['password1'])
            login(request, user)
            return redirect('home')
    else:
        form = CustomUserCreationForm()
    return render(request, 'accounts/signup.html', {'form': form})

def login_view(request):
    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            data = form.cleaned_data
            with connection.cursor() as cursor:
                cursor.execute("SELECT * FROM accounts_customuser USE INDEX (idx_username) WHERE username = %s", [data['username']])
                user_row = cursor.fetchone()
                if user_row:
                    user = authenticate(username=data['username'], password=data['password'])
                    if user is not None:
                        login(request, user)
                        # Log the login action
                        cursor.execute(
                            "INSERT INTO audit_log (user_id, action, changes, timestamp) VALUES (%s, %s, %s, NOW())",
                            [user.id, 'logged in', '']
                        )
                        if user.is_admin:
                            return redirect(reverse('admin_panel:dashboard'))
                        else:
                            return redirect(reverse('incidents:user_dashboard'))
    else:
        form = AuthenticationForm()
    return render(request, 'accounts/login.html', {'form': form})

def custom_logout_view(request):
    user_id = request.user.id
    logout(request)
    with connection.cursor() as cursor:
        # Log the logout action
        cursor.execute(
            "INSERT INTO audit_log (user_id, action, changes, timestamp) VALUES (%s, %s, %s, NOW())",
            [user_id, 'logout', '']
        )
    return redirect('home')

@login_required
def update_profile_view(request):
    if request.method == 'POST':
        form = CustomUserUpdateForm(request.POST, instance=request.user)
        if form.is_valid():
            data = form.cleaned_data
            user_id = request.user.id

            try:
                with connection.cursor() as cursor:
                    # Set isolation level to Serializable before starting the transaction
                    cursor.execute("SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;")
                    
                    # Start transaction
                    cursor.execute("START TRANSACTION;")
                    
                    # Execute the update query
                    cursor.execute(
                        """
                        UPDATE accounts_customuser
                        SET first_name = %s, last_name = %s, email = %s, address = %s, phone_number = %s, display_name = %s, remarks = %s
                        WHERE id = %s
                        """,
                        [
                            data.get('first_name', ''), data.get('last_name', ''), data.get('email', ''), data.get('address', ''), 
                            data.get('phone_number', ''), data.get('display_name', ''), data.get('remarks', ''), user_id
                        ]
                    )
                    
                    # Commit the transaction
                    cursor.execute("COMMIT;")
                    
                return redirect('profile')
            except Exception as e:
                with connection.cursor() as cursor:
                    # Rollback the transaction in case of error
                    cursor.execute("ROLLBACK;")
                # Handle the error (e.g., log it, show an error message)
                print(f"Error updating profile: {e}")
    else:
        form = CustomUserUpdateForm(instance=request.user)
    return render(request, 'accounts/update_profile.html', {'form': form})

@login_required
def profile_view(request):
    with connection.cursor() as cursor:
        cursor.execute(
            "SELECT username, first_name, last_name, email, address, phone_number, display_name, remarks FROM accounts_customuser WHERE id = %s",
            [request.user.id]
        )
        user_data = cursor.fetchone()
    return render(request, 'accounts/profile.html', {'user_data': user_data})

class CustomPasswordChangeView(PasswordChangeView):
    template_name = 'accounts/change_password.html'
    success_url = reverse_lazy('profile')

    def form_valid(self, form):
        new_password = form.cleaned_data['new_password1']
        with connection.cursor() as cursor:
            cursor.execute(
                "UPDATE accounts_customuser SET password = %s WHERE id = %s",
                [make_password(new_password), self.request.user.id]
            )
        return super().form_valid(form)