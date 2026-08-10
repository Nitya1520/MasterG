from rest_framework import serializers

from .models import UserGrammarProgress


class UserGrammarProgressSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserGrammarProgress
        fields = (
            'total_points',
            'completed_topics',
            'completed_topic_ids',
            'last_completed_topic',
            'last_completed_at',
        )
