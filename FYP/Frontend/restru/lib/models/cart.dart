class CartModel {
  final int id;
  final int total;
  final bool isCompleted;
  final String date;
  final int user;
  final List<Cartproducts> cartproducts;

  CartModel({
    required this.id,
    required this.total,
    required this.isCompleted,
    required this.date,
    required this.user,
    required this.cartproducts,
  });

  CartModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        total = json['total'],
        isCompleted = json['isCompleted'],
        date = json['date'],
        user = json['user'],
        cartproducts = List<Cartproducts>.from(
          json['cartproducts'].map((x) => Cartproducts.fromJson(x)),
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'isCompleted': isCompleted,
      'date': date,
      'user': user,
      'cartproducts': cartproducts.map((e) => e.toJson()).toList(),
    };
  }
}

class Cartproducts {
  final int id;
  final int price;
  final int quantity;
  final int subtotal;
  final Cart cart;
  final List<Product> product;

  Cartproducts({
    required this.id,
    required this.price,
    required this.quantity,
    required this.subtotal,
    required this.cart,
    required this.product,
  });

  Cartproducts.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        quantity = json['quantity'],
        subtotal = json['subtotal'],
        cart = Cart.fromJson(json['cart']),
        product = List<Product>.from(
          json['product'].map((x) => Product.fromJson(x)),
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'quantity': quantity,
      'subtotal': subtotal,
      'cart': cart.toJson(),
      'product': product.map((e) => e.toJson()).toList(),
    };
  }
}

class Cart {
  final int id;
  final int total;
  final bool isCompleted;
  final String date;
  final int user;

  Cart({
    required this.id,
    required this.total,
    required this.isCompleted,
    required this.date,
    required this.user,
  });

  Cart.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        total = json['total'],
        isCompleted = json['isCompleted'],
        date = json['date'],
        user = json['user'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'isCompleted': isCompleted,
      'date': date,
      'user': user,
    };
  }
}

class Product {
  final int id;
  final String name;
  final String price;
  final String description;
  final String imagePath;
  final int category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    required this.category,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = json['price'],
        description = json['description'],
        imagePath = json['image_path'],
        category = json['category'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'image_path': imagePath,
      'category': category,
    };
  }
}
