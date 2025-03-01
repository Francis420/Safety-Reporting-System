from django import forms
from django.contrib.auth.forms import UserCreationForm
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Fieldset, ButtonHolder, Submit
from .models import CustomUser


class CustomUserCreationForm(UserCreationForm):
    helper = FormHelper()
    helper.form_method = 'POST'
    helper.layout = Layout(
        Fieldset(
            'Create your account',
            'username',
            'password1',
            'password2',
            'first_name',
            'last_name',
            'email',
            'address',
            'phone_number',
            'display_name',
        ),
        ButtonHolder(
            Submit('submit', 'Create Account', css_class='btn-primary')
        )
    )

    class Meta:
        model = CustomUser
        fields = (
            'first_name', 
            'last_name', 
            'display_name', 
            'username', 
            'password1', 
            'password2', 
            'email', 
            'address', 
            'phone_number')

class CustomUserUpdateForm(forms.ModelForm):
    helper = FormHelper()
    helper.form_method = 'POST'
    helper.layout = Layout(
        Fieldset(
            'Update your information',
            'first_name',
            'last_name',
            'email',
            'address',
            'phone_number',
            'display_name'
        ),
        ButtonHolder(
            Submit('submit', 'Update', css_class='btn-primary')
        )
    )

    class Meta:
        model = CustomUser
        fields = ('first_name', 'last_name', 'email', 'address', 'phone_number', 'display_name')