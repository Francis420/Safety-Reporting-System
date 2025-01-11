from django import forms

class ConfirmAdminPasswordForm(forms.Form):
    password = forms.CharField(widget=forms.PasswordInput, label="Admin Password")