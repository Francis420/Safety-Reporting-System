from django import forms
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Fieldset, ButtonHolder, Submit
from .models import Feedback

class FeedbackForm(forms.ModelForm):
    helper = FormHelper()
    helper.form_method = 'POST'
    helper.layout = Layout(
        Fieldset(
            'Your Feedback',
            'feedback_text'
        ),
        ButtonHolder(
            Submit('submit', 'Submit Feedback', css_class='btn-primary')
        )
    )

    class Meta:
        model = Feedback
        fields = ['feedback_text']