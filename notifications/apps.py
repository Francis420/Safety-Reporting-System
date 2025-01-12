from django.apps import AppConfig

class NotificationsConfig(AppConfig):
    name = 'notifications'

    def ready(self):
        import notifications.signals
        print("Notifications signals imported")