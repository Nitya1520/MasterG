from django.urls import path

from .views import GrammarCompleteView, GrammarProgressView

urlpatterns = [
    path('progress/', GrammarProgressView.as_view(), name='grammar-progress'),
    path('complete/', GrammarCompleteView.as_view(), name='grammar-complete'),
]
