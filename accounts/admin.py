from django.contrib import admin
from django.contrib.auth.models import Group, Permission
from django.contrib.contenttypes.models import ContentType
from .models import CustomUser

class CustomUserAdmin(admin.ModelAdmin):
    list_display = ('username', 'display_name', 'email', 'is_admin')

admin.site.register(CustomUser, CustomUserAdmin)

# Create groups and assign permissions
def create_groups_and_permissions():
    # Create groups
    user_group, created = Group.objects.get_or_create(name='User')
    admin_group, created = Group.objects.get_or_create(name='Admin')

    # Get permissions
    content_type = ContentType.objects.get_for_model(CustomUser)
    view_permission = Permission.objects.get(codename='view_customuser', content_type=content_type)
    change_permission = Permission.objects.get(codename='change_customuser', content_type=content_type)

    # Assign permissions to groups
    user_group.permissions.add(view_permission)
    admin_group.permissions.add(view_permission, change_permission)

# Call the function to create groups and permissions
create_groups_and_permissions()