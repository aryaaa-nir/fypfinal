import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../models/product.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

class ProductState with ChangeNotifier{
  List <Product> _products =[];
final LocalStorage storage = LocalStorage('usertoken');

  Future <bool> getProducts() async{
    String url = 'http://10.0.2.2:8000/products/';
    var token = storage.getItem('token');

    try{
      http.Response response = await http.get(Uri.parse(url),
      headers: {
          'Authorization': 'token $token'
        },
        ); // Convert string URL to Uri
      var data = json.decode(response.body) as List;
      // print(data);

      List<Product> temp = [];
      data.forEach((element) {
        Product product = Product.fromJson(element);
        temp.add(product);
      });
      _products =temp;

     return true;
    }catch (e){
      print("e getProducts");
      print(e);
      return false;
    }
  }


  List <Product> get products{
    return[..._products];
  }

  Product SingleProduct(int id){
    return _products.firstWhere((element) => element.id==id);
  }

  List<Product> categoryproduct(int id) {
    return [..._products.where((element) => element.category.id == id)];
  }
}

