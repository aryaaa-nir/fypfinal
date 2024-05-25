class OrderModel {
  final int id;
  final String email;
  final String phone;
  final Cart cart;
  // final Table table;

  OrderModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.cart,
    // required this.table,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      cart: Cart.fromJson(json['cart']),
      // table: Table.fromJson(json['table']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'cart': cart.toJson(),
      // 'table': table.toJson(),
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

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      total: json['total'],
      isCompleted: json['isCompleted'],
      date: json['date'],
      user: json['user'],
    );
  }

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

class Table {
  final int id;
  final String tname;
  final int chairs;
  final String price;
  final String tableDesc;
  final String imagePath;

  Table({
    required this.id,
    required this.tname,
    required this.chairs,
    required this.price,
    required this.tableDesc,
    required this.imagePath,
  });

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      id: json['id'],
      tname: json['tname'],
      chairs: json['chairs'],
      price: json['price'],
      tableDesc: json['table_desc'],
      imagePath: json['image_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tname': tname,
      'chairs': chairs,
      'price': price,
      'table_desc': tableDesc,
      'image_path': imagePath,
    };
  }
}
