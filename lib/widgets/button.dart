import 'package:flutter/material.dart';

import 'package:shopping_app/controllers/user_controller.dart';
import 'package:shopping_app/screens/dashboard.dart';
import 'package:shopping_app/widgets/custom_dialogue.dart';

import 'package:get/get.dart';

Widget button(BuildContext context){

  UserController _userController = Get.put(UserController());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical:40.0),
      child: GestureDetector(
        onTap: () async{
          _userController.userLoginData["Email"] = (_userController.emailController.text);
          _userController.userLoginData["Password"] = (_userController.passwordController.text);

          var mapData = await _userController.fetchUser();
          _userController.userID = mapData["data"]["result"];
          if(mapData["status"]=="success"){
            
            _userController.getUser();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Dashboard()));
          }else{
            customDialogue("Invalid Credentials", context);
          }
        },
        child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: const Center(
                          child: Text("SignIn",style: TextStyle(fontSize: 30),),
                        ),
                      ),
      ),
    );
  }