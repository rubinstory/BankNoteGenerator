from dataclasses import fields
from rest_framework import serializers
from .models import Transaction
from django.contrib.auth.models import User


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'


class TransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Transaction
        fields = ('id', 'ticker', 'price', 'user', 'user_name')