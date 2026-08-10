from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.models import User
from django.utils import timezone
from datetime import date, timedelta
from .models import UserProfile, Vocabulary, VocabularySentence, DailyVocabularyProgress



def get_user_profile(user):
    profile, created = UserProfile.objects.get_or_create(
        user=user,
        defaults={
            'current_streak': 12,
            'a1_pointer': 45,
            'a2_pointer': 12,
            'b1_pointer': 0,
            'b2_pointer': 0,
            'c1_pointer': 0,
            'c2_pointer': 0,
            'last_learning_date': timezone.now().date() - timedelta(days=1)
        }
    )
    return profile

def get_user_from_request(request):
    if request.user and request.user.is_authenticated:
        return request.user
    # Fallback to first user for easy local testing
    user = User.objects.first()
    if not user:
        user = User.objects.create_user(username='guest', email='guest@masterg.com', password='password123')
    return user

@api_view(['GET'])
@permission_classes([AllowAny])
def levels_view(request):
    user = get_user_from_request(request)
    profile = get_user_profile(user)

    return Response([
        {"level": "A1", "learned_words": profile.a1_pointer},
        {"level": "A2", "learned_words": profile.a2_pointer},
        {"level": "B1", "learned_words": profile.b1_pointer},
        {"level": "B2", "learned_words": profile.b2_pointer},
        {"level": "C1", "learned_words": profile.c1_pointer},
        {"level": "C2", "learned_words": profile.c2_pointer},
    ], status=status.HTTP_200_OK)

@api_view(['GET'])
@permission_classes([AllowAny])
def current_word_view(request):
    user = get_user_from_request(request)
    profile = get_user_profile(user)
    level = request.query_params.get('level', 'A1')

    # Get pointer for selected level
    pointer = 0
    if level == 'A1':
        pointer = profile.a1_pointer
    elif level == 'A2':
        pointer = profile.a2_pointer
    elif level == 'B1':
        pointer = profile.b1_pointer
    elif level == 'B2':
        pointer = profile.b2_pointer
    elif level == 'C1':
        pointer = profile.c1_pointer
    elif level == 'C2':
        pointer = profile.c2_pointer

    # Fetch word matching level and wrapped word_no
    level_words = Vocabulary.objects.filter(level=level)
    if not level_words.exists():
        return Response({"error": "No words found for this level"}, status=status.HTTP_404_NOT_FOUND)

    word_index = pointer % level_words.count()
    word = level_words.all()[word_index]

    # Get daily progress
    today = timezone.now().date()
    progress, _ = DailyVocabularyProgress.objects.get_or_create(user=user, date=today)

    return Response({
        "word_no": pointer + 1,
        "word": word.word,
        "pronunciation": word.pronunciation,
        "gujarati_meaning": word.gujarati_meaning,
        "english_meaning": word.english_meaning,
        "sentences": [s.sentence for s in word.sentences.all()],
        "today_progress": progress.completed_words,
        "today_target": 5,
        "streak": profile.current_streak
    }, status=status.HTTP_200_OK)

@api_view(['POST'])
@permission_classes([AllowAny])
def next_word_view(request):
    user = get_user_from_request(request)
    profile = get_user_profile(user)
    level = request.data.get('level', 'A1')

    # Increment pointer
    if level == 'A1':
        profile.a1_pointer += 1
        pointer = profile.a1_pointer
    elif level == 'A2':
        profile.a2_pointer += 1
        pointer = profile.a2_pointer
    elif level == 'B1':
        profile.b1_pointer += 1
        pointer = profile.b1_pointer
    elif level == 'B2':
        profile.b2_pointer += 1
        pointer = profile.b2_pointer
    elif level == 'C1':
        profile.c1_pointer += 1
        pointer = profile.c1_pointer
    elif level == 'C2':
        profile.c2_pointer += 1
        pointer = profile.c2_pointer
    else:
        pointer = 0

    profile.save()

    # Update Daily Progress
    today = timezone.now().date()
    progress, _ = DailyVocabularyProgress.objects.get_or_create(user=user, date=today)
    progress.completed_words += 1
    progress.save()

    # Check daily target completed (5 words)
    just_completed = False
    if progress.completed_words >= 5:
        # Streak Logic
        last_date = profile.last_learning_date
        
        if last_date != today:
            if last_date == today - timedelta(days=1):
                # Completed yesterday, increment streak
                profile.current_streak += 1
            else:
                # Missed a day or first learning
                profile.current_streak = 1
            profile.last_learning_date = today
            profile.save()

        if progress.completed_words == 5:
            just_completed = True

    # Return next word details
    level_words = Vocabulary.objects.filter(level=level)
    word_index = pointer % level_words.count()
    word = level_words.all()[word_index]

    return Response({
        "word_no": pointer + 1,
        "word": word.word,
        "pronunciation": word.pronunciation,
        "gujarati_meaning": word.gujarati_meaning,
        "english_meaning": word.english_meaning,
        "sentences": [s.sentence for s in word.sentences.all()],
        "today_progress": progress.completed_words,
        "today_target": 5,
        "streak": profile.current_streak,
        "daily_completed": just_completed
    }, status=status.HTTP_200_OK)

@api_view(['GET'])
@permission_classes([AllowAny])
def user_profile_view(request):
    user = get_user_from_request(request)
    profile = get_user_profile(user)
    
    # Get daily progress
    today = timezone.now().date()
    progress, _ = DailyVocabularyProgress.objects.get_or_create(user=user, date=today)

    words_learned = (
        profile.a1_pointer +
        profile.a2_pointer +
        profile.b1_pointer +
        profile.b2_pointer +
        profile.c1_pointer +
        profile.c2_pointer
    )

    display_name = user.email.split('@')[0].capitalize()
    return Response({
        "username": display_name,
        "streak": profile.current_streak,
        "today_progress": progress.completed_words,
        "words_learned": words_learned,
    }, status=status.HTTP_200_OK)
