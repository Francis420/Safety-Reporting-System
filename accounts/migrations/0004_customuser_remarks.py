# Generated by Django 5.1.3 on 2025-01-11 01:53

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0003_customuser_display_name'),
    ]

    operations = [
        migrations.AddField(
            model_name='customuser',
            name='remarks',
            field=models.TextField(blank=True, null=True),
        ),
    ]
