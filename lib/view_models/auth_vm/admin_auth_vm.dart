import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/auth/admin_user_model.dart';

class MedicalStoreController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // List of all stores (users)
  var stores = <UserModelAdmin>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllStores();
  }



  Future<void> fetchAllStores() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('medicalstores').get();

      final List<UserModelAdmin> loadedStores = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        loadedStores.add(UserModelAdmin.fromJson(data));
      }

      stores.assignAll(loadedStores);
    } catch (e) {
      print("Error fetching stores: $e");
    }
  }
}
