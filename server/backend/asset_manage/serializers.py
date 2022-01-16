from dataclasses import fields
from rest_framework import serializers
from .models import AssetManage
from django.contrib.auth.models import User
    
class AssetManageSerializer(serializers.ModelSerializer):
    class Meta:
        model = AssetManage
        fields = '__all__'
