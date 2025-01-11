# Generated by Django 5.1.3 on 2025-01-11 00:19

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('incidents', '0003_alter_incidentreport_status'),
        ('notifications', '0007_rename_recipient_notification_user'),
    ]

    operations = [
        migrations.AddField(
            model_name='notification',
            name='target',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='notifications', to='incidents.incidentreport'),
        ),
    ]