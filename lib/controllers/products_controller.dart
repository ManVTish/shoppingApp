import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductsController extends GetxController{
  var productList = [].obs;

  fetchProduct() async{
    var response = await http.get(Uri.parse("https://aqueous-scrubland-52685.herokuapp.com/products/"));
    productList.value = jsonDecode(response.body);
    //print(productList);
  }
}