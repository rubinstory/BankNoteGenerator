from django.db import models
from django.contrib.auth.models import User

class AssetManage(models.Model):
    ASSET_MANAGE_TYPE = (
        ('A', 'TYPE-A'),
        ('B', 'TYPE-B'),
        ('C', 'TYPE-C'),
        ('D', 'TYPE-D'),
    )
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='user')
    algorithm_type = models.CharField(max_length = 2, choices = ASSET_MANAGE_TYPE, null=True, blank=True)
    answer_to_question_1 = models.IntegerField()
    answer_to_question_2 = models.IntegerField()
    answer_to_question_3 = models.IntegerField()

