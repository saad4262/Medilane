import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:medilane/view/home/invoice_screen.dart';

import '../../res/app_style/app_style.dart';
import '../../res/colors/app_color.dart';
import '../../res/media-queries/media_query.dart';
import '../../res/widgets/custom_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'checkout_screen.dart';

import 'package:medilane/view/home/checkout_screen.dart' as checkout;
import 'package:medilane/view/home/invoice_screen.dart' as invoice;
import 'package:adminpanel1medilane/view_models/auth_vm/auth_vm.dart';

class ShippingController extends GetxController {
  final fullName = ''.obs;
  final phone = ''.obs;
  final address = ''.obs;
  final city = ''.obs;
  final postalCode = ''.obs;

  final isFormValid = false.obs;
  final isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    everAll([fullName, phone, address, city, postalCode], (_) => validateForm());
  }





  void validateForm() {
    isFormValid.value = fullName.isNotEmpty &&
        phone.isNotEmpty &&
        address.isNotEmpty &&
        city.isNotEmpty &&
        postalCode.isNotEmpty;
  }

  // Future<void> placeOrder() async {
  //   final user = _auth.currentUser;
  //   if (user == null) {
  //     Get.snackbar('Error', 'User not logged in');
  //     return;
  //   }
  //
  //   isLoading.value = true;
  //
  //   try {
  //     // 1. Get cart items for user
  //     final cartSnapshot = await _firestore
  //         .collection('users')
  //         .doc(user.uid)
  //         .collection('cart')
  //         .get();
  //
  //     final cartProducts = cartSnapshot.docs.map((doc) {
  //       final data = doc.data();
  //       return {
  //         'productName': data['name'],
  //         'quantity': data['quantity'],
  //         'price': data['price'],
  //         'productId': doc.id,
  //       };
  //     }).toList();
  //
  //     if (cartProducts.isEmpty) {
  //       Get.snackbar('Error', 'Your cart is empty');
  //       isLoading.value = false;
  //       return;
  //     }
  //
  //     // Calculate total price
  //     double totalPrice = 0;
  //     for (var item in cartProducts) {
  //       totalPrice += (item['quantity'] as int) * (item['price'] as double);
  //     }
  //
  //     // 2. Prepare order data
  //     final orderData = {
  //       'fullName': fullName.value,
  //       'phone': phone.value,
  //       'address': address.value,
  //       'city': city.value,
  //       'postalCode': postalCode.value,
  //       'orderDate': FieldValue.serverTimestamp(),
  //       'totalPrice': totalPrice,
  //       'products': cartProducts,
  //       'status': 'pending',
  //     };
  //
  //     // 3. Add order document under user's orders
  //     await _firestore
  //         .collection('users')
  //         .doc(user.uid)
  //         .collection('orders')
  //         .add(orderData);
  //
  //     // 4. Clear cart after order placed (optional)
  //     final batch = _firestore.batch();
  //     for (var doc in cartSnapshot.docs) {
  //       batch.delete(doc.reference);
  //     }
  //     await batch.commit();
  //
  //     Get.snackbar('Success', 'Order placed successfully!');
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> placeOrder() async {
    final user = _auth.currentUser;
    final authController2 = Get.find<AuthController3>();
    String? medicalStoreUid = authController2.user.value?.uid;


    if (user == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    isLoading.value = true;

    try {
      // Fetch cart products
      final cartSnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .get();

      final cartProducts = cartSnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'productName': data['name'],
          'quantity': data['quantity'],
          'price': data['price'],
          'productId': doc.id,
        };
      }).toList();

      if (cartProducts.isEmpty) {
        Get.snackbar('Error', 'Your cart is empty');
        isLoading.value = false;
        return;
      }

      // Calculate total price safely
      double totalPrice = 0;
      for (var item in cartProducts) {
        final quantity = (item['quantity'] is int) ? item['quantity'] as int : int.tryParse(item['quantity'].toString()) ?? 0;
        final price = (item['price'] is double)
            ? item['price'] as double
            : double.tryParse(item['price'].toString()) ?? 0.0;

        totalPrice += quantity * price;
      }

      final orderData = {
        'fullName': fullName.value,
        'phone': phone.value,
        'address': address.value,
        'city': city.value,
        'postalCode': postalCode.value,
        'orderDate': DateTime.now().toIso8601String(),
        'totalPrice': totalPrice,
        'products': cartProducts,
        'status': 'pending',
      };

      // Save order to Firestore
      final orderRef = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .add(orderData);

      final orderId = orderRef.id;  // <-- capture the order document ID here


      final invoiceNumber = 'INV-${DateTime.now().millisecondsSinceEpoch}';

      // Save invoice in a separate collection for this user
      await _firestore
          .collection('medicalstores')
          .doc(medicalStoreUid)
          .collection('invoices')
          .doc(orderId) // use orderId as invoice docId or generate new if you want
          .set({
        'invoiceNumber': invoiceNumber,
        'orderId': orderId,
        'date': DateTime.now().toIso8601String(),
        'totalPrice': totalPrice,
        'status': 'pending',

      });




      // Generate invoice PDF
      File? pdfFile;
      try {
        final pdfService = Get.find<PdfService>();
        pdfFile = await pdfService.generateInvoice(orderData: orderData);
      } catch (e) {
        Get.snackbar('Warning', 'Failed to generate invoice PDF: $e');
      }

      // Send invoice email if PDF generated and email available
      if (pdfFile != null) {
        final userEmail = user.email;
        if (userEmail == null || userEmail.isEmpty) {
          Get.snackbar('Warning', 'User email unavailable. Invoice not sent.');
        } else {
          try {
            final emailService = Get.find<EmailService>();
            await emailService.sendInvoiceEmail(
              pdfFile: pdfFile,
              email: userEmail,
              orderId: orderId,  // pass Firestore document ID here
            );
          } catch (e) {
            Get.snackbar('Warning', 'Failed to send invoice email: $e');
          }
        }
      }

      // Clear cart items after order
      try {
        final batch = _firestore.batch();
        for (var doc in cartSnapshot.docs) {
          batch.delete(doc.reference);
        }
        await batch.commit();
      } catch (e) {
        Get.snackbar('Warning', 'Failed to clear cart: $e');
      }

      Get.snackbar('Success', 'Order placed successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to place order: $e');
    } finally {
      isLoading.value = false;
    }
  }

}



class ShippingScreen extends StatelessWidget {
  final ShippingController controller = Get.put(ShippingController());
  final InvoiceController controller2 = Get.put(InvoiceController());



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Shipping Details'),
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black,
      // ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
                Text("Shipping", style: AppStyle.headings),
              ],
            ),


            SizedBox(height: mediaQuery.height(3)),


            Row(
              children: [
                _stepCircle(isDone: true),
                _stepLine(isDone: true),
                _stepCircle(isDone: true),
                _stepLine(isDone: false),
                _stepCircle(isDone: false),
              ],
            ),

            SizedBox(height: mediaQuery.height(2)),

            Center(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                shadowColor: Colors.blueAccent.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title('Full Name'),
                      _textField(controller.fullName, 'Enter your full name'),
                      SizedBox(height: 20),

                      _title('Phone Number'),
                      _textField(controller.phone, 'Enter phone number', keyboardType: TextInputType.phone),
                      SizedBox(height: 20),

                      _title('Shipping Address'),
                      _textField(controller.address, 'Enter shipping address'),
                      SizedBox(height: 20),

                      _title('City'),
                      _textField(controller.city, 'Enter city'),
                      SizedBox(height: 20),

                      _title('Postal Code'),
                      _textField(controller.postalCode, 'Enter postal code', keyboardType: TextInputType.number),
                      SizedBox(height: 30),

                      // Obx(() => SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     onPressed: controller.isFormValid.value
                      //         ? () {
                      //       Get.snackbar('Success', 'Shipping info submitted');
                      //     }
                      //         : null,
                      //     style: ElevatedButton.styleFrom(
                      //       padding: EdgeInsets.symmetric(vertical: 16),
                      //       backgroundColor: Colors.blueAccent,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(12),
                      //       ),
                      //     ),
                      //     child: Text(
                      //       'Place Order',
                      //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      // )),

                      Obx(() => CustomButton(
                        text: "Place Order",
                        onPressed: () async {
                          try {
                            controller.placeOrder();

                            final pdfFile = await Get.find<PdfService>().generateInvoice(
                              orderData: controller2.orderData.value!,
                            );

                            await Get.find<EmailService>().sendInvoiceEmail(
                              pdfFile: pdfFile,
                              email: "laibicious000@gmail.com",
                              orderId: controller2.orderData.value!['orderId'].toString(), // ✅ Use map key
                            );



                            // Navigate to InvoicePage only if above succeed
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                transitionDuration: const Duration(milliseconds: 400),
                                pageBuilder: (context, animation, secondaryAnimation) => InvoicePage(),
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
                          } catch (e, stacktrace) {
                            print("Error during order/invoice/email: $e");
                            print(stacktrace);
                            Get.snackbar("Error", "Something went wrong: $e");
                          }


                        },

                        isLoading: controller.isLoading.value,
                        color: AppColor.greenMain,
                        textColor: AppColor.whiteColor,
                        borderRadius: 12,
                        isFullWidth: false,
                        height: mediaQuery.height(7),
                        width: mediaQuery.width(70),
                      )),


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey[900],
      ),
    ),
  );

  Widget _textField(RxString obsValue, String hint, {TextInputType keyboardType = TextInputType.text}) {
    final controller = TextEditingController(text: obsValue.value);

    // Sync the controller with RxString:
    controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));

    return Obx(() {
      // Update the controller text if obsValue changes externally:
      if (controller.text != obsValue.value) {
        controller.text = obsValue.value;
        controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
      }

      return TextField(
        controller: controller,
        onChanged: (val) => obsValue.value = val,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          ),
        ),
      );
    });
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

}

class ShippingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShippingController>(() => ShippingController());
  }
}



