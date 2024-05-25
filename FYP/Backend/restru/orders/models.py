from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
from django.core.validators import MaxValueValidator


class Customer(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    allergy = models.CharField(max_length=100)
    # Other customer fields

    def __str__(self):
        return f"user={self.user.username} "
    
class Product(models.Model):
    name = models.CharField(max_length=100)
    price = models.DecimalField(max_digits=8, decimal_places=2)
    description = models.TextField()
    category = models.ForeignKey('Category', on_delete=models.CASCADE)
    image_path = models.ImageField(upload_to="products/")
    # Other product fields

    def __str__(self):
        return self.name

class Table(models.Model):
    tname = models.CharField(max_length=100)
    chairs =  models.PositiveIntegerField()
    price = models.DecimalField(max_digits=8, decimal_places=2)
    table_desc = models.TextField()
    image_path = models.ImageField(upload_to="tables/")

    def __str__(self):
        return self.tname

class Reserve(models.Model):
    table = models.ForeignKey(Table, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    isReserved = models.BooleanField(default=False)

    def __str__(self):
        return f"table ID={self.table.id} user={self.user.username} | ISReserved={self.isReserved}"

class ReserveResponse(models.Model):
    table = models.OneToOneField(Table, on_delete=models.CASCADE)
    email = models.CharField(max_length=150)
    phone = models.CharField(max_length=13)
    date = models.DateField()
    time = models.TimeField()

class Category(models.Model):
    name = models.CharField(max_length=100)
    #Other category fields

    def __str__(self):
        return self.name


class Cart(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    total = models.PositiveIntegerField()
    isCompleted = models.BooleanField(default=False)
    date = models.DateField(auto_now_add=True)

    def __str__(self):
        return f"User={self.user.username}|ISCompleted={self.isCompleted}"


class CartProduct(models.Model):
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE)
    product = models.ManyToManyField(Product)
    price = models.PositiveIntegerField()
    quantity = models.PositiveIntegerField()
    subtotal = models.PositiveIntegerField()

    def __str__(self):
        return f"Cart=={self.cart.id}<==>CartProduct:{self.id}==Qualtity=={self.quantity}"


class Order(models.Model):
    cart = models.OneToOneField(Cart, on_delete=models.CASCADE)
    email = models.CharField(max_length=150)
    phone = models.CharField(max_length=13)

class Review(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    rating = models.FloatField(validators=[MaxValueValidator(5.0)], default=0)
    comment = models.TextField(max_length=500) 

    def __str__(self):
        return f"User={self.user.username} | Rating={self.rating}"
    
class OrderTrack(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    status = models.CharField(max_length=20, choices=(
        ('PENDING', 'Pending'),
        ('PROCESSING', 'Processing'),
        ('COMPLETED', 'Completed'),
    ))
    # Other order fields

    def __str__(self):
        return f"Order #{self.id} - {self.user.username}"
