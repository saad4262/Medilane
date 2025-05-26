// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Product {
//   final String productId;
//   final String productName;
//   final double price;
//   final int quantity;
//
//   Product({
//     required this.productId,
//     required this.productName,
//     required this.price,
//     required this.quantity,
//   });
//
//   factory Product.fromMap(Map<String, dynamic> map) {
//     return Product(
//       productId: map['productId'] ?? '',
//       productName: map['productName'] ?? '',
//       price: (map['price'] ?? 0).toDouble(),
//       quantity: (map['quantity'] ?? 0),
//     );
//   }
// }
//
// class Order {
//   final String id;
//   final String fullName;
//   final String phone;
//   final String address;
//   final String city;
//   final String postalCode;
//   final DateTime orderDate;
//   final String status;
//   final double totalPrice;
//   final List<Product> products;
//
//   Order({
//     required this.id,
//     required this.fullName,
//     required this.phone,
//     required this.address,
//     required this.city,
//     required this.postalCode,
//     required this.orderDate,
//     required this.status,
//     required this.totalPrice,
//     required this.products,
//   });
//
//   // Here's the fromFirestore factory method:
//   factory Order.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//
//     // Parse products list from Firestore map array
//     List<Product> productsList = [];
//     if (data['products'] != null) {
//       productsList = (data['products'] as List)
//           .map((p) => Product.fromMap(p as Map<String, dynamic>))
//           .toList();
//     }
//
//     return Order(
//       id: doc.id,
//       fullName: data['fullName'] ?? '',
//       phone: data['phone'] ?? '',
//       address: data['address'] ?? '',
//       city: data['city'] ?? '',
//       postalCode: data['postalCode'] ?? '',
//       orderDate: (data['orderDate'] as Timestamp).toDate(),
//       status: data['status'] ?? 'Pending',
//       totalPrice: (data['totalPrice'] ?? 0).toDouble(),
//       products: productsList,
//     );
//   }
// }
