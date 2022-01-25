import 'package:flutter/material.dart';
import 'package:shopping_app/screens/login.dart';
import 'package:get/get.dart';
import 'package:shopping_app/screens/order_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const Login(),
      getPages: [
        GetPage(name: '/', page: ()=>const Login()),
        GetPage(name: '/orderScreen', page: ()=> OrderScreen()),
      ],
    );
  }
}