import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/auth/user_model.dart';


class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;


  // ✅ Signup Method
  Future<UserModel?> signUp(String username, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      UserModel newUser = UserModel(uid: uid, username: username, email: email,);

      // Store user data in Firestore
      await _firestore.collection("users").doc(uid).set(newUser.toJson());

      return newUser;
    } catch (e) {
      print("Signup Error: $e");
      return null;
    }
  }

  // ✅ Login Method
  Future<UserModel?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      // Fetch user details from Firestore
      DocumentSnapshot userDoc = await _firestore.collection("users").doc(uid).get();
      if (userDoc.exists) {
        return UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  // ✅ Logout Method
  Future<void> logout() async {
    await _auth.signOut();
  }


  Future<void> updateProfile(UserModel user) async {
    await _firestore.collection("users").doc(user.uid).update(user.toJson());
  }
  Future<String> uploadProfilePic(String uid, File imageFile) async {
    try {
      Reference ref = _storage.ref().child("profile_pics/$uid.jpg");
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print("Profile Picture Upload Error: $e");
      return "";
    }
  }

//
// Future<void> updateProfile(String uid, String username, String phone) async {
//   await _firestore.collection("users").doc(uid).update({
//     "username": username,
//     "phone": phone,
//   });
// }
//
// // ✅ Upload Profile Picture
// Future<String> uploadProfilePicture(String uid, File imageFile) async {
//   try {
//     Reference ref = _storage.ref().child("profile_pics/$uid.jpg");
//     UploadTask uploadTask = ref.putFile(imageFile);
//     TaskSnapshot taskSnapshot = await uploadTask;
//     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//
//     await _firestore.collection("users").doc(uid).update({"profilePic": downloadUrl});
//     return downloadUrl;
//   } catch (e) {
//     print("Profile Picture Upload Error: $e");
//     return "";
//   }
// }
//
// // ✅ Update Location
// Future<void> updateLocation(String uid, double latitude, double longitude, String address) async {
//   await _firestore.collection("users").doc(uid).update({
//     "location": {"latitude": latitude, "longitude": longitude, "address": address}
//   });
// }
}