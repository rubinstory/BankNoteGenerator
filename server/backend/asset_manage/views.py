from django.shortcuts import render
from rest_framework import viewsets
from .serializers import AssetManageSerializer
from .models import AssetManage
from django.contrib.auth.models import User
from django.core import serializers
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import filters
from rest_framework.response import Response
from django.http import HttpResponse

def calculate_type(a1, a2, a3):
    result = (6 - a1) + a2 + a3
    if result == 3:
        return 'D'
    elif result <= 7:
        return 'C'
    elif result <= 11:
        return 'B'
    return 'A'

class AssetManageViewSet(viewsets.ModelViewSet):
    queryset = AssetManage.objects.all()
    serializer_class = AssetManageSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['user']
    
    def create(self, request, *args, **kwargs):
        if AssetManage.objects.get(user=request.POST['user']):
            instance = AssetManage.objects.get(user=request.POST['user'])
            instance.answer_to_question_1 = int(request.POST['answer_to_question_1'])
            instance.answer_to_question_2 = int(request.POST['answer_to_question_2'])
            instance.answer_to_question_3 = int(request.POST['answer_to_question_3'])
            instance.algorithm_type = calculate_type(instance.answer_to_question_1, instance.answer_to_question_2, instance.answer_to_question_3)
            instance.save()
            instance = AssetManageSerializer(instance).data
            return Response(instance)
        else:
            instance = self.get_object()
            serlaizer = self.serialize(instance, data=request.data, partial=True)
            serlaizer.save()
            return Response(serlaizer.data)

    # def create(self, request):
    #     print(request.POST.get('user'))
    #     if AssetManage.objects.get(user=request.POST.get('user')):
    #         obj = AssetManage.objects.get(user=request.POST.get('user'))
    #     else:
    #         obj = AssetManage.objects.create(**request)
    #     obj.algorithm_type = calculate_type(obj.answer_to_question_1, obj.answer_to_question_2, obj.answer_to_question_3)
    #     obj.save()
    #     return Response(serializers.serialize('json', obj))


