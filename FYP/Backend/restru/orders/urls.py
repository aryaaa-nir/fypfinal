from django.urls import path, include
from . import views
from .views import *
from rest_framework.authtoken.views import obtain_auth_token
app_name = 'orders'

urlpatterns = [
    path('products/', views.ProductListCreateView.as_view(), name='product-list'),
    path('products/<int:pk>/', views.ProductRetrieveUpdateDestroyView.as_view(), name='product-detail'),
    path('customers/', views.CustomerListCreateView.as_view(), name='customer-list'),
    path('customers/<int:pk>/', views.CustomerRetrieveUpdateDestroyView.as_view(), name='customer-detail'),
    path('categories/', views.CategoryView.as_view(), name='category-list'),
    path('login/', obtain_auth_token),
    path('register/', views.RegisterView.as_view()),
    path('table/', views.TableView.as_view(), name='table-list'),
    path('reserve/', views.ReserveView.as_view(), name='reserve-list'),
    # path('reserveresponse/', views.ReserveResponseCreate.as_view(), name='reserveresponse'),
    path('cart/', views.CartView.as_view(), name='cart-list'),
    path('order/', views.OrderView.as_view(), name='order-list'),
    path('addtocart/', views.AddToCart.as_view(), name='cart-list'),
    path('deletecartprod/', views.DeleteCartProduct.as_view(), name='delete-cart-product-list'),
    path('deletecart/', views.DeleteCart.as_view(), name='delete-cart-product-list'),
    path('ordernow/', views.OrderCreate.as_view(), name='order-now' ),
    path('review/', views.ReviewView.as_view(), name='review-list'),
    # path('ordertrack/', views.OrderTrackListCreateView.as_view(), name='order-track-list'),
    # path('orderTrack/<int:pk>/', views.OrderTrackRetrieveUpdateDestroyView.as_view(), name='order-track-detail'),
    path('profile/', views.UserProfileView.as_view(), name='profile'),
    path('category/', views.CategoryView.as_view()),

    # path('profile/<int:pk>/', views.ProfileRetrieveUpdateDestroyView.as_view(), name='order-track-detail'),


    path('', views.admin_login, name='admin_login'),
    path('dashboard/', views.dashboard, name='dashboard'),
    path('logout/', views.logout_view, name='logout'),

    path('category/', views.category, name= 'category'),
    path('addcategory/', views.addcategory, name= 'addcategory'),
    path('editcategory/', views.editcategory, name= 'editcategory'),
    path('updatecategory/<str:id>', views.updatecategory, name= 'updatecategory'),
    path('deletecategory/<str:id>', views.deletecategory, name= 'deletecategory'),

    path('product/', views.products, name= 'product'),
    path('addproduct/', views.addproduct, name= 'addproduct'),
    path('editproduct/', views.editproduct, name= 'editproduct'),
    path('updateproduct/<str:id>', views.updateproduct, name= 'updateproduct'),
    

    path('tables/', views.tables, name= 'tables'),
    path('addtables/', views.addtables, name= 'addtables'),
    path('edittables/', views.edittables, name= 'edittables'),
    path('updatetables/<str:id>', views.updatetables, name= 'updatetables'),
    path('deletetables/<str:id>', views.deletetables, name= 'deletetables'),
]
