from django.shortcuts import render
from rest_framework import viewsets
from .serializers import TransactionSerializer, UserSerializer
from .models import Transaction
from django.contrib.auth.models import User

class TransactionViewSet(viewsets.ModelViewSet):
    queryset = Transaction.objects.all()
    serializer_class = TransactionSerializer

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

