import 'package:flutter/material.dart';

import 'package:shopping_app/controllers/user_controller.dart';
import 'package:shopping_app/widgets/button.dart';
import 'package:shopping_app/widgets/text_fields.dart';

import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  double width = 0, height = 0;

  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(

        appBar: AppBar(
          title: const Text("SINGIN PAGE"),         
        ),
        body: Center(
          child: Container(
            width: width*0.8,
            height: height*0.6,
            decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.circular(20)
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding:  EdgeInsets.symmetric(vertical:20.0),
                    child: Text("SIGNIN",style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                  
                  textFields("Email", _userController.emailController),
                  textFields("Password", _userController.passwordController),
  
                  const SizedBox( height: 40,),
                  
                  button(context),
                ],
              ),
            )


          ),
        )
    );
  }
}