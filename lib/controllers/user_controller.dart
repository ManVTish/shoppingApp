import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController{

  var userID = "";
  var userData = {};

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Map userLoginData = {
    "Email": "",
    "Password": "",
  };

  getUser() async{
    var res = await http.get(
      Uri.parse("https://aqueous-scrubland-52685.herokuapp.com/users/id/$userID"));
    userData = jsonDecode(res.body);
  }

  fetchUser() async{
    var response = await http.post(
      Uri.parse("https://aqueous-scrubland-52685.herokuapp.com/users/login/"),
      headers: {"Content-type": "application/json"},
      body: jsonEncode(userLoginData),
    );
    
    if(response.statusCode == 200) {
      return {"data": jsonDecode(response.body), "status": "success"};
    }else{
      return {"status": "fail"};
    }
  }

}