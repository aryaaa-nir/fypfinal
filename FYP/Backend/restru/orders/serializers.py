from rest_framework import serializers
from .models import *
from django.contrib.auth import get_user_model
from rest_framework.authtoken.models import Token

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'
        depth = 1

User = get_user_model()

class TableSerializer(serializers.ModelSerializer):
    class Meta:
        model = Table
        fields = "__all__"
        depth = 1
User = get_user_model()


class ReserveSerializer(serializers.ModelSerializer):
    class Meta:
        model = Reserve
        fields = "__all__"
        depth = 1

class ReserveResponseSerializers(serializers.ModelSerializer):
    class Meta:
        model = ReserveResponse
        fields = '__all__'
        depth = 1


# class UserSerializer(serializers.ModelSerializer):
#     allergy = serializers.CharField(source='customer.allergy', required=False)

#     class Meta:
#         model = User
#         fields = ['username', 'password', 'allergy']
#         extra_kwargs = {'password': {'write_only': True}}

#     def create(self, validated_data):
#         allergy = validated_data.pop('customer')['allergy']
#         user = User.objects.create_user(**validated_data)
#         Customer.objects.create(user=user, allergy=allergy)
#         return user

class UserSerializer(serializers.ModelSerializer):
    allergy = serializers.CharField(source='customer.allergy', required=False)
    phone = serializers.CharField(source='customer.phone', required=False)

    class Meta:
        model = User
        fields = ['username', 'password', 'allergy', 'phone']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        customer_data = validated_data.pop('customer', {})
        allergy = customer_data.get('allergy', '')
        phone = customer_data.get('phone', '')
        
        user = User.objects.create_user(**validated_data)
        Customer.objects.create(user=user, allergy=allergy, phone=phone)
        return user

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'

class CustomerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Customer
        fields = '__all__'
        depth = 1

class CartSerializers(serializers.ModelSerializer):
    class Meta:
        model = Cart
        fields = '__all__'

class CartProductSerializers(serializers.ModelSerializer):
    class Meta:
        model = CartProduct
        fields = '__all__'
        depth = 1

class OrdersSerializers(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = '__all__'
        depth = 1


class ReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = Review
        fields = '__all__'
        depth = 1


class OrderTrackSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderTrack
        fields = '__all__'
        depth = 1