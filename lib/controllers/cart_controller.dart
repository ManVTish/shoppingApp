import 'package:get/get.dart';

class CartController extends GetxController{
  var cart = [].obs;
  var totalPrice = 0.0.obs;

  priceCalculate() {
    totalPrice.value = 0.0;
    for(int i=0; i<cart.length; i++){    

      totalPrice.value += (cart[i]["Price"])*(cart[i]["BaseQuantity"]);
    }
  }

}