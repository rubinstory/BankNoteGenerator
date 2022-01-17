from django.db import models
from django.contrib.auth.models import User

class Transaction(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    market = models.CharField(max_length=10, default="")
    side = models.CharField(max_length=10, default="")
    size = models.FloatField(default=0)
    avgFillPrice = models.FloatField(default=0)
    createdAt = models.CharField(max_length=100, default="")

    def __str__(self):
        return f'{self.market}/{self.user.username}'
    
