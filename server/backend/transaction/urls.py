from django.urls import path,include
from rest_framework import routers
from transaction.views import TransactionViewSet, UserViewSet

transaction_router = routers.DefaultRouter()
transaction_router.register('transaction', TransactionViewSet)

# user_router = routers.DefaultRouter()
# user_router.register('user', UserViewSet)

urlpatterns = [
    path('', include(transaction_router.urls)),
    # path('', include(user_router.urls)),
]
