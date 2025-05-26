import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../res/app_style/app_style.dart';
import '../../res/assets/image_assets.dart';
import '../../res/colors/app_color.dart';
import '../../res/colors/app_color.dart';
import '../../res/media-queries/media_query.dart';
import '../../view_models/product_list.dart';
import 'checkout_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';


class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the selected product from the controller
    final ProductController2 controller2 = Get.find();
    final mediaQuery = MediaQueryHelper(context);
      final ProductController controller = Get.put(ProductController());


    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Product Details'),
      //   backgroundColor: AppColor.blueMain, // Customize the AppBar color as needed
      // ),
      body: Obx(() {
        // Check if a product is selected
        final product = controller2.selectedProduct.value;

        if (product == null) {
          return Center(child: Text('No product selected.'));
        }

        // Display the product details
       return SafeArea(
         child: SingleChildScrollView(
           child: Padding(
                  padding: mediaQuery.paddingAll(2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: product.uid,
                        child: Stack(
                            children: [

                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                 imageUrl:  product.imageUrl,
                                  width: double.infinity,
                                  height: mediaQuery.height(25),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                child: IconButton(
                                  icon: CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.grey.shade200,
                                      child: const Icon(Icons.arrow_back_ios_rounded,size: 18,)),
                                  onPressed: () => Get.back(),
                                ),
                              )
                            ]
                        ),
                      ),
                      SizedBox(height: mediaQuery.height(2)),

             Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                product.name,
                                style: AppStyle.headings,
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),

                            Obx(() => Stack(
                                children: [
                                  Container(

                                      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 6),
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF2F4FF),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Text("${controller.quantity.value}", style: const TextStyle(fontSize: 16))),
                                  Positioned(
                                    left: 60,
                                    top: -5,

                                    child:IconButton(
                                      icon: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Color(0xffA0ABFF),
                                          child: const Icon(Icons.add)),
                                      onPressed: controller.increment,
                                    ),
                                  ),

                                  Positioned(
                                    right:60,
                                    top: -5,

                                    child: IconButton(
                                      icon: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Color(0xffDFE3FF),
                                          child: const Icon(Icons.remove)),
                                      onPressed: controller.decrement,
                                    ),
                                  )
                                ])),


                          ],
                        ),
                      ),
                      SizedBox(height: mediaQuery.height(1)),

                      // Ratings

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              product.price.toString(),
                              style: AppStyle.headings,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: mediaQuery.height(2)),
                      // Dropdown for mg
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          Obx(() => Row(
                            children: product.quantitiesAvailable.map((mg) {
                              final isSelected = controller.selectedMg.value == mg;

                              return GestureDetector(
                                onTap: () => controller.setMg(mg),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColor.blueMain : Color(0xffF5F4F8),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: isSelected ? AppColor.blueMain : Color(0xffF5F4F8),
                                    ),
                                  ),
                                  child: Text(
                                    mg,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: isSelected ? AppColor.whiteColor : AppColor.blueMain,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                        fontFamily: 'poppins'
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          )),
                        ],
                      ),
                      SizedBox(height: mediaQuery.height(2)),
                      // Quantity Selector
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       Get.snackbar("Added to Cart", "Product added successfully!",
                      //           backgroundColor: Colors.green, colorText: Colors.white);
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //         padding: EdgeInsets.symmetric(vertical: 14),
                      //         backgroundColor: AppColor.greenMain,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(12))),
                      //     // child: Obx(() => Text(
                      //     //     "Add ${controller.quantity.value} to Cart (${controller.selectedMg.value})",
                      //     //     style: AppStyle.btnText)),
                      //    child:  Obx(() => Text(
                      //         "Add ${controller.quantity.value} to Cart (${controller.selectedMg.value})",
                      //         style: AppStyle.btnText)),
                      //   ),
                      // ),

                      SizedBox(height: mediaQuery.height(2)),



                      // Details Section
                      const Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                       Text(
                        product.details,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),

                      SizedBox(height: mediaQuery.height(2)),

                      Row(
                        children: const [
                          Icon(Icons.star, color: Color(0xffFFC000), size: 18),
                          Icon(Icons.star, color: Color(0xffFFC000), size: 18),
                          Icon(Icons.star, color: Color(0xffFFC000), size: 18),
                          Icon(Icons.star_half, color: Color(0xffFFC000), size: 18),
                          Icon(Icons.star_border, color: Color(0xffFFC000), size: 18),
                          SizedBox(width: 8),
                          Text("3.5/5", style: TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: mediaQuery.height(2)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Reviews",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: mediaQuery.height(1)),

                          // Top 2 reviews
                          ...controller.reviews.take(2).map((review) => ReviewTile(review)).toList(),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Get.to(() => AllReviewsScreen());
                              },
                              child: const Text("See more", style: TextStyle(color: AppColor.blueMain,fontFamily: "Poppins")),
                            ),
                          )
                        ],
                      ),


                      // Add to Cart Button
                    ],
                  ),


            ),
         ),
       );}),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () async{

              final product = controller2.selectedProduct.value;
              if (product == null) return;

              await controller2.addToCart(
                product,
                controller.quantity.value,
                controller.selectedMg.value,
              );

              Get.snackbar("Success", "Product added to cart!",
                  backgroundColor: Colors.green, colorText: Colors.white);

              // Get.snackbar("Added to Cart", "Product added successfully!",
              //     backgroundColor: Colors.green, colorText: Colors.white);


              // Get.to(() => CheckoutScreen());
              // Navigator.of(context).push(
              //   PageRouteBuilder(
              //     transitionDuration: const Duration(milliseconds: 400), // Slow animation
              //     pageBuilder: (context, animation, secondaryAnimation) => CheckoutScreen(),
              //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
              //       // Slide from bottom-left
              //       final begin = Offset(-1, 1.0);
              //       final end = Offset.zero;
              //       final curve = Curves.easeInOut;
              //
              //       final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              //
              //       return SlideTransition(
              //         position: animation.drive(tween),
              //         child: child,
              //       );
              //     },
              //   ),
              // );
            },
            style: ElevatedButton.styleFrom(

                backgroundColor: AppColor.greenMain,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
            child: Obx(() => Text(
                "Add ${controller.quantity.value} to Cart (${controller.selectedMg.value})",
                style: AppStyle.btnText)),
          ),
        ),


      ),


    );
  }
}




//
// import 'package:adminpanel1medilane/view_models/auth_vm/auth_vm.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:medilane/res/colors/app_color.dart';
// import 'package:medilane/res/routes/routes_name.dart';
// import '../../res/app_style/app_style.dart';
// import '../../res/assets/image_assets.dart';
// import '../../res/media-queries/media_query.dart';
// import '../../res/routes/routes.dart';
// import '../../view_models/product_list.dart';
// import 'checkout_screen.dart';
//
// class DetailScreen extends StatelessWidget {
//   final ProductController controller = Get.put(ProductController());
//   final ProductController2 controller2 = Get.find(); // Get the controller
//
//   AuthController3 authController3 = Get.put(AuthController3());
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQueryHelper(context);
//     controller2.fetchAllProducts();
//
//
//     return Scaffold(
//       // appBar: AppBar(
//       //   automaticallyImplyLeading: false, // Hides back button
//       //   title: const Text("Product Details"),
//       //   actions: [
//       //   ],
//       // ),
//       body: Obx((){
//         return SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: mediaQuery.paddingAll(2),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Hero(
//                     tag: "product-panadol",
//                     child: Stack(
//                         children: [
//
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: Image.asset(
//                               ImageAssets.panadol,
//                               width: double.infinity,
//                               height: mediaQuery.height(25),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Positioned(
//                             child: IconButton(
//                               icon: CircleAvatar(
//                                   radius: 22,
//                                   backgroundColor: Colors.grey.shade200,
//                                   child: const Icon(Icons.arrow_back_ios_rounded,size: 18,)),
//                               onPressed: () => Get.back(),
//                             ),
//                           )
//                         ]
//                     ),
//                   ),
//                   SizedBox(height: mediaQuery.height(2)),
//
//                   // Title + Price
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             "iuasjx",
//                             style: AppStyle.headings,
//                             softWrap: true,
//                             overflow: TextOverflow.visible,
//                           ),
//                         ),
//
//                         Obx(() => Stack(
//                             children: [
//                               Container(
//
//                                   padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 6),
//                                   width: 100,
//                                   decoration: BoxDecoration(
//                                     color: Color(0xffF2F4FF),
//                                     borderRadius: BorderRadius.circular(14),
//                                   ),
//                                   child: Text("${controller.quantity.value}", style: const TextStyle(fontSize: 16))),
//                               Positioned(
//                                 left: 60,
//                                 top: -5,
//
//                                 child:IconButton(
//                                   icon: CircleAvatar(
//                                       radius: 15,
//                                       backgroundColor: Color(0xffA0ABFF),
//                                       child: const Icon(Icons.add)),
//                                   onPressed: controller.increment,
//                                 ),
//                               ),
//
//                               Positioned(
//                                 right:60,
//                                 top: -5,
//
//                                 child: IconButton(
//                                   icon: CircleAvatar(
//                                       radius: 15,
//                                       backgroundColor: Color(0xffDFE3FF),
//                                       child: const Icon(Icons.remove)),
//                                   onPressed: controller.decrement,
//                                 ),
//                               )
//                             ])),
//
//
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: mediaQuery.height(1)),
//
//                   // Ratings
//
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Text(
//                           "\$ 120",
//                           style: AppStyle.headings,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: mediaQuery.height(2)),
//                   // Dropdown for mg
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//
//                       Obx(() => Row(
//                         children: ['25mg', '50mg', '100mg'].map((mg) {
//                           final isSelected = controller.selectedMg.value == mg;
//
//                           return GestureDetector(
//                             onTap: () => controller.setMg(mg),
//                             child: Container(
//                               margin: const EdgeInsets.symmetric(horizontal: 4),
//                               padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
//                               decoration: BoxDecoration(
//                                 color: isSelected ? AppColor.blueMain : Color(0xffF5F4F8),
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(
//                                   color: isSelected ? AppColor.blueMain : Color(0xffF5F4F8),
//                                 ),
//                               ),
//                               child: Text(
//                                 mg,
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     color: isSelected ? AppColor.whiteColor : AppColor.blueMain,
//                                     fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                                     fontFamily: 'poppins'
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       )),
//                     ],
//                   ),
//                   SizedBox(height: mediaQuery.height(2)),
//
//                   // Quantity Selector
//                   // SizedBox(
//                   //   width: double.infinity,
//                   //   child: ElevatedButton(
//                   //     onPressed: () {
//                   //       Get.snackbar("Added to Cart", "Product added successfully!",
//                   //           backgroundColor: Colors.green, colorText: Colors.white);
//                   //     },
//                   //     style: ElevatedButton.styleFrom(
//                   //         padding: EdgeInsets.symmetric(vertical: 14),
//                   //         backgroundColor: AppColor.greenMain,
//                   //         shape: RoundedRectangleBorder(
//                   //             borderRadius: BorderRadius.circular(12))),
//                   //     // child: Obx(() => Text(
//                   //     //     "Add ${controller.quantity.value} to Cart (${controller.selectedMg.value})",
//                   //     //     style: AppStyle.btnText)),
//                   //    child:  Obx(() => Text(
//                   //         "Add ${controller.quantity.value} to Cart (${controller.selectedMg.value})",
//                   //         style: AppStyle.btnText)),
//                   //   ),
//                   // ),
//
//                   SizedBox(height: mediaQuery.height(2)),
//
//
//
//                   // Details Section
//                   const Text(
//                     "Description",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     "Panadol Extra is used for pain relief including headaches, body aches, and fever. Comes in multiple strengths.",
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                   ),
//
//                   SizedBox(height: mediaQuery.height(2)),
//
//                   Row(
//                     children: const [
//                       Icon(Icons.star, color: Color(0xffFFC000), size: 18),
//                       Icon(Icons.star, color: Color(0xffFFC000), size: 18),
//                       Icon(Icons.star, color: Color(0xffFFC000), size: 18),
//                       Icon(Icons.star_half, color: Color(0xffFFC000), size: 18),
//                       Icon(Icons.star_border, color: Color(0xffFFC000), size: 18),
//                       SizedBox(width: 8),
//                       Text("3.5/5", style: TextStyle(fontSize: 14, color: Colors.grey)),
//                     ],
//                   ),
//                   SizedBox(height: mediaQuery.height(2)),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Reviews",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: mediaQuery.height(1)),
//
//                       // Top 2 reviews
//                       ...controller.reviews.take(2).map((review) => ReviewTile(review)).toList(),
//
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           onPressed: () {
//                             Get.to(() => AllReviewsScreen());
//                           },
//                           child: const Text("See more", style: TextStyle(color: Colors.blue)),
//                         ),
//                       )
//                     ],
//                   ),
//
//
//                   // Add to Cart Button
//                 ],
//               ),
//             ),
//           ),
//         );}),
//
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//         child: SizedBox(
//           width: double.infinity,
//           height: 50,
//           child: ElevatedButton(
//             onPressed: () {
//               // Get.snackbar("Added to Cart", "Product added successfully!",
//               //     backgroundColor: Colors.green, colorText: Colors.white);
//
//
//               // Get.to(() => CheckoutScreen());
//               // Navigator.of(context).push(
//               //   PageRouteBuilder(
//               //     transitionDuration: const Duration(milliseconds: 400), // Slow animation
//               //     pageBuilder: (context, animation, secondaryAnimation) => CheckoutScreen(),
//               //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//               //       // Slide from bottom-left
//               //       final begin = Offset(-1, 1.0);
//               //       final end = Offset.zero;
//               //       final curve = Curves.easeInOut;
//               //
//               //       final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//               //
//               //       return SlideTransition(
//               //         position: animation.drive(tween),
//               //         child: child,
//               //       );
//               //     },
//               //   ),
//               // );
//             },
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColor.greenMain,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 )),
//             child: Obx(() => Text(
//                 "Add ${controller.quantity.value} to Cart (${controller.selectedMg.value})",
//                 style: AppStyle.btnText)),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
Widget ReviewTile(Review review) {
  return Container(
    margin: const EdgeInsets.only(bottom: 2),
    padding: const EdgeInsets.all(8),

    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(review.imageUrl),
          radius: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                review.text,
                style: const TextStyle(fontSize: 13,color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
//
//
// // lib/controller/product_controller.dart
//
class ProductController extends GetxController {
  RxInt quantity = 1.obs;
  RxString selectedMg = '25mg'.obs;

  void increment() => quantity.value++;
  void decrement() {
    if (quantity.value > 1) quantity.value--;
  }

  void setMg(String mg) => selectedMg.value = mg;

  // Add this observable to track the selected payment method
  RxString paymentMethod = "".obs;

  // You may also want to initialize it with a default value, like "Cash on Delivery":
  @override
  void onInit() {
    super.onInit();
    paymentMethod.value = "Cash on Delivery"; // Default payment method
  }

  var reviews = <Review>[
    Review(
      name: "John Doe",
      imageUrl: "https://i.pravatar.cc/150?img=1",
      text: "This medicine really helped me. Fast shipping too!",
    ),
    Review(
      name: "Emily Smith",
      imageUrl: "https://i.pravatar.cc/150?img=2",
      text: "Great quality and packaging. Will order again!",
    ),
    Review(
      name: "Ali Khan",
      imageUrl: "https://i.pravatar.cc/150?img=3",
      text: "Received in 2 days. Working as expected.",
    ),
  ].obs;
}


class AllReviewsScreen extends StatelessWidget {
  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Reviews")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.reviews.length,
        itemBuilder: (context, index) {
          final review = controller.reviews[index];
          return ReviewTile(review);
        },
      ),
    );
  }
}


class Review {
  final String name;
  final String imageUrl;
  final String text;

  Review({
    required this.name,
    required this.imageUrl,
    required this.text,
  });
}

