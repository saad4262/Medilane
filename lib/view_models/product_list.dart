
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:adminpanel1medilane/models/product_list/product_list.dart';
import 'package:adminpanel1medilane/view_models/auth_vm/auth_vm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:adminpanel1medilane/view_models/product_list/product_list.dart';
import 'package:adminpanel1medilane/models/auth/user_model.dart';

import '../models/cart_model.dart';


class ProductController2 extends GetxController {
  var searchQuery = ''.obs;
  var filteredProducts = <Product>[].obs;

  RxList<Product> cartItems = <Product>[].obs;

  RxList<CartItem> cartItems2 = <CartItem>[].obs;


  var products = <Product>[].obs;
  var selectedQuantities = <String>[].obs;
  final quantitiesOptions = ['20 mg', '30 mg', '50 mg'];

  var selectedImagePath = ''.obs;
  var selectedImageBytes = Uint8List(0).obs;
  var isLoading = false.obs; // Loading state for progress indicator
  var user = Rxn<UserModel>();


  var manufactureDate = Rxn<DateTime>();
  var expiryDate = Rxn<DateTime>();
  // Get the current user's UID
  String? get uid => FirebaseAuth.instance.currentUser?.uid;

  void setManufactureDate(DateTime date) {
    manufactureDate.value = date;
  }

  void setExpiryDate(DateTime date) {
    expiryDate.value = date;
  }


  var selectedProduct = Rx<Product?>(null);

  // Method to set the selected product
  void setSelectedProduct(Product product) {
    selectedProduct.value = product;
  }

  @override
  void onInit() {
    super.onInit();
    // Fetch user data once when the controller is created
    final uid = Get.find<AuthController3>().user.value?.uid;
    if (uid != null) {
      fetchUserProfile2(uid);
      fetchCartItems();
      everAll([searchQuery, products], (_) => applyFilter());


    }
  }

  void applyFilter() {
    if (searchQuery.value.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(products.where((p) =>
          p.name.toLowerCase().contains(searchQuery.value.toLowerCase())));
    }
  }



  Future<void> fetchUserProfile2(String uid) async {
    try {
      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('medicalstores').doc(uid).get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        // profileImage.value = userData['profileImage'] ?? '';

        user.value = UserModel(
          uid: uid,
          medicalstoreName: userData['medicalstoreName'] ?? '',
          email: userData['email'] ?? '',
          profilePic: userData['profileImage'] ?? '',
          phone: userData['phone'] ?? '',
        );
      }
    } catch (e) {
      print("Error fetching user profile: $e");
    }
  }


  // Method to pick an image
  // Future<void> pickImage() async {
  //   try {
  //     if (kIsWeb) {
  //       FilePickerResult? result = await FilePicker.platform.pickFiles(
  //         type: FileType.image,
  //         allowMultiple: false,
  //         withData: true,
  //       );
  //
  //       if (result != null && result.files.isNotEmpty) {
  //         selectedImageBytes.value = result.files.first.bytes!;
  //         selectedImagePath.value = result.files.first.name;
  //
  //         print('Picked web image: ${selectedImagePath.value}');
  //       } else {
  //         Get.snackbar('Notice', 'No image selected');
  //         print('No file selected on web');
  //       }
  //     } else {
  //       final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //       if (pickedFile != null) {
  //         selectedImagePath.value = pickedFile.path;
  //         print('Picked mobile image: ${selectedImagePath.value}');
  //       } else {
  //         Get.snackbar('Notice', 'No image selected');
  //         print('No image picked on mobile');
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to pick image: $e');
  //     print('Error picking image: $e');
  //   }
  // }


  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.value = products;
    } else {
      filteredProducts.value = products
          .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      final lowerQuery = query.toLowerCase();
      final filtered = products.where((product) {
        final name = product.name?.toLowerCase() ?? '';
        final id = product.id?.toLowerCase() ?? '';
        final category = product.category?.toLowerCase() ?? '';
        final batch = product.batchNumber?.toLowerCase() ?? '';

        return name.contains(lowerQuery) ||
            id.contains(lowerQuery) ||
            category.contains(lowerQuery) ||
            batch.contains(lowerQuery);
      }).toList();

      print("Filtered: ${filtered.length} products match '$query'");
      filteredProducts.assignAll(filtered);
    }
  }


  // Future<void> fetchProducts() async {
  //   if (uid == null) {
  //     Get.snackbar('Error', 'User not logged in');
  //     return;
  //   }
  //
  //   try {
  //     isLoading(true);
  //     final snapshot = await FirebaseFirestore.instance
  //         .collection('medicalstores')
  //         .doc(uid)
  //         .collection('products')
  //         .get();
  //
  //     products.value = snapshot.docs.map((doc) {
  //       final data = doc.data();
  //       data['id'] = doc.id;
  //       data['name'] = data['name'] ?? '';
  //       data['details'] = data['details'] ?? '';
  //       data['category'] = data['category'] ?? '';
  //       data['batchNumber'] = data['batchNumber'] ?? '';
  //       data['form'] = data['form'] ?? '';
  //       data['imageUrl'] = data['imageUrl'] ?? '';
  //       data['quantitiesAvailable'] = data['quantitiesAvailable'] != null
  //           ? List<String>.from(data['quantitiesAvailable'])
  //           : [];
  //       if (data['expiryDate'] is Timestamp) {
  //         data['expiryDate'] = (data['expiryDate'] as Timestamp).toDate();
  //       }
  //       if (data['manufactureDate'] is Timestamp) {
  //         data['manufactureDate'] = (data['manufactureDate'] as Timestamp).toDate();
  //       }
  //       data['price'] = data['price'] != null ? (data['price'] as double) : 0.0;
  //       data['purchasePrice'] = data['purchasePrice'] != null ? (data['purchasePrice'] as double) : 0.0;
  //       data['quantity'] = data['quantity'] != null ? (data['quantity'] as int) : 0;
  //
  //       return Product.fromMap(data);
  //     }).toList();
  //
  //     // Update filtered list initially to show all
  //     filteredProducts.assignAll(products);
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch products: $e');
  //   } finally {
  //     isLoading(false);
  //   }
  // }


  // Future<void> pickImage() async {
  //   try {
  //     if (kIsWeb) {
  //       // For Web, use ImagePickerWeb to pick the image and get it as bytes
  //       final pickedFile = await ImagePickerWeb.getImageAsBytes();
  //       if (pickedFile != null) {
  //         selectedImageBytes.value = pickedFile;
  //         selectedImagePath.value = 'image_from_web';  // You can set a default name or modify it
  //       } else {
  //         Get.snackbar('Error', 'No image selected');
  //       }
  //     } else {
  //       // For mobile, use ImagePicker to pick the image from the gallery
  //       final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //       if (pickedFile != null) {
  //         selectedImagePath.value = pickedFile.path;
  //       } else {
  //         Get.snackbar('Error', 'No image selected');
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to pick image: $e');
  //     print('Error picking image: $e');
  //   }
  // }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        selectedImageBytes.value = await pickedFile.readAsBytes();
        selectedImagePath.value = pickedFile.name; // just name on web
      } else {
        selectedImagePath.value = pickedFile.path;
      }
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  // Method to upload image to Firebase Storage
  Future<String> uploadImageToStorage() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child('product_images').child(fileName);

    UploadTask uploadTask;
    if (kIsWeb) {
      uploadTask = ref.putData(
        selectedImageBytes.value,
        SettableMetadata(contentType: 'image/jpeg'),
      );
    } else {
      File file = File(selectedImagePath.value);
      uploadTask = ref.putFile(file);
    }

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('Uploaded image URL: $downloadUrl');

    return downloadUrl;
  }

  // Method to add product
  Future<void> addProduct(String id, String name, String details,String category, String batchNumber, String form, double price, double purchasePrice, int quantity,
      DateTime? expiryDate,  // Add expiryDate parameter
      DateTime? manufactureDate,  // Add manufactureDate parameter
      ) async {
    if (uid == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    if (!kIsWeb && selectedImagePath.value.isEmpty) {
      Get.snackbar('Error', 'Please select an image');
      return;
    }
    if (kIsWeb && selectedImageBytes.value.isEmpty) {
      Get.snackbar('Error', 'Please select an image');
      return;
    }

    String imageUrl = await uploadImageToStorage();

    final product = Product(
      id: id,
      name: name,
      imageUrl: imageUrl,
      details: details,
      quantitiesAvailable: selectedQuantities.toList(),
      uid: uid!,  // Store the UID of the medical store/admin user

      category: category,          // e.g., 'Painkiller', 'Antibiotic', etc.
      batchNumber: batchNumber,    // entered manually
      form: form,                  // e.g., 'Tablet', 'Syrup', 'Injection'
      price: price,                // selling price
      purchasePrice: purchasePrice,// price you bought it for (if you track profit margins)
      quantity: quantity,          // total units in stock

      expiryDate: expiryDate,      // Pass nullable DateTime here
      manufactureDate: manufactureDate, // Pass nullable DateTime here
    );

    try {
      // Add product under specific user document in "medicalstores" collection
      final docRef = await FirebaseFirestore.instance
          .collection('medicalstores')
          .doc(uid)
          .collection('products')
          .add(product.toMap());

// Update the product’s internal id to match Firestore document ID
      await docRef.update({'id': docRef.id});

      // Fetch products again to update the list
      await fetchAllProducts();

      clearSelection();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add product: $e');
    }
  }

  // Method to clear selection after adding a product
  void clearSelection() {
    selectedQuantities.clear();
    selectedImagePath.value = '';
    selectedImageBytes.value = Uint8List(0);
    manufactureDate.value = null;
    expiryDate.value = null;
  }

  // Method to toggle quantity selection
  void toggleQuantity(String qty) {
    if (selectedQuantities.contains(qty)) {
      selectedQuantities.remove(qty);
    } else {
      selectedQuantities.add(qty);
    }
  }

  // Method to fetch products for the user
  Future<void> fetchAllProducts() async {
    try {
      isLoading(true); // Show loading indicator

      // Get all medical stores
      final snapshot = await FirebaseFirestore.instance
          .collection('medicalstores')
          .get(); // Get all documents from the medicalstores collection

      // Clear existing products before adding the new ones
      products.clear();

      // Loop through all medical store documents
      for (var storeDoc in snapshot.docs) {
        final storeId = storeDoc.id;
        // final storeName = storeDoc['name'] ?? 'Unknown Store'; // Get the store name


        // Fetch products from the 'products' subcollection of each medical store
        final productsSnapshot = await FirebaseFirestore.instance
            .collection('medicalstores')
            .doc(storeId) // Specify the medical store by its ID
            .collection('products') // Get the 'products' subcollection
            .get();

        // Map each product document into a Product model
        products.value.addAll(productsSnapshot.docs.map((doc) {
          final data = doc.data();
          data['storeName'] = data["storeName"];
          // Handle null values and provide default values
          data['id'] = doc.id;

          data['name'] = data['name'] ?? '';
          data['details'] = data['details'] ?? '';
          data['category'] = data['category'] ?? '';
          data['batchNumber'] = data['batchNumber'] ?? '';
          data['form'] = data['form'] ?? '';
          data['imageUrl'] = data['imageUrl'] ?? '';
          data['quantitiesAvailable'] = data['quantitiesAvailable'] != null
              ? List<String>.from(data['quantitiesAvailable'])
              : [];

          // Convert Firestore Timestamp fields to DateTime
          if (data['expiryDate'] is Timestamp) {
            data['expiryDate'] = (data['expiryDate'] as Timestamp).toDate();
          }

          if (data['manufactureDate'] is Timestamp) {
            data['manufactureDate'] = (data['manufactureDate'] as Timestamp).toDate();
          }

          // Handle potential type mismatches for fields like price, quantity, etc.
          data['price'] = data['price'] != null ? _getDoubleValue(data['price']) : 0.0;
          data['purchasePrice'] = data['purchasePrice'] != null ? _getDoubleValue(data['purchasePrice']) : 0.0;
          data['quantity'] = data['quantity'] != null ? _getIntValue(data['quantity']) : 0;

          // Return the Product object
          return Product.fromMap(data);
        }).toList());
      }

      // Update the filtered products
      filteredProducts.assignAll(products);

    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    } finally {
      isLoading(false); // Hide loading indicator
    }


  }





  Future<void> addToCart(Product product, int quantity, String mg) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart');

// Use .add() to create a new document with a unique ID
    await cartRef.add({
      'productId': product.uid,  // keep product.uid as a field for reference
      'name': product.name,
      'imageUrl': product.imageUrl,
      'price': product.price,
      'quantity': quantity,
      'mg': mg,
      'timestamp': FieldValue.serverTimestamp(),
    });

  }

  void updateCartItems(List<CartItem> items) {
    cartItems2.value = items;
  }

  // void listenToCartItems() {
  //   final userId = FirebaseAuth.instance.currentUser?.uid;
  //   if (userId == null) return;
  //
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userId)
  //       .collection('carts')
  //       .snapshots()
  //       .listen((snapshot) {
  //     final items = snapshot.docs.map((doc) {
  //       final data = doc.data();
  //       return Product(
  //         name: data['name'] ?? '',
  //         details: data['details'] ?? '',
  //         quantitiesAvailable: data['quantitiesAvailable'] ?? 0,
  //         uid: data['uid'] ?? '',
  //         category: data['category'] ?? '',
  //         batchNumber: data['batchNumber'] ?? '',
  //         form: data['form'] ?? '',
  //         purchasePrice: (data['purchasePrice'] ?? 0).toDouble(),
  //         imageUrl: data['imageUrl'] ?? '',
  //         price: (data['price'] ?? 0).toDouble(),
  //         quantity: (data['quantity'] ?? 0).toInt(),
  //         expiryDate: data['expiryDate'] != null ? (data['expiryDate'] as Timestamp).toDate() : null,
  //         manufactureDate: data['manufactureDate'] != null ? (data['manufactureDate'] as Timestamp).toDate() : null,
  //         id: doc.id,
  //
  //       );
  //
  //     }).toList();
  //
  //     cartItems.assignAll(items);
  //   });
  // }




  Future<void> removeFromCart(String productId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(productId);

    await cartRef.delete();

    // Optionally remove from your local observable cart list if you have one
    cartItems.removeWhere((item) => item.id == productId);
  }



  Future<void> fetchCartItems() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;

      final cartSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();

      final items = cartSnapshot.docs.map((doc) {
        final data = doc.data();
        return Product(
          name: data['name'] ?? '',
          details: data['details'] ?? '',
          quantitiesAvailable: data['quantitiesAvailable'] ?? 0,
          uid: data['uid'] ?? '',
          category: data['category'] ?? '',
          batchNumber: data['batchNumber'] ?? '',
          form: data['form'] ?? '',
          purchasePrice: (data['purchasePrice'] ?? 0).toDouble(),
          imageUrl: data['imageUrl'] ?? '',
          price: (data['price'] ?? 0).toDouble(),
          quantity: (data['quantity'] ?? 0).toInt(),
          expiryDate: data['expiryDate'] != null ? (data['expiryDate'] as Timestamp).toDate() : null,
          manufactureDate: data['manufactureDate'] != null ? (data['manufactureDate'] as Timestamp).toDate() : null,
          id: doc.id,

        );

      }).toList();

      cartItems.assignAll(items); // 👈 This updates the badge count
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }


// Helper function to convert values to double
  double _getDoubleValue(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return 0.0;
    }
  }

// Helper function to convert values to int
  int _getIntValue(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else {
      return 0;
    }
  }
  // Method to delete a product
  Future<void> deleteProduct(String docId) async {
    if (uid == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('medicalstores')  // Collection for medical stores
          .doc(uid)  // Document ID is the user's UID
          .collection('products')  // Subcollection for products
          .doc(docId)  // Document ID for the specific product
          .delete();  // Delete the product document

      products.removeWhere((p) => p.id == docId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete product: $e');
    }
  }
}




class DataController extends GetxController {
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2)); // simulate API call
    isLoading.value = false;
  }
}




class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;
  var totalAmount = 0.0.obs;

  StreamSubscription? _subscription;
  var isPaymentExpanded = false.obs;


  @override
  void onInit() {
    super.onInit();
    _bindCartStream();
  }


  void togglePaymentExpanded() {
    isPaymentExpanded.toggle();
  }

  void _bindCartStream() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    _subscription = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      cartItems.value = snapshot.docs.map((doc) {
        final data = doc.data();
        return CartItem(
          id: doc.id,
          name: data['name'],
          imageUrl: data['imageUrl'],
          price: (data['price'] ?? 0).toDouble(),
          quantity: data['quantity'] ?? 1,
          mg: data['mg'] ?? '',
        );
      }).toList();
      _calculateTotal();
    });
  }

  void _calculateTotal() {
    double sum = 0;
    for (var item in cartItems) {
      sum += item.price * item.quantity;
    }
    totalAmount.value = sum;
  }

  void incrementQuantity(CartItem item) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final newQty = item.quantity + 1;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(item.id)
        .update({'quantity': newQty});
  }

  void decrementQuantity(CartItem item) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final newQty = item.quantity - 1;
    if (newQty > 0) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart')
          .doc(item.id)
          .update({'quantity': newQty});
    } else {
      // Optional: Remove item from cart if quantity becomes 0
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart')
          .doc(item.id)
          .delete();
    }
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
//
//
// class CategoryController extends GetxController {
//   RxString selectedCategory = ''.obs;
//   RxList<Product> filteredProducts = <Product>[].obs;
//
//   void setCategory(String category) {
//     selectedCategory.value = category;
//     fetchProductsByCategory(category);
//   }
//
//   Future<void> fetchProductsByCategory(String category) async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) return;
//
//     final snapshot = await FirebaseFirestore.instance
//         .collection('medicalstore')
//         .doc(user.uid)
//         .collection('product')
//         .where('category', isEqualTo: category)
//         .get();
//
//     final products = snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
//     filteredProducts.assignAll(products);
//   }
// }
//



