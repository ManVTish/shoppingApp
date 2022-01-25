import 'package:flutter/material.dart';

import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/controllers/products_controller.dart';
import 'package:shopping_app/screens/dashboard.dart';
import 'package:shopping_app/widgets/custom_dialogue.dart';

import 'package:get/get.dart';

class ProductDetail extends StatelessWidget {
  
  var index;
  ProductDetail(this.index);

  final CartController _cartController = Get.put(CartController());
  final ProductsController _productsController = Get.put(ProductsController());

  bool flag=false;
  double width = 0, height = 0, top = 0;

  @override
  Widget build(BuildContext context) {
    
    
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    top = MediaQuery.of(context).padding.top;
    
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: (){},
        //   child: Text(""),
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: top,),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
                  },  
                  child: const Icon(Icons.arrow_left, size: 30,)),
                const SizedBox(width: 100,),
                const Text("Product Details",
                style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                ),)
              ],
            ),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                width: width,
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_productsController.productList[index]["ProductName"], style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                    ),),
                    const SizedBox(height: 5,),
                    Text("This is 100% "+ _productsController.productList[index]["ProductName"],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),),
                    
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                width: width,
                height: height*0.4,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.lime,
                  image: DecorationImage(image: NetworkImage(_productsController.productList[index]["Image"]),
                  fit: BoxFit.contain
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text("Price: Rs." + _productsController.productList[index]["Price"].toString()),
            ),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: OutlinedButton(
                onPressed: (){
                  if(_cartController.cart.isEmpty){
                    _cartController.cart.add(_productsController.productList[index]);
                  }
                  else{
                    for(int i=0; i<_cartController.cart.length; i++){
                     if(_productsController.productList[index]["_id"] == _cartController.cart[i]["_id"]){
                        customDialogue("This is already in cart", context);
                        flag = true;
                        break;
                     }
                    }
                    if(!flag){
                      _cartController.cart.add(_productsController.productList[index]);
                    }
                  } 
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  foregroundColor:  MaterialStateProperty.all(Colors.white),
                ),
                child: const Text("Add to Cart"), 
                ),
            )
          ],
        ),
      ),
    );
  }

}