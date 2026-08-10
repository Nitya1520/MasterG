from django.contrib import admin

from .models import UserGrammarProgress


@admin.register(UserGrammarProgress)
class UserGrammarProgressAdmin(admin.ModelAdmin):
    list_display = ('user', 'total_points', 'completed_topics', 'last_completed_topic', 'last_completed_at')
    search_fields = ('user__username', 'user__email', 'last_completed_topic')
