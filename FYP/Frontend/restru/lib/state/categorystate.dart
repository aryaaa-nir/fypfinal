// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:localstorage/localstorage.dart';
// import 'package:http/http.dart' as http;
// // import 'package:restru/models/cart.dart';
// import '../models/product.dart';

// class CategoryState with ChangeNotifier {
//   List<Product>? _product;
//   List<Category>? _category;

//   LocalStorage storage = LocalStorage("usertoken");
//   Future<void> getCategoryData() async {
//     try {
//       var token = storage.getItem('token');
//       String url = 'http://10.0.2.2:8000/category/';
//        http.Response response = await http.get(Uri.parse(url), headers: {
//         "Authorization": "token $token",
//       });
//       var data = json.decode(response.body) as List;
//       print(data);
//       List<Category> temp = [];
//       data.forEach((element) {
//         Category category = Category.fromJson(element);
//         temp.add(category);
//       });
//       _category = temp;
//       notifyListeners();
//     } catch (e) {
//       print("error getCategoryData");
//       print(e);
//     }
//   }

//    List<Category>? get category {
//     if (_product != null) {
//       return _category;
//     }
//     return null;
//   }
//   }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class CategoryState with ChangeNotifier {
  List<Category>? _category;

  LocalStorage storage = LocalStorage("usertoken");

  Future<void> getCategoryData() async {
    try {
      var token = storage.getItem('token');
      String url = 'http://10.0.2.2:8000/category/';
      print("Fetching categories from: $url with token: $token"); // Debugging print
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "token $token",
      });
      var data = json.decode(response.body) as List;
      print("Category data received: $data"); // Debugging print
      List<Category> temp = [];
      data.forEach((element) {
        Category category = Category.fromJson(element);
        temp.add(category);
      });
      _category = temp;
      notifyListeners();
    } catch (e) {
      print("Error in getCategoryData: $e"); // Debugging print
    }
  }

  List<Category>? get category {
    return _category;
  }
}
