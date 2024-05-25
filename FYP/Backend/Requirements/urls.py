from django.urls import path, include
from . import views
from .views import *
from rest_framework.authtoken.views import obtain_auth_token
app_name = 'orders'

urlpatterns = [
    path('products/', views.ProductListCreateView.as_view(), name='product-list'),
    path('products/<int:pk>/', ProductRetrieveUpdateDestroyView.as_view(), name='product-detail'),
    path('customers/', CustomerListCreateView.as_view(), name='customer-list'),
    path('customers/<int:pk>/', CustomerRetrieveUpdateDestroyView.as_view(), name='customer-detail'),
    path('categories/', CategoryView.as_view(), name='category-list'),
    path('login/', obtain_auth_token),
    path('register/', RegisterView.as_view()),
    path('table/', TableView.as_view(), name='table-list'),
    path('reserve/', ReserveView.as_view(), name='reserve-list'),
    path('cart/', CartView.as_view(), name='cart-list'),
    path('order/', OrderView.as_view(), name='order-list'),
    path('addtocart/', AddToCart.as_view(), name='cart-list'),
    path('deletecartprod/', DeleteCartProduct.as_view(), name='delete-cart-product-list'),
    path('deletecart/', DeleteCart.as_view(), name='delete-cart-product-list'),
    path('review/', ReviewView.as_view(), name='review-list'),
    path('ordertrack/', OrderTrackListCreateView.as_view(), name='order-track-list'),
    path('orderTrack/<int:pk>/', OrderTrackRetrieveUpdateDestroyView.as_view(), name='order-track-detail'),

    path('', admin_login, name='admin_login'),
    path('dashboard/', dashboard, name='dashboard'),

    path('category/', views.category, name= 'category'),
    path('addcategory/', views.addcategory, name= 'addcategory'),
    path('editcategory/', views.editcategory, name= 'editcategory'),
    path('updatecategory/<str:id>', views.updatecategory, name= 'updatecategory'),
    path('deletecategory/<str:id>', views.deletecategory, name= 'deletecategory'),

    path('product/', products, name= 'product'),
    path('addproduct/', addproduct, name= 'addproduct'),
    path('editproduct/', views.editproduct, name= 'editproduct'),
    path('updateproduct/<str:id>', views.updateproduct, name= 'updateproduct'),
]
