from django.contrib.auth.models import User
from django.db import models


class UserGrammarProgress(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='grammar_progress')
    total_points = models.IntegerField(default=0)
    completed_topics = models.IntegerField(default=0)
    completed_topic_ids = models.JSONField(default=list)
    last_completed_topic = models.CharField(max_length=100, null=True, blank=True)
    last_completed_at = models.DateTimeField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.user.username} Grammar Progress"
