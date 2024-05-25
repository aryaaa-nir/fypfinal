import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../models/ratings.dart';

class RatefeedState with ChangeNotifier {
  List<Ratings> _ratings = [];
  LocalStorage storage = new LocalStorage('usertoken');

  List<Ratings> get ratings => _ratings;

  Future<void> submitRating(int rate, String comment) async {
    String url = 'http://10.2.0.0:8000/review/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
        body: json.encode({
          "rating": rate,
          "comment": comment,
        }),
      );
      if (response.statusCode == 200) {
        // Rating submitted successfully
        // You can update the local ratings list or perform any other actions
        notifyListeners();
      } else {
        // Failed to submit rating
        throw Exception('Failed to submit rating');
      }
    } catch (e) {
      // Handle errors
      print("Error submitting rating: $e");
      throw Exception('Failed to submit rating');
    }
  }
}
