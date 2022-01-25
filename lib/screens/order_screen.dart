import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/controllers/order_controller.dart';
import 'package:shopping_app/widgets/custom_dialogue.dart';

class OrderScreen extends StatelessWidget {
  //const OrderScreen({ Key? key }) : super(key: key);

  double width=0, height=0, top=0;

  final CartController _cartController = Get.put(CartController());
  final OrderController _orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    top = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Order Page"),       
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(()=>ListView.builder(
                itemCount: _cartController.cart.length,
                itemBuilder: (context, index){
                return Container(
                  width: width,
                  height: height*0.25,
                  child: Row(
                    children: [
                      Container(
                        width: width*.3,
                        child: productImage(index),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          child: Text(_cartController.cart[index]["ProductName"]),
                        ),
                      ),
                    ],
                  ),
                );
              })),
            ),
            TextButton(
              onPressed: () {

                prepareOrdered();
                customDialogue("Order Placed Successfully",context);

                _orderController.updateOrder();
                print(_orderController.orders);
                _cartController.cart.value = [];
                _cartController.totalPrice.value = 0.0;
              },
              child: const Text("Confirm Order"),
            )
          ],
        ),
      ),
    );
  }

  productImage(var index){
    return Image.network(_cartController.cart[index]["Image"]);
  }

  prepareOrdered(){
    for(int i=0; i<_cartController.cart.length; i++){
      _orderController.ordered["ProductName"]= _cartController.cart[i]["ProductName"];
      _orderController.ordered["Price"]= _cartController.cart[i]["Price"].toString();
      _orderController.ordered["Quantity"]= _cartController.cart[i]["BaseQuantity"].toString();
      _orderController.ordered["OrderID"]= _orderController.orderID.toString();
                  
      _orderController.confirmOrder();
    }
  }
}