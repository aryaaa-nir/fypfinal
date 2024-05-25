import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class UserState with ChangeNotifier{
  LocalStorage storage = new LocalStorage('usertoken');

  Future <bool> loginNow(String uname, String pass)async{
    String url ='http://10.0.2.2:8000/login/';
    try{
      http.Response response = await http.post(
        Uri.parse(url),
        
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        'username' : uname,
        'password' : pass,
      }));
      var data = json.decode(response.body) as Map;
      if(data.containsKey("token")){
        storage.setItem("token",data['token']);
        print(storage.getItem('token'));
        return true;
      }      
      return false; 
    }catch (e){
      print("e loginNow");
      print(e);
      return false;
    }
  }

    Future <bool> registerNow(String uname, String pass, String allergy)async{
    String url ='http://10.0.2.2:8000/register/';
    try{
      http.Response response = await http.post(
        Uri.parse(url),
        
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        'username' : uname,
        'password' : pass,
        'allergy' : allergy
      }));
      var data = json.decode(response.body) as Map;
      print(data);
      
      if(data["error"]==false ){
        return true;
      }      
      return false; 
    }catch (e){
      print("e loginNow");
      print(e);
      return false;
    }
  }
}