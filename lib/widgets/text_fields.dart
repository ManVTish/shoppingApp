import 'package:flutter/material.dart';

Widget textFields(String heading, TextEditingController controller){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 100),
      child: Column(
        children: [
          Text(heading,
          style: const TextStyle(fontSize: 20, color: Colors. black, fontWeight: FontWeight.bold),),
          TextField(
            controller:controller
          )
        ],
      ),
    );
}