from django.shortcuts import render, get_object_or_404
from rest_framework import viewsets
from .serializers import AssetManageSerializer
from .models import AssetManage
from django.contrib.auth.models import User
from django.core import serializers
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import filters
from rest_framework.response import Response
from django.http import HttpResponse
import json
import requests

def pretty_request(request):
    headers = ''
    for header, value in request.META.items():
        if not header.startswith('HTTP'):
            continue
        header = '-'.join([h.capitalize() for h in header[5:].lower().split('_')])
        headers += '{}: {}\n'.format(header, value)

    return (
        '{method} HTTP/1.1\n'
        'Content-Length: {content_length}\n'
        'Content-Type: {content_type}\n'
        '{headers}\n\n'
        '{body}'
    ).format(
        method=request.method,
        content_length=request.META['CONTENT_LENGTH'],
        content_type=request.META['CONTENT_TYPE'],
        headers=headers,
        body=request.body,
    )

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

    def get_queryset(self, *args, **kwargs):
        try :
            return AssetManage.objects.filter(user=int(self.kwargs['pk'])).first()
        except:
            return AssetManage.objects.all()

    def get_object(self):
        queryset = self.get_queryset()
        return queryset
    
    def create(self, request, *args, **kwargs):
        if len(AssetManage.objects.filter(user=int(request.data.get('user')))) > 0:
            instance = AssetManage.objects.get(user=int(request.data.get('user')))

            try:
                instance.automatic_investment_status = bool(request.data.get('automatic_investment_status'))
            except:
                instance.automatic_investment_status = False

            instance.answer_to_question_1 = int(request.data.get('answer_to_question_1'))
            instance.answer_to_question_2 = int(request.data.get('answer_to_question_2'))
            instance.answer_to_question_3 = int(request.data.get('answer_to_question_3'))
            instance.algorithm_type = calculate_type(instance.answer_to_question_1, instance.answer_to_question_2, instance.answer_to_question_3)
            instance.save()

            url = "http://49.247.36.104/"
            body = {
                            'api_key':'Pf7HJ-5WRBgzt0eS1myGPC2DQc7WVrVqwXoLGX2R',
                            'api_secret': 'h0skte3bRU8qsoEUFkBUX4LBnNawMcJusbyKuNIC',
                            'user_type': instance.algorithm_type,
                            'user': instance.user,

                        }
            print(json.dumps(body))
            if instance.automatic_investment_status == True:
                url += "start"
                response = requests.post(url, json=body)
                print(response)
            else:
                url += "stop"
                response = requests.post(url,json=body)
                print(response)

            instance = AssetManageSerializer(instance).data
            return Response(instance)
        else:
            serlaizer = AssetManageSerializer(data=request.data)
            serlaizer.is_valid(raise_exception=True)
            serlaizer.save()
            return Response(serlaizer.data)



