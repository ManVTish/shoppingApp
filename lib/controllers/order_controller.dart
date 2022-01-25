import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController{
  
  var orderID = "";
  var orders = {}.obs;

    // "CustomerID": "",
    // "CustomerName": "",
    // "Address": "",
    // "PhoneNumber": "",
    // "Email": "",
    // "TotalPrice": "",
    // "OrderConfirmed": "NO",
    // "Delivered": "NO",
    // "Date": "",

  var userSpecificOrders = [].obs;
  Map<String, String> ordered = {
    "ProductName": "",
    "Price": "",
    "Quantity": "",
    "OrderID": ""
  }.obs;

  registerOrder() async{
    var res = await http.post(
      Uri.parse("https://aqueous-scrubland-52685.herokuapp.com/orders/register/"),
      headers: {"Content-type":"application/json"},
      body: jsonEncode(orders)
    );

    if(res.statusCode==200){
      // print("Order Created");
      var parse = jsonDecode(res.body);
      orderID = parse["orderID"];
      Get.toNamed("/orderScreen");
    }             
  }

  getOrderUserSpecific(var userID) async{
    var res = await http.get(Uri.parse("https://aqueous-scrubland-52685.herokuapp.com/orders/customerid/$userID"));
    userSpecificOrders.value = jsonDecode(res.body);      
  }

  updateOrder() async{
    orders["OrderConfirmed"]="YES";
    var res = await http.post(
      Uri.parse("https://aqueous-scrubland-52685.herokuapp.com/orders/update/${orderID.toString()}"),
      headers: {"Content-type":"application/json"},
      body: jsonEncode(orders),
    );
  }

  confirmOrder() async{
    var res = await http.post(
      Uri.parse("https://aqueous-scrubland-52685.herokuapp.com/orderedproducts/register/"),
      headers: {"Content-type":"application/json"},
      body: jsonEncode(ordered)
    );
  }
}