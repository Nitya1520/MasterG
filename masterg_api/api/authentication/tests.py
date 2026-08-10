from django.contrib.auth.models import User
from django.test import TestCase
from rest_framework import status
from rest_framework.test import APIClient

from grammar.models import UserGrammarProgress


class RegistrationTests(TestCase):
    def setUp(self):
        self.client = APIClient()

    def test_register_creates_grammar_progress(self):
        response = self.client.post(
            '/api/auth/register/',
            {'email': 'newuser@example.com', 'password': 'secret123'},
            format='json',
        )

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        user = User.objects.get(email='newuser@example.com')
        self.assertTrue(UserGrammarProgress.objects.filter(user=user).exists())
