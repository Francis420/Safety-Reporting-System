# Generated by Django 5.1.3 on 2024-11-21 10:21

from django.conf import settings
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('feedback', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.RenameModel(
            old_name='Feedback',
            new_name='UserFeedback',
        ),
    ]
