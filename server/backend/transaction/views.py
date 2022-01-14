from django.shortcuts import render
from rest_framework import viewsets
from .serializers import TransactionSerializer, UserSerializer
from .models import Transaction
from django.contrib.auth.models import User
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import filters

class TransactionViewSet(viewsets.ModelViewSet):
    queryset = Transaction.objects.all()
    serializer_class = TransactionSerializer
    filter_backends = [filters.SearchFilter , DjangoFilterBackend]
    filterset_fields = ['user', 'ticker']
    search_fields = ['user__username']



class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

