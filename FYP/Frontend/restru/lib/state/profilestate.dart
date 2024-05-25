import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../models/profile.dart';
import '../screens/profiles.dart';

class ProfileState with ChangeNotifier {
  Profile? _profile;
  bool _loading = false;
  String? _error;

  Profile? get profile => _profile;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchProfile(String token) async {
    _loading = true;
    _error = null;
    notifyListeners();

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/profile/'),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['error'] == false) {
        _profile = Profile.fromJson(data['data']);
      } else {
        _error = data['data'];
      }
    } else {
      _error = 'Server Error: ${response.statusCode}';
    }

    _loading = false;
    notifyListeners();
  }
}