import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:medilane/view/home/home_screen.dart';
import '../../res/app_style/app_style.dart';
import '../../res/colors/app_color.dart';
import '../../res/media-queries/media_query.dart';
import '../../res/widgets/custom_button2.dart';


import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show Uint8List, rootBundle;


class InvoiceController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<Map<String, dynamic>?> orderData = Rx<Map<String, dynamic>?>(null);
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrder();
  }

  Future<void> fetchOrder() async {
    final user = _auth.currentUser;
    if (user == null) {
      Get.snackbar("Error", "User not logged in");
      return;
    }

    try {
      isLoading.value = true;
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .orderBy('orderDate', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        orderData.value = snapshot.docs.first.data();
      } else {
        Get.snackbar("No Orders", "You have not placed any orders yet.");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

class InvoicePage extends StatelessWidget {
  final InvoiceController controller = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);

    return Scaffold(

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.orderData.value ?? {};
        final products = data['products'] ?? [];

        return SingleChildScrollView(
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
                  Text("Invoice", style: AppStyle.headings),
                ],
              ),


              SizedBox(height: mediaQuery.height(3)),


              Row(
                children: [
                  _stepCircle(isDone: true),
                  _stepLine(isDone: true),
                  _stepCircle(isDone: true),
                  _stepLine(isDone: true),
                  _stepCircle(isDone: true),
                ],
              ),

              SizedBox(height: mediaQuery.height(2)),

              // 🚚 Animated Delivery Icon
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: Lottie.asset(
                    'assets/lottie/bike.json',
                    width: 300,
                    repeat: true,
                  ),
                ),
              ),

              SizedBox(height: mediaQuery.height(7)),


              Center(child: Text("Thankyou",style: AppStyle.headings2,)),

              SizedBox(height: mediaQuery.height(2)),

              Center(
                child: Container(
                  width: mediaQuery.width(80),
                  child: Text(
                    "Your Order will be delivered with invoice #9ds69hs.You can track the delivery in the order section.",
                    textAlign: TextAlign.center,
                  )

                ),
              ),


              SizedBox(height: mediaQuery.height(5)),

              Center(
                child: CustomButton2(
                  text: "Go to HomePage",
                  onPressed: () {

                    Get.offAll(HomeScreen());

                  },
                  color: AppColor.greenMain,
                  textColor: AppColor.whiteColor,
                  borderRadius: 12,
                  isFullWidth: false,
                  height: mediaQuery.height(7),
                  width: mediaQuery.width(70),
                ),
              ),



              // 📋 Customer Information
              // _section("Customer Details", [
              //   _infoRow("Name", data['fullName'] ?? "-"),
              //   _infoRow("Phone", data['phone'] ?? "-"),
              //   _infoRow(
              //       "Address",
              //       "${data['address'] ?? ''}, ${data['city'] ?? ''} - ${data['postalCode'] ?? ''}"),
              //   _infoRow(
              //       "Date",
              //       data['orderDate'] != null
              //           ? DateFormat.yMMMd()
              //           .format(data['orderDate'].toDate())
              //           : "-"),
              // ]),
              //
              // const SizedBox(height: 20),
              //
              // // 🛍️ Products List
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: Text("Products",
              //       style: TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //           color: AppColor.greenMain)),
              // ),
              // const SizedBox(height: 8),
              //
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: products.length,
              //   itemBuilder: (context, index) {
              //     final product = products[index];
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 16, vertical: 8),
              //       child: Material(
              //         elevation: 6,
              //         borderRadius: BorderRadius.circular(16),
              //         child: Container(
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(16),
              //             gradient: LinearGradient(
              //               colors: [Colors.white, Colors.green.shade50],
              //               begin: Alignment.topLeft,
              //               end: Alignment.bottomRight,
              //             ),
              //           ),
              //           child: ListTile(
              //             contentPadding: const EdgeInsets.symmetric(
              //                 horizontal: 20, vertical: 12),
              //             title: Text(
              //               product['productName'] ?? '',
              //               style: const TextStyle(
              //                   fontSize: 18, fontWeight: FontWeight.bold),
              //             ),
              //             subtitle: Text(
              //               "Qty: ${product['quantity']} × \$${product['price']}",
              //               style: TextStyle(fontSize: 14),
              //             ),
              //             trailing: Text(
              //               "\$${(product['quantity'] * product['price']).toStringAsFixed(2)}",
              //               style: const TextStyle(
              //                   fontWeight: FontWeight.bold, fontSize: 16),
              //             ),
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
              //
              // const SizedBox(height: 20),
              //
              // // 💰 Total
              // Padding(
              //   padding:
              //   const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       const Text("Total: ",
              //           style: TextStyle(
              //               fontSize: 18, fontWeight: FontWeight.w600)),
              //       Text(
              //         "\$${(data['totalPrice'] ?? 0).toStringAsFixed(2)}",
              //         style: TextStyle(
              //           fontSize: 22,
              //           fontWeight: FontWeight.bold,
              //           color: AppColor.greenMain,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              //
              // const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }
//
//   Widget _section(String title, List<Widget> children) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.shade300,
//               blurRadius: 10,
//               offset: Offset(0, 6),
//             )
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title,
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: AppColor.greenMain)),
//             const SizedBox(height: 12),
//             ...children
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _infoRow(String label, String value) => Padding(
//     padding: const EdgeInsets.symmetric(vertical: 6),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "$label: ",
//           style: const TextStyle(fontWeight: FontWeight.w600),
//         ),
//         Expanded(
//           child: Text(value,
//               style: const TextStyle(fontWeight: FontWeight.w400)),
//         ),
//       ],
//     ),
//   );



  // Future<pw.Document> generateInvoicePdf(Map<String, dynamic> orderData) async {
  //   final pdf = pw.Document();
  //
  //   final products = orderData['products'] ?? [];
  //
  //   pdf.addPage(
  //     pw.Page(
  //       build: (context) {
  //         return pw.Column(
  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //           children: [
  //             pw.Text('Invoice', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
  //             pw.SizedBox(height: 20),
  //             pw.Text('Order Date: ${DateFormat.yMMMd().format(orderData['orderDate'].toDate())}'),
  //             pw.SizedBox(height: 10),
  //             pw.Text('Products:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
  //             pw.ListView.builder(
  //               itemCount: products.length,
  //               itemBuilder: (context, index) {
  //                 final product = products[index];
  //                 return pw.Row(
  //                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     pw.Text(product['productName'] ?? ''),
  //                     pw.Text('Qty: ${product['quantity']}'),
  //                     pw.Text('\$${product['price']}'),
  //                     pw.Text('\$${(product['quantity'] * product['price']).toStringAsFixed(2)}'),
  //                   ],
  //                 );
  //               },
  //             ),
  //             pw.SizedBox(height: 20),
  //             pw.Row(
  //               mainAxisAlignment: pw.MainAxisAlignment.end,
  //               children: [
  //                 pw.Text('Total: \$${(orderData['totalPrice'] ?? 0).toStringAsFixed(2)}',
  //                     style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18)),
  //               ],
  //             )
  //           ],
  //         );
  //       },
  //     ),
  //   );
  //
  //   return pdf;
  // }
  //
  //
  // Future<String> uploadPdfToStorage(Uint8List pdfBytes, String fileName) async {
  //   final storageRef = FirebaseStorage.instance.ref().child('invoices/$fileName.pdf');
  //   final uploadTask = storageRef.putData(pdfBytes, SettableMetadata(contentType: 'application/pdf'));
  //   await uploadTask.whenComplete(() => null);
  //   final downloadUrl = await storageRef.getDownloadURL();
  //   return downloadUrl;
  // }


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




class PdfService extends GetxService {
  Future<File> generateInvoice({
    required Map<String, dynamic> orderData,
  }) async {
    final pdf = pw.Document();
    final fileName = "invoice_${DateTime.now().millisecondsSinceEpoch}.pdf";

    final userInfo = """
Name: ${orderData['fullName']}
Phone: ${orderData['phone']}
Address: ${orderData['address']}, ${orderData['city']} - ${orderData['postalCode']}
Date: ${DateTime.now()}
""";

    // pdf.addPage(
    //   pw.MultiPage(
    //     build: (context) => [
    //       pw.Text("INVOICE", style: pw.TextStyle(fontSize: 24)),
    //       pw.SizedBox(height: 16),
    //       pw.Text(userInfo),
    //       pw.SizedBox(height: 20),
    //       pw.Table.fromTextArray(
    //         headers: ['Product', 'Qty', 'Price'],
    //         data: List<List<String>>.from(
    //           (orderData['products'] as List).map((item) => [
    //             item['productName'],
    //             item['quantity'].toString(),
    //             '\$${item['price']}',
    //           ]),
    //         ),
    //       ),
    //       pw.SizedBox(height: 20),
    //       pw.Text("Total: \$${orderData['totalPrice']}", style: pw.TextStyle(fontSize: 18)),
    //     ],
    //   ),
    // );

    final data = (orderData['products'] as List).map<List<String>>((item) {
      return [
        item['productName'].toString(),
        item['quantity'].toString(),
        '\$${item['price'].toString()}',
      ];
    }).toList();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Text("INVOICE", style: pw.TextStyle(fontSize: 24)),
          pw.SizedBox(height: 16),
          pw.Text(userInfo),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            headers: ['Product', 'Qty', 'Price'],
            data: data,
          ),
          pw.SizedBox(height: 20),
          pw.Text("Total: \$${orderData['totalPrice']}", style: pw.TextStyle(fontSize: 18)),
        ],
      ),
    );


    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(await pdf.save());

    return file;
  }
}



class EmailService extends GetxService {
  final String functionUrl = "https://us-central1-medilane-8bdc2.cloudfunctions.net/sendInvoiceEmail";

  Future<void> sendInvoiceEmail({
    required File pdfFile,
    required String email,
    required String orderId, // ✅ Add this parameter
  }) async {
    final bytes = await pdfFile.readAsBytes();
    final base64PDF = base64Encode(bytes);

    final response = await http.post(
      Uri.parse(functionUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'base64Pdf': base64PDF,   // ✅ Correct key
        'orderId': orderId,       // ✅ Add this
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Invoice sent to $email");
    } else {
      throw Exception("Failed to send invoice: ${response.body}");
    }
  }

}
