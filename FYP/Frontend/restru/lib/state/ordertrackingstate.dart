import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:restru/models/Ordertrack.dart';
import 'package:http/http.dart' as http;

class OrderTrackingState with ChangeNotifier {
  OrderTrack? _trackModel; // Change to nullable
  List<OrderTrack>? _tracker;
  final LocalStorage storage = LocalStorage('usertoken');

  Future<void> getTrack() async {
    String url = 'http://10.0.2.2:8000/ordertrack/';
    var token = storage.getItem('token');
    try {
       http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': "token $token"
        },
      );
      var data = json.decode(response.body) as Map;
      print(data['error']);
      List<OrderTrack> demo = [];
      if (data['error'] == false) {
      data['data'].forEach((element) {
        OrderTrack trackModel = OrderTrack.fromJson(element); // Corrected assignment
        demo.add(trackModel);
      });
      _trackModel = demo.isNotEmpty ? demo[0] : null; // Assigning the first element of the list to _trackModel
      notifyListeners();
      }else{
        print(data['data']);
      }
    } catch (e) {
      print("Error in getTrack: $e");
      // Handle error, e.g., setting _trackModel to null
    }
  }

  // OrderTrack? get track { // Change return type to nullable
  //   return _trackModel; // Return _trackModel directly
  // }

  OrderTrack? get trackModel {
    if (_trackModel != null) {
      return _trackModel;
    } else {
      return null;
    }
  }
}
