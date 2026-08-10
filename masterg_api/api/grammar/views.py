from django.db import transaction
from django.utils import timezone
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import UserGrammarProgress
from .serializers import UserGrammarProgressSerializer

VALID_GRAMMAR_TOPIC_IDS = {
    'basic_sentence_structure',
    'subject_pronouns',
    'object_pronouns',
    'possessive_adjectives',
    'possessive_pronouns',
    'demonstratives',
    'singular_plural_nouns',
    'countable_uncountable_nouns',
    'articles',
    'am_is_are',
    'have_has',
    'there_is_there_are',
    'present_simple',
    'present_simple_negative',
    'present_simple_questions',
    'present_continuous',
    'present_simple_vs_continuous',
    'past_simple',
    'was_were',
    'regular_past_verbs',
    'common_irregular_verbs',
    'future_with_will',
    'going_to',
    'will_vs_going_to',
    'can_cant',
    'should_shouldnt',
    'must_mustnt',
    'have_to',
    'adjectives',
    'comparative_adjectives',
    'superlative_adjectives',
    'adverbs_of_frequency',
    'prepositions_of_time',
    'prepositions_of_place',
    'prepositions_of_movement',
    'some_any',
    'much_many',
    'a_lot_of',
    'a_few_a_little',
    'question_words',
    'how_much_how_many',
    'imperatives',
    'and_but_or',
    'because_so',
    'like_ing',
    'want_to',
    'need_to',
    'zero_conditional',
    'who_which_that',
    'sentence_connectors',
}

POINTS_PER_TOPIC = 10


class GrammarProgressView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        progress, created = UserGrammarProgress.objects.get_or_create(user=request.user)
        serializer = UserGrammarProgressSerializer(progress)
        return Response(serializer.data, status=status.HTTP_200_OK)


class GrammarCompleteView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        topic_id = request.data.get('topic_id')
        correct_answers = request.data.get('correct_answers')

        if topic_id not in VALID_GRAMMAR_TOPIC_IDS:
            return Response(
                {'success': False, 'message': 'Invalid grammar topic.'},
                status=status.HTTP_400_BAD_REQUEST,
            )

        if correct_answers != 5:
            return Response(
                {
                    'success': False,
                    'topic_completed': False,
                    'points_awarded': 0,
                    'message': 'You must answer all 5 questions correctly.',
                },
                status=status.HTTP_400_BAD_REQUEST,
            )

        with transaction.atomic():
            progress, _ = UserGrammarProgress.objects.select_for_update().get_or_create(user=request.user)
            completed_ids = list(progress.completed_topic_ids or [])

            if topic_id in completed_ids:
                return Response(
                    {
                        'success': True,
                        'already_completed': True,
                        'topic_id': topic_id,
                        'topic_completed': True,
                        'points_awarded': 0,
                        'total_points': progress.total_points,
                        'completed_topics': progress.completed_topics,
                        'completed_topic_ids': progress.completed_topic_ids or [],
                        'message': 'Topic was already completed.',
                    },
                    status=status.HTTP_200_OK,
                )

            completed_ids.append(topic_id)
            progress.completed_topic_ids = completed_ids
            progress.completed_topics = progress.completed_topics + 1
            progress.total_points = progress.total_points + POINTS_PER_TOPIC
            progress.last_completed_topic = topic_id
            progress.last_completed_at = timezone.now()
            progress.save()

            return Response(
                {
                    'success': True,
                    'already_completed': False,
                    'topic_id': topic_id,
                    'topic_completed': True,
                    'points_awarded': POINTS_PER_TOPIC,
                    'total_points': progress.total_points,
                    'completed_topics': progress.completed_topics,
                    'completed_topic_ids': progress.completed_topic_ids or [],
                    'message': 'Grammar topic completed successfully.',
                },
                status=status.HTTP_200_OK,
            )
