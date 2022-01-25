import 'package:flutter/material.dart';

customDialogue(String text, BuildContext context){
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return AlertDialog(  
        title: const Text("Simple Alert"),  
        content: Text(text),
        actions: [  
          TextButton(  
            child: const Text("OK"),  
            onPressed: () {  
              Navigator.of(context).pop();  
            },  
          ),  
        ],  
      );  
    },  
  );  
}