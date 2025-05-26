import 'package:adminpanel1medilane/res/colors/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../res/app_style/app_style.dart';
import '../res/media-queries/media_query.dart';

// Product model
class Product {
  final String productName;
  final int quantity;
  final double price;

  Product({
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['productName'] ?? '',
      quantity: (map['quantity'] ?? 0) is int ? map['quantity'] : int.parse(map['quantity'].toString()),
      price: (map['price'] ?? 0).toDouble(),
    );
  }
}

// Order model
class Order {
  final String id;
  final String fullName;
  final String phone;
  final String address;
  final String city;
  final String postalCode;
  final DateTime orderDate;
  final String status;
  final double totalPrice;
  final List<Product> products;

  Order({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.orderDate,
    required this.status,
    required this.totalPrice,
    required this.products,
  });

  factory Order.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Parse products list
    final productsData = data['products'] as List<dynamic>? ?? [];

    final products = productsData.map((p) {
      return Product.fromMap(p as Map<String, dynamic>);
    }).toList();

    // Fix for orderDate being either Timestamp or String
    DateTime parsedOrderDate;
    if (data['orderDate'] is Timestamp) {
      parsedOrderDate = (data['orderDate'] as Timestamp).toDate();
    } else if (data['orderDate'] is String) {
      parsedOrderDate = DateTime.tryParse(data['orderDate']) ?? DateTime.now();
    } else {
      parsedOrderDate = DateTime.now(); // fallback
    }

    return Order(
      id: doc.id,
      fullName: data['fullName'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      postalCode: data['postalCode'] ?? '',
      orderDate: parsedOrderDate,
      status: data['status'] ?? '',
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      products: products,
    );
  }
}

// Controller for Order History
class OrderHistoryController extends GetxController {
  final RxList<Order> orders = <Order>[].obs;
  final RxBool isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUserOrders();
  }

  Future<void> fetchUserOrders() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    try {
      isLoading.value = true;

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .orderBy('orderDate', descending: true)
          .get();

      final fetchedOrders = snapshot.docs.map((doc) => Order.fromFirestore(doc)).toList();

      orders.assignAll(fetchedOrders); // 👈 This is the key line you were missing

    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch orders: $e');
    } finally {
      isLoading.value = false;
    }
  }
}



class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({Key? key}) : super(key: key);

  final OrderHistoryController controller = Get.put(OrderHistoryController());

  void showOrderDetails(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Order Details', style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _detailRow('🆔 Order ID:', order.id),
                _detailRow('👤 Name:', order.fullName),
                _detailRow('📞 Phone:', order.phone),
                _detailRow('📍 Address:', '${order.address}, ${order.city}, ${order.postalCode}'),
                _detailRow('📅 Order Date:', order.orderDate.toLocal().toString().split('.')[0]),
                _detailRow('🚚 Status:', order.status),
                _detailRow('💵 Total Price:', '\$${order.totalPrice.toStringAsFixed(2)}'),
                const SizedBox(height: 12),
                const Text('🛒 Products:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...order.products.map((p) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    '• ${p.productName} x${p.quantity} — \$${(p.price * p.quantity).toStringAsFixed(2)}',
                  ),
                )),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          children: [
            TextSpan(text: '$label ', style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Order History'),
      //   elevation: 2,
      //   backgroundColor: Colors.deepPurple,
      // ),
      body: Column(
        children: [


          SizedBox(height: mediaQuery.height(5),),
          Padding(
          padding: mediaQuery.paddingSymmetric(horizontal: 5),
            child: Row(
              children: [
                IconButton(
                  icon: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey.shade200,
                    child: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                  ),
                  onPressed: () => Get.back(),
                ),
                SizedBox(width: mediaQuery.width(10)),
                Text("Order History", style: AppStyle.headings),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.orders.isEmpty) {
                return const Center(child: Text('No orders found.'));
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.orders.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final order = controller.orders[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple.shade100,
                        child: Text('${index + 1}', style: AppStyle.headings.copyWith(color: AppColor.blueMain),),
                      ),
                      title: Text('Order #${order.id.substring(0, 6)}',
                          style: AppStyle.headings.copyWith(fontSize: 16)),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Status: ${order.status}',style: AppStyle.descriptions.copyWith(color: Colors.grey,fontSize: 13),
                            ),
                            Text('Total: ${order.totalPrice.toStringAsFixed(2)}\ Rs',style: AppStyle.descriptions.copyWith(fontSize: 13),
                            ),
                            Text(
                              'Date: ${order.orderDate.toLocal().toString().split('.')[0]}',
                              style: AppStyle.descriptions.copyWith(color: Colors.grey,fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => showOrderDetails(context, order),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
