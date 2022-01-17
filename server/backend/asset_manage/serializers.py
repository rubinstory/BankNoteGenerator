from dataclasses import fields
from rest_framework import serializers
from .models import AssetManage
from django.contrib.auth.models import User
from transaction.serializers import UserSerializer
    
class AssetManageSerializer(serializers.ModelSerializer):
    # user = UserSerializer()
    class Meta:
        model = AssetManage
        fields = '__all__'
