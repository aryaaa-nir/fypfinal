from django.contrib.auth import logout
from django.contrib import messages
from django.http import HttpResponseRedirect
from rest_framework import generics, status
from .serializers import *
from .models import *
from .urls import *
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import get_object_or_404, render, redirect
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from .forms import *
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import UserSerializer
import logging
logger = logging.getLogger(__name__)


class ProductListCreateView(generics.ListCreateAPIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]
    queryset = Product.objects.all()
    serializer_class = ProductSerializer


class ProductRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

class CategoryView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        query = Category.objects.all()
        serializer = CategorySerializer(query, many=True)
        return Response(serializer.data)


class TableView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        query = Table.objects.all()
        data = []
        serializers = TableSerializer(query, many=True)
        for table in serializers.data:
            reserve_query = Reserve.objects.filter(
                user=request.user).filter(table_id=table['id'])
            if reserve_query:
                table['reserve'] = reserve_query[0].isReserved
            else:
                table['reserve'] = False
            data.append(table)
        return Response(data)



class ReserveView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        data = request.data.get('id')  # Correctly access 'id' from request.data
        try:
            table_obj = Table.objects.get(id=data)
            user = request.user
            single_reserved_table = Reserve.objects.filter(
                user=user, table=table_obj).first()  # Simplify filter expression
            if single_reserved_table:
                print("single_reserved_table")
                ccc = single_reserved_table.isReserved
                single_reserved_table.isReserved = not ccc
                single_reserved_table.save()
            else:
                Reserve.objects.create(table=table_obj, user=user, isReserved=True)
            response_msg = {'error': False}
        except Table.DoesNotExist:
            response_msg = {'error': True, 'message': 'Table does not exist'}
        except Exception as e:
            response_msg = {'error': True, 'message': str(e)}
        return Response(response_msg)
    

# class ReserveResponseCreate(APIView):
#     permission_classes = [IsAuthenticated, ]
#     authentication_classes = [TokenAuthentication, ]

#     def post(self, request):
#         try:
#             data = request.data
#             table_id = data['tableid']
#             email = data['email']
#             phone = data['phone']
#             date = data['date']
#             time = data['time']
#             table_obj = Cart.objects.get(id=table_id)
#             table_obj.isComplit = True
#             table_obj.save()
#             ReserveResponse.objects.create(
#                 table=table_obj,
#                 email=email,
#                 phone=phone,
#                 date=date,
#                 time=time,
#             )
#             response_msg = {"error": False, "message": "Your Reservation is Completed"}
#         except:
#             response_msg = {"error": True, "message": "Something is Wrong !"}
#         return Response(response_msg)



class RegisterView(APIView):
    def post(self, request):
        serializers = UserSerializer(data=request.data)
        if serializers.is_valid():
            serializers.save()
            return Response({"error": False}, status=status.HTTP_201_CREATED)
        return Response({"error": True, "details": serializers.errors}, status=status.HTTP_400_BAD_REQUEST)

class CustomerListCreateView(generics.ListCreateAPIView):
    queryset = Customer.objects.all()
    serializer_class = CustomerSerializer

class CustomerRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Customer.objects.all()
    serializer_class = CustomerSerializer

class CategoryView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        query = Category.objects.all()
        serializer = CategorySerializer(query, many=True)
        return Response(serializer.data)

class CartView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        user = request.user
        try:
            cart_obj = Cart.objects.filter(user=user).filter(isCompleted=False)
            data = []
            cart_serializer = CartSerializers(cart_obj, many=True)
            for cart in cart_serializer.data:
                cart_product_obj = CartProduct.objects.filter(cart=cart["id"])
                cart_product_obj_serializer = CartProductSerializers(
                    cart_product_obj, many=True)
                cart['cartproducts'] = cart_product_obj_serializer.data
                data.append(cart)
            response_msg = {"error": False, "data": data}
        except:
            response_msg = {"error": True, "data": "No Data"}
        return Response(response_msg); 

class OrderView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        try:
            query = Order.objects.filter(cart__user=request.user)
            serializers = OrdersSerializers(query, many=True)
            response_msg = {"error": False, "data": serializers.data}
        except:
            response_msg = {"error": True, "data": "no data"}
        return Response(response_msg)
    
class AddToCart(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        product_id = request.query_params.get('id')  # Get the product ID from query parameters
        if not product_id:
            return Response({'error': 'Product ID is required'}, status=status.HTTP_400_BAD_REQUEST)
        product_obj = Product.objects.get(id=product_id)
        # print(product_obj, "product_obj")
        cart_cart = Cart.objects.filter(
            user=request.user).filter(isCompleted=False).first()
        cart_product_obj = CartProduct.objects.filter(
            product__id=product_id).first()

        try:
            if cart_cart:
                this_product_in_cart = cart_cart.cartproduct_set.filter(
                    product=product_obj)
                if this_product_in_cart.exists():
                    cartprod_uct = this_product_in_cart[0]
                    cartprod_uct.quantity += 1
                    cartprod_uct.subtotal += product_obj.price
                    cartprod_uct.save()
                    cart_cart.total += product_obj.price
                    cart_cart.save()
                else:
                    cart_product_new = CartProduct.objects.create(
                        cart=cart_cart,
                        price=product_obj.price,
                        quantity=1,
                        subtotal=product_obj.price
                    )
                    cart_product_new.product.add(product_obj)
                    cart_cart.total += product_obj.price
                    cart_cart.save()
            else:
                cart = Cart.objects.create(user=request.user, total=0, isCompleted=False)
                cart_product_new = CartProduct.objects.create(
                    cart=cart,
                    price=product_obj.price,
                    quantity=1,
                    subtotal=product_obj.price
                )
                cart_product_new.product.add(product_obj)
                cart.total += product_obj.price
                cart.save()
            response_mesage = {
                'error': False, 'message': "Product add to card successfully", "productid": product_id}
        except:
            response_mesage = {'error': True,
                               'message': "Product Not add!Somthing is Wrong"}
        return Response(response_mesage)

class DeleteCartProduct(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        cart_product_id = request.query_params.get('id')
        if not cart_product_id:
            return Response({'error': 'CartProduct ID is required'}, status=status.HTTP_400_BAD_REQUEST)
        
        try:
            cart_product_obj = CartProduct.objects.get(id=cart_product_id)
            cart_cart = Cart.objects.filter(
                user=request.user, isCompleted=False).first()
            if cart_cart:
                cart_cart.total -= cart_product_obj.subtotal
                cart_product_obj.delete()
                cart_cart.save()
                response_msg = {'error': False}
            else:
                response_msg = {'error': True, 'message': 'Cart not found or completed'}
        except CartProduct.DoesNotExist:
            response_msg = {'error': True, 'message': 'CartProduct not found'}
        except:
            response_msg = {'error': True, 'message': 'An error occurred while deleting the cart product'}

        return Response(response_msg)
    
class DeleteCart(APIView):
        permission_classes = [IsAuthenticated, ]
        authentication_classes = [TokenAuthentication, ]

        def post(self, request):
            cart_id = request.query_params.get('id')
            if not cart_id:
                return Response({'error': 'CartProduct ID is required'}, status=status.HTTP_400_BAD_REQUEST)
            try:
                cart_obj = Cart.objects.get(id=cart_id)
                cart_obj.delete()
                response_msg = {'error': False}
            except:
                response_msg = {'error': True}
            return Response(response_msg)
        
class OrderCreate(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        try:
            data = request.data
            cart_id = data['cartid']
            email = data['email']
            phone = data['phone']
            cart_obj = Cart.objects.get(id=cart_id)
            cart_obj.isComplit = True
            cart_obj.save()
            Order.objects.create(
                cart=cart_obj,
                email=email,
                phone=phone,
            )
            response_msg = {"error": False, "message": "Your Order is Completed"}
        except:
            response_msg = {"error": True, "message": "Something is Wrong !"}
        return Response(response_msg)
      
class UserProfileView(APIView):
    permission_classes = [IsAuthenticated]
    authentication_classes = [TokenAuthentication]

    def get(self, request):
        user = request.user
        try:
            customer = Customer.objects.get(user=user)
            customer_serializer = CustomerSerializer(customer)
            response_msg = {"error": False, "data": customer_serializer.data}
        except Customer.DoesNotExist:
            response_msg = {"error": True, "data": "Customer not found"}
        return Response(response_msg)


class ReviewView(APIView):
    permission_classes = [IsAuthenticated]
    authentication_classes = [TokenAuthentication]

    def post(self, request):
        serializer = ReviewSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user=request.user)
            response_msg = {"error": False, "message": "Review added successfully"}
        else:
            response_msg = {"error": True, "message": "Failed to add review", "details": serializer.errors}
        return Response(response_msg)
    
# class ReviewCreateView(generics.CreateAPIView):
#     permission_classes = [IsAuthenticated]
#     serializer_class = ReviewSerializer

#     def perform_create(self, serializer):
#         serializer.save(user=self.request.user)

class OrderTrackView(generics.ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = OrderTrackSerializer

    def get_queryset(self):
        user = self.request.user
        return OrderTrack.objects.filter(user=user).order_by('-created_at')

# -------------------------------------ADMINNNNNN----------------------------------------
def admin_login(request):
    try:
        if request.user.is_authenticated:
            return redirect('/dashboard/')

        if request.method == 'POST':
            username = request.POST.get('username')
            password = request.POST.get('password')
            user_obj = User.objects.filter(username=username)

            
            if not user_obj.exists():
                messages.info(request, 'Account not found')
                return HttpResponseRedirect(request.META.get('HTTP_REFERER'))
            
            user_obj = authenticate(username =username ,password = password)
            
            if user_obj and user_obj.is_superuser:
                login(request, user_obj)
                return redirect('/dashboard/')
            
            messages.error(request, 'Invalid username or password')
            return redirect('/admin/login/')
        
        return render(request, 'login.html')
    
    except Exception as e:
        print(e)

def dashboard(request):
    total_products = Product.objects.all().count()
    total_category = Category.objects.all().count()
    total_cart = Cart.objects.all().count()
    total_orders = Order.objects.all().count()
    total_tables = Table.objects.all().count()
    # total_products = Product.objects.all().count()
    context = {'total_products': total_products,
               'total_category': total_category,
               'total_cart': total_cart,
               'total_orders': total_orders,
               'total_tables': total_tables}
    return render(request, 'dashboard.html', context)

def logout_view(request):
    logout(request)
    return render(request, 'login.html')


#---------------Category CRUD---------------------

def category(request):
        objs = Category.objects.all()
        context = {'objs': objs}
        return render(request, 'category.html',context )

def addcategory(request):
    if request.method == "POST":
        name = request.POST.get('name')
        objs = Category.objects.create(name=name)
        objs.save()
        return redirect('/category/')

    return render(request, 'category.html')

def editcategory(request):
    objs = Category.objects.all()
    context = {'objs': objs}
    return render(request, 'category.html', context)

def updatecategory(request, id):
    category = get_object_or_404(Category, id=id)
    
    if request.method == "POST":
        name = request.POST.get('name')
        category.name = name
        category.save()
        return redirect('/category/')  
        
    return render(request, 'category.html', {'category': category}) 


def deletecategory(request, id):
    category = get_object_or_404(Category, id=id)
    category.delete()
    return redirect('/category/')


#---------------Product CRUD---------------------

def products(request):
    pro = Product.objects.all()
    
    context = {'pro':pro}
    return render(request, 'product.html', 'dashboard.html', context)


def addproduct(request):
    if request.method == "POST":
        name = request.POST.get('name')
        price = request.POST.get('price')
        description = request.POST.get('description')
        category_id = request.POST.get('category')
        category = Category.objects.get(id= category_id)
        image_path = request.FILES.get('image_path')

        Product.objects.create(
            name=name,
            price=price,
            description=description,
            category=category,
            image_path=image_path
        )
        # pro.save()
        return redirect('/product/')
    else:
        return render(request, 'product.html', {'categories': Category.objects.all()})
    
def editproduct(request):
    pro = Product.objects.all()
    context = {'pro': pro}
    return render(request, 'product.html', context)

def updateproduct(request, id):
    product = get_object_or_404(Product, id=id)
    
    if request.method == "POST":
        name = request.POST.get('name')
        price = request.POST.get('price')
        description = request.POST.get('description')
        category_id = request.POST.get('category')
        category = Category.objects.get(id= category_id)
        image_path = request.FILES.get('image_path')

        
        product.name=name,
        product.price=price,
        product.description=description,
        product.category=category,
        product.image_path=image_path
        
    
        product.save()
        return redirect('/product/')  
        
    return render(request, 'product.html', {'categories': Category.objects.all()})



#---------------Table CRUD---------------------
def tables(request):
    tab = Table.objects.all()
    context = {'tab':tab}
    return render(request, 'tables.html', context)

def addtables(request):
    if request.method == "POST":
        tname = request.POST.get('tname')
        chairs = request.POST.get('chairs')
        price = request.POST.get('price')
        table_desc = request.POST.get('table_desc')
        image_path = request.FILES.get('image_path')

        tab = Table.objects.create(
            tname= tname,
            chairs = chairs,
            price = price,
            table_desc = table_desc,
            image_path = image_path
            )
        tab.save()
        return redirect('/tables/')

    return render(request, 'tables.html')

def edittables(request):
    tab = Table.objects.all()
    context = {'tab': tab}
    return render(request, 'tables.html', context)

def updatetables(request, id):
    tables = get_object_or_404(Table, id=id)
    
    if request.method == "POST":
        tname = request.POST.get('tname')
        chairs = request.POST.get('chairs')
        price = request.POST.get('price')
        table_desc = request.POST.get('table_desc')
        image_path = request.FILES.get('image_path')

        
        tables.tname= tname
        tables.chairs = chairs
        tables.price = price
        tables.table_desc = table_desc
        
        if image_path:
            tables.image_path = image_path
        
    
        tables.save()
        return redirect('/tables/')  
        
    return render(request, 'tables.html', {'tables': Table.objects.all()})


def deletetables(request, id):
    tab = get_object_or_404(Table, id=id)
    tab.delete()
    context = {
        'tab' : tab
    }
    return redirect('/tables/', context)

    