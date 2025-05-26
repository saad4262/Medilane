import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:medilane/view/home/shipping_screen.dart';
import '../../models/cart_model.dart';
import '../../res/app_style/app_style.dart';
import '../../res/assets/image_assets.dart';
import '../../res/colors/app_color.dart';
import '../../res/media-queries/media_query.dart';
import '../../view_models/product_list.dart';
import 'bank_screen.dart';
import 'med_detail.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';



class CheckoutScreen extends StatelessWidget {
  final controller = Get.find<ProductController2>();
  final controller2 = Get.find<ProductController>();
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final CartController cartController = Get.put(CartController());

  final double fixedDeliveryFee = 10;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: mediaQuery.height(2)),

            Row(
              children: [
                IconButton(
                  icon: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey.shade200,
                    child: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                  ),
                  onPressed: () => Get.back(),
                ),
                SizedBox(width: mediaQuery.width(15)),
                Text("Checkout", style: AppStyle.headings),
              ],
            ),

            SizedBox(height: mediaQuery.height(3)),


            Row(
              children: [
                _stepCircle(isDone: true),
                _stepLine(isDone: false),
                _stepCircle(isDone: false),
                _stepLine(isDone: false),
                _stepCircle(isDone: false),
              ],
            ),
            // Product List Section
            Expanded(
              child: uid == null
                  ? Center(child: Text("User not logged in"))
                  : StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .collection('cart')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("Your cart is empty."));
                  }

                  final cartItems = snapshot.data!.docs
                      .map((doc) => CartItem.fromFirestore(doc))
                      .toList();

                  // Calculate subtotal
                  double subtotal = 0;
                  for (var item in cartItems) {
                    subtotal += item.price * item.quantity;
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                       imageUrl:  item.imageUrl,
                                        width: 70,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${item.name} ${item.mg}", style: AppStyle.headings.copyWith(
                                            fontSize: 16
                                          )),
                                          SizedBox(height: mediaQuery.height(.5)),
                                          Text("quantity ${item.quantity}", style: AppStyle.descriptions.copyWith(fontSize: 12,color: Colors.grey)),
                                           SizedBox(height: mediaQuery.height(1)),

                                          Stack(
                                              children: [
                                                Container(

                                                    padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 6),
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffF2F4FF),
                                                      borderRadius: BorderRadius.circular(14),
                                                    ),
                                                    child: Text("${item.quantity}", style: const TextStyle(fontSize: 16))),
                                                Positioned(
                                                  left: 60,
                                                  top: -5,

                                                  child:IconButton(
                                                    icon: CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor: Color(0xffA0ABFF),
                                                        child: const Icon(Icons.add)),
                                                    onPressed: () => cartController.incrementQuantity(item),
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
                                                    onPressed: () => cartController.decrementQuantity(item),
                                                  ),
                                                )
                                              ]),


                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(

                                          padding: mediaQuery.paddingOnly(bottom: 3),
                                          child: IconButton(
                                            icon: const Icon(FontAwesomeIcons.trash, color: Colors.red,size: 16 ,),
                                            onPressed: () {
                                              controller.removeFromCart(item.id);
                                            },
                                          ),
                                        ),
                                        Text("\$ ${item.price}", style: const TextStyle(color: Colors.grey)),

                                      ],
                                    ),

                                    // Text("x${item.quantity}", style: const TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // const SizedBox(height: 20),

                      // Payment Method Section
                      // Text("Payment Method", style: AppStyle.headings.copyWith(fontSize: 18)),
                      // const SizedBox(height: 12),
                      // _paymentMethodOption("Cash on Delivery", controller2.paymentMethod),
                      // const SizedBox(height: 8),
                      // _paymentMethodOption("Credit Card", controller2.paymentMethod),
                      // const SizedBox(height: 8),
                      // _paymentMethodOption("PayPal", controller2.paymentMethod),
                      //
                      // const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => cartController.togglePaymentExpanded(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Payment Method", style: AppStyle.headings.copyWith(fontSize: 18)),

                                Obx(() => Icon(
                                  cartController.isPaymentExpanded.value
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Payment Options
                          Obx(() => AnimatedCrossFade(
                            duration: const Duration(milliseconds: 300),
                            firstChild: const SizedBox.shrink(),
                            secondChild: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _paymentMethodOption("Cash on Delivery", controller2.paymentMethod),
                                const SizedBox(height: 8),
                                _paymentMethodOption("Credit Card", controller2.paymentMethod),
                                const SizedBox(height: 8),
                                _paymentMethodOption("PayPal", controller2.paymentMethod),
                                const SizedBox(height: 20),
                              ],
                            ),
                            crossFadeState: cartController.isPaymentExpanded.value
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                          )),
                        ],
                      ),


                      // Bill Summary with reactive delivery fee based on payment method
                      Obx(() {
                        // Add delivery fee only if payment method is 'Cash on Delivery'
                        double deliveryFee = controller2.paymentMethod.value == "Cash on Delivery"
                            ? fixedDeliveryFee
                            : 0;

                        double total = subtotal + deliveryFee;

                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _billSummaryRow("Subtotal", "\$ ${subtotal.toStringAsFixed(2)}"),
                              _billSummaryRow("Delivery Fee", "\$ ${deliveryFee.toStringAsFixed(2)}"),
                              _billSummaryRow("Total", "\$ ${total.toStringAsFixed(2)}", isBold: true),
                            ],
                          ),
                        );
                      }),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Proceed Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(

                  onPressed: () async {



                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 400),
                      pageBuilder: (context, animation, secondaryAnimation) => ShippingScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        final begin = Offset(-1, 1.0);
                        final end = Offset.zero;
                        final curve = Curves.easeInOut;
                        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.greenMain,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Checkout", style: AppStyle.btnText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentMethodOption(String title, RxString paymentMethod) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          paymentMethod.value = title;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: paymentMethod.value == title ? AppColor.greenMain : Colors.grey.shade300,
              width: 1,
            ),
            color: paymentMethod.value == title ? AppColor.greenMain.withOpacity(0.1) : Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(
                paymentMethod.value == title ? Icons.check_circle : Icons.circle_outlined,
                color: paymentMethod.value == title ? AppColor.greenMain : Colors.grey.shade400,
              ),
              const SizedBox(width: 8),
              Text(title, style: AppStyle.descriptions),
            ],
          ),
        ),
      );
    });
  }

  // Bill summary row builder
  Widget _billSummaryRow(String title, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontFamily: "poppins",
            )),
        Text(amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontFamily: "poppins",
            )),
      ],
    );
  }
}

Widget _stepCircle({required bool isDone}) {
  return CircleAvatar(
    radius: 10,
    backgroundColor: isDone ? AppColor.greenMain : Colors.grey.shade300,
    child: isDone
        ? Icon(Icons.check, size: 12, color: Colors.white)
        : Container(),
  );
}

Widget _stepLine({required bool isDone}) {
  return Expanded(
    child: Container(
      height: 2,
      color: isDone ? AppColor.greenMain : Colors.grey.shade300,
    ),
  );
}



// class PdfService extends GetxController {
//   Future<File> generateInvoicePdf(String userEmail, String orderId) async {
//     final pdf = pw.Document();
//     pdf.addPage(
//       pw.Page(
//         build: (context) => pw.Center(
//           child: pw.Text('Invoice for Order: $orderId\nUser: $userEmail'),
//         ),
//       ),
//     );
//
//     final output = await getTemporaryDirectory();
//     final file = File("${output.path}/invoice_$orderId.pdf");
//     await file.writeAsBytes(await pdf.save());
//     return file;
//   }
// }
