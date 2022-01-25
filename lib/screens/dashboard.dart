
import 'package:shopping_app/controllers/cart_controller.dart';
import 'package:shopping_app/controllers/products_controller.dart';
import 'package:shopping_app/screens/cart_product.dart';
import 'package:shopping_app/screens/ordered_products.dart';
import 'package:shopping_app/screens/product_detail.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({ Key? key }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  double width = 0, height = 0, top = 0;

  final ProductsController _productsController = Get.put(ProductsController());
  final CartController _cartController = Get.put(CartController());

  @override
  void initState(){
    super.initState();
    _productsController.fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    top = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(

        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              //SizedBox(height: top,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const OrderedProducts()));
                    },
                    child: const Icon(Icons.local_bar)),
                  const Text("Product List", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                  ),),
                  InkWell(
                    onTap: (){
                      _cartController.priceCalculate();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CartProduct()));  
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      child: const Icon(Icons.filter_sharp))),
                ],
              ),
              const SizedBox(height: 8,),
              Container(
                width: width,
                height: height*0.1,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                       offset: Offset(2, 5),
                       blurRadius: 5,
                       color: Colors.grey,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Category", style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8,),
                        Container(
                          width: 90,
                          height: 90,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(1, 2),
                                blurRadius: 4,
                              )
                            ]
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: const [
                            SizedBox(width: 25,),
                            Text("Apparel", style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14),),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 25,),
                    Column(
                      children: [
                        const SizedBox(height: 23,),
                        Container(
                              width: 90,
                              height: 90,
                              decoration: const BoxDecoration(
                                color: Colors.yellow,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(1, 2),
                                    blurRadius: 4,
                                  )
                                ]
                              ),
                            ),
                            const SizedBox(height: 5,),
                            const Text("Shoe", style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14),),
                      ],
                    ),
                        const SizedBox(width: 25,),
                        Column(
                          children: [
                            const SizedBox(height: 23,),
                            Container(
                              width: 90,
                              height: 90,
                              decoration: const BoxDecoration(
                                color: Colors.pink,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(1, 2),
                                    blurRadius: 4,
                                  )
                                ]
                              ),
                            ),
                            const SizedBox(height: 5,),
                            const Text("Beauty", style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14),),
                          ],
                        ),
                        const SizedBox(width: 25,),
                        Column(
                          children: [
                            const Text("See All", style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8,),
    
                            Container(
                              width: 90,
                              height: 90,
                              decoration: const BoxDecoration(
                                color: Colors.purple,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(1, 2),
                                    blurRadius: 4,
                                  )
                                ]
                              ),
                            ),
                            const SizedBox(height: 5,),
                            const Text("Electric", style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14),),
                          ],
                        ),
                        const SizedBox(width: 25,),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: Container(

                  child: Obx(()=>ListView.builder(
                    shrinkWrap: true,
                    itemCount: _productsController.productList.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(index)));                        
                        },
                        child: Card(
                        elevation: 1.5,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: Colors.lightGreen,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(_productsController.productList[index]["Image"])),
                              ),
                            ),
                            const SizedBox(width: 50,),
                            Expanded(
                              child: Container(
                                child: Text(_productsController.productList[index]["ProductName"]),
                            ),)
                          ],
                        ),
                      ),
                    );
                  })),
                ),
              )               
            ],
          ),
        ),
      ),
    );
  }
}