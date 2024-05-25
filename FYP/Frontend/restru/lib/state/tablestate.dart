import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/cupertino.dart';
import '../models/table.dart';
import 'package:http/http.dart' as http;

class TableState with ChangeNotifier {
      Tables? _tableModel;
  List<Tables> _tables = [];
  LocalStorage storage = new LocalStorage('usertoken');

  Future<bool> getTables() async {
    String url = 'http://10.0.2.2:8000/table/';
    var token = storage.getItem('token');

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
      ); 
      
      var data = json.decode(response.body) as List;
      List<Tables> temp = [];
      data.forEach((element) {
        Tables tables = Tables.fromJson(element);
        temp.add(tables);
      });
      _tables = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print("e getTables");
      print(e);
      return false;
    }
  }

  Future<void> reserveButton(int id) async {
    String url = 'http://10.0.2.2:8000/reserve/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: json.encode({'id': id}),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
      );
      getTables();
    } catch (e) {
      print("e reserveButton");
      print(e);
    }
  }

Future<bool> reserveresponse(
    int tableid, String email, String phone, DateTime date, TimeOfDay time) async {
    String url = 'http://10.0.2.2:8000/reserveresponse/';
    var token = storage.getItem('token');
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: json.encode({
            "tableid": tableid,
            "email": email,
            "phone": phone,
            "date" : date,
            "time" : time,
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
      var data = json.decode(response.body) as Map;
      if (data['error'] == false) {
        getTables();
        _tableModel = null;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("e ordercart");
      print(e);

      return false;
    }
  }

  List<Tables> get tables {
    return [..._tables];
  }

  List<Tables> get reservations {
    return _tables.where((element) => element.reserve == true).toList();
  }

  Tables SingleTable(int id) {
    return _tables.firstWhere((element) => element.id == id);
  }

//  Tables? get tableModel {
//   if (_tables.isNotEmpty) {
//     return _tables.first;
//   } else {
//     return null;
//   }
// }


//  reservetable(int id, DateTime resFor, String email, String phone) {}
}
