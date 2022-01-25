import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopping_app/controllers/order_controller.dart';
import 'package:shopping_app/controllers/user_controller.dart';

class OrderedProducts extends StatefulWidget {
  const OrderedProducts({ Key? key }) : super(key: key);

  @override
  _OrderedProductsState createState() => _OrderedProductsState();
}

class _OrderedProductsState extends State<OrderedProducts> {

  double width=0, height=0;

  final OrderController _orderController = Get.put(OrderController());
  final UserController _userController = Get.put(UserController());

  @override
  void initState(){
    super.initState();
    _orderController.getOrderUserSpecific(_userController.userID.toString());
  }


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Your all orders"),
        ),
        body: (_orderController.userSpecificOrders==[])
        ?
        const CircularProgressIndicator()
        :
        Column(
          children: [
            Obx(()=>ListView.builder(
              shrinkWrap: true,
              itemCount: _orderController.userSpecificOrders.length,
              itemBuilder: (context,index){
              return ListTile(
                title:Text(_orderController.userSpecificOrders[index]["_id"])
              );
            }))
          ],
        ),
      ),
    );
  }
}