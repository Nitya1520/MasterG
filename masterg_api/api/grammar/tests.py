from django.contrib.auth.models import User
from rest_framework import status
from rest_framework.test import APITestCase


class GrammarProgressAPITests(APITestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='grammaruser', email='grammar@example.com', password='secret123')

    def test_progress_is_created_and_topic_completion_is_tracked(self):
        self.client.force_authenticate(user=self.user)

        response = self.client.get('/api/grammar/progress/')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['total_points'], 0)
        self.assertEqual(response.data['completed_topics'], 0)
        self.assertEqual(response.data['completed_topic_ids'], [])

        response = self.client.post('/api/grammar/complete/', {'topic_id': 'present_simple', 'correct_answers': 5}, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTrue(response.data['success'])
        self.assertFalse(response.data['already_completed'])
        self.assertEqual(response.data['points_awarded'], 10)
        self.assertEqual(response.data['total_points'], 10)
        self.assertEqual(response.data['completed_topics'], 1)
        self.assertIn('present_simple', response.data['completed_topic_ids'])

        response = self.client.post('/api/grammar/complete/', {'topic_id': 'present_simple', 'correct_answers': 5}, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTrue(response.data['already_completed'])
        self.assertEqual(response.data['points_awarded'], 0)
        self.assertEqual(response.data['completed_topics'], 1)

        response = self.client.post('/api/grammar/complete/', {'topic_id': 'articles', 'correct_answers': 5}, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['points_awarded'], 10)
        self.assertEqual(response.data['completed_topics'], 2)

        response = self.client.post('/api/grammar/complete/', {'topic_id': 'present_simple', 'correct_answers': 4}, format='json')
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertFalse(response.data['success'])

        response = self.client.post('/api/grammar/complete/', {'topic_id': 'not_a_real_topic', 'correct_answers': 5}, format='json')
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertFalse(response.data['success'])

    def test_unauthenticated_requests_are_rejected(self):
        response = self.client.get('/api/grammar/progress/')
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

        response = self.client.post('/api/grammar/complete/', {'topic_id': 'present_simple', 'correct_answers': 5}, format='json')
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)
