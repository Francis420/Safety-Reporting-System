from django import forms
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Fieldset, ButtonHolder, Submit
from .models import IncidentReport

class IncidentReportForm(forms.ModelForm):
    helper = FormHelper()
    helper.form_method = 'POST'
    helper.layout = Layout(
        Fieldset(
            'Report an Incident',
            'category',
            'description',
            'location',
            'latitude',
            'longitude'
        ),
        ButtonHolder(
            Submit('submit', 'Submit Report', css_class='btn-primary')
        )
    )

    class Meta:
        model = IncidentReport
        fields = ['category', 'description', 'location', 'latitude', 'longitude']
        widgets = {
            'latitude': forms.HiddenInput(),
            'longitude': forms.HiddenInput(),
        }