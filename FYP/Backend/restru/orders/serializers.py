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

# class Userserializer(serializers.ModelSerializer):
#     class Meta:
#         model = User
#         fields = ('id', 'username', 'password',
#                   'first_name', 'last_name', 'email', )
#         extra_kwargs = {'password': {"write_only": True, 'required': True}}

#     def create(self , validated_data):
#         user = User.objects.create_user(**validated_data)
#         Token.objects.create(user=user)
#         return user

class UserSerializer(serializers.ModelSerializer):
    allergy = serializers.CharField(source='customer.allergy', required=False)

    class Meta:
        model = User
        fields = ['username', 'password', 'allergy']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        allergy = validated_data.pop('customer')['allergy']
        user = User.objects.create_user(**validated_data)
        Customer.objects.create(user=user, allergy=allergy)
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