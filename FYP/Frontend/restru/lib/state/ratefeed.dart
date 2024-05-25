import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import '../models/ratings.dart';


class ReviewProvider with ChangeNotifier {
  final ReviewService _reviewService = ReviewService();

  Future<Map<String, dynamic>> postReview(String comment, double rating) async {
    final response = await _reviewService.postReview(comment, rating);
    notifyListeners();
    return response;
  }
}

class ReviewService {
  final LocalStorage storage = LocalStorage('usertoken');
  final String baseUrl = 'http://10.0.2.2:8000/review/';

  Future<Map<String, dynamic>> postReview(String comment, double rating) async {
    var token = storage.getItem('token');
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Authorization": "Token $token",
          "Content-Type": "application/json"
        },
        body: json.encode({
          'comment': comment,
          'rating': rating,
        }),
      );
      return json.decode(response.body);
    } catch (e) {
      return {'error': true, 'message': 'Failed to post review'};
    }
  }
}