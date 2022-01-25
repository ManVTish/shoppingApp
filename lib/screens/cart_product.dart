import 'package:flutter/material.dart';

import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/controllers/order_controller.dart';
import 'package:shopping_app/controllers/user_controller.dart';

import 'package:get/get.dart';

class CartProduct extends StatefulWidget {
  const CartProduct({ Key? key }) : super(key: key);

  @override
  _CartProductState createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {

  double width=0, height=0, top=0;

  final CartController _cartController = Get.put(CartController());
  final UserController _userController = Get.put(UserController());
  final OrderController _orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    top = MediaQuery.of(context).padding.top;

    return Scaffold(

      appBar: AppBar(
        title: Row(
          children: [
            const Text("Total items in cart : "),
            const SizedBox(width: 20,),
            Obx(()=> Text((_cartController.cart.length).toString())),
          ]
        ),
      ),
      body: Column(
        children: [
          Container(
            width: width,
            height: height*.7,
            child: Obx(()=>ListView.builder(
            shrinkWrap: true,
            itemCount: _cartController.cart.length,
            itemBuilder: (context,index){
              return Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                       Container(
                         width: 100,
                         height: 100,
                         decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(_cartController.cart[index]["Image"],),),
                          
                         ),
                       ),
                       const SizedBox(width: 15,),
                       Expanded(child: Container(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(_cartController.cart[index]["ProductName"]),
                             const SizedBox(height: 10,),
                             Text(_cartController.cart[index]["Description"]),
                             const SizedBox(height: 10,),
                             Text("Rs. "+(_cartController.cart[index]["Price"]).toString()),
                             const SizedBox(height: 10,),
                             Row(
                               children: [
                                 const Text("Quantity: "),
                                 const SizedBox(width: 5,),
                                 Text(_cartController.cart[index]["BaseQuantity"].toString()),
                               ],
                             ),
                           ],
                         ),
                       )),
                       const SizedBox(width: 20,),
                       Expanded(
                         child: Column(
                           children:  [
                             OutlinedButton(
                               onPressed: (){
                                setState(() {
                                  _cartController.cart[index]["BaseQuantity"] = _cartController.cart[index]["BaseQuantity"]+1;
                                });
                                _cartController.priceCalculate();
                               },               
                               child: const Icon(Icons.add) 
                              ),
                             const SizedBox(height: 15,),
                              OutlinedButton(
                                onPressed: (){
                                  
                                  setState(() {
                                    if(_cartController.cart[index]["BaseQuantity"] == 1){
                                      _cartController.cart.removeAt(index);   
                                    }else{
                                      _cartController.cart[index]["BaseQuantity"] = _cartController.cart[index]["BaseQuantity"]-1;
                                    }
                                  });
                                  _cartController.priceCalculate();
                                },                       
                                child: const Icon(Icons.remove)),
                           ],
                          )
                        ),
                    ],
                  ),
                ),
              );
            })),
          ),
          const SizedBox(height: 5,),
          Container(
              width: width,
              height: height*.1,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                color: Colors.blue,
              ),
              child: Row(
                      children: [
                        const SizedBox(width: 40,),
                        const Text("Total Price: Rs.", style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,                       
                        ),),
                        const SizedBox(width: 10),
                        Obx(()=>Text(_cartController.totalPrice.toString())),
                      ],
                  )
          ),
          GestureDetector(
            onTap: () async{
              print(_orderController.orders);

              _orderController.orders.value= {
                "CustomerID": _userController.userData["_id"].toString(),
                "CustomerName": _userController.userData["UserName"],
                "Address": _userController.userData["Address"],
                "PhoneNumber": _userController.userData["PhoneNumber"].toString(),
                "Email": _userController.userData["Email"],
                "TotalPrice": _cartController.totalPrice.toString(),
                "OrderConfirmed": "NO",
                "Delivered": "NO",
                "Date": DateTime.now().toString(),
              };
          
              // _orderController.orders["CustomerID"] = _userController.userData["_id"];
              // _orderController.orders["CustomerName"] = _userController.userData["UserName"];
              // _orderController.orders["Address"] = _userController.userData["Address"];
              // _orderController.orders["PhoneNumber"] = _userController.userData["PhoneNumber"].toString();
              // _orderController.orders["Email"] = _userController.userData["Email"];
              // _orderController.orders["TotalPrice"] = _cartController.totalPrice.toString();
              // _orderController.orders["Date"] = DateTime.now().toString();
              print(_orderController.orders);
              _orderController.registerOrder();
            },
            child: Container(
              height: 55,
              width: width,
              color: Colors.red,
              child: const Center(child: Text("Place Order"),),),)
        ],
      )
    );
  }
}
