from django.db import models
from django.contrib.auth.models import User
class Transaction(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    ticker = models.CharField(max_length=10)
    price = models.IntegerField()

    def __str__(self):
        return f"{self.user.username} / {self.ticker} / {self.price}"

    @property
    def user_name(self):
        return self.user.username
    
