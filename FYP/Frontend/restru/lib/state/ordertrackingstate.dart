import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:restru/models/Ordertrack.dart';
import 'package:http/http.dart' as http;

class OrderTrackState with ChangeNotifier {
  List<OrderTrack>? _orders;
  final OrderService _orderService = OrderService();

  List<OrderTrack>? get orders => _orders;

  Future<void> fetchOrders() async {
    _orders = await _orderService.fetchOrders();
    notifyListeners();
  }
}

 class OrderService {
  final LocalStorage storage = LocalStorage('usertoken');

  Future<List<OrderTrack>> fetchOrders() async {
    final String url = 'http://10.0.2.2:8000/ordertrack/';
    var token = storage.getItem('token');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Token $token",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => OrderTrack.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }}