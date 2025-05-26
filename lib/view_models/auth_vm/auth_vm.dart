import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart'; // ✅ Import Firestore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medilane/res/colors/app_color.dart';
import 'package:medilane/view/home/home_screen.dart';
import 'package:medilane/view/login/login_screen1.dart';
import 'package:path/path.dart' as path;


import '../../models/auth/user_model.dart';
import '../../repository/auth-repo/auth_repo.dart';



class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var selectedGender = "Male".obs;
  Rx<File?> selectedImage = Rx<File?>(null); // Stores the local picked image
  RxString profileImage = ''.obs; // Stores the uploaded image URL
  var selectedDate = "".obs;

  var user1 = Rxn<User>();


  var isLoading = false.obs;
  Rx<UserModel?> user = Rx<UserModel?>(null);


  @override
  void onInit() {
    super.onInit();

    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      fetchUserProfile(firebaseUser.uid);  // ✅ Fetch profile image from Firestore

      user.value = UserModel(
        uid: firebaseUser.uid,
        username: firebaseUser.displayName ?? "",
        email: firebaseUser.email ?? "",
        profilePic: firebaseUser.photoURL ?? "",
        phone: firebaseUser.phoneNumber ?? "",
      );
    }

    _auth.authStateChanges().listen((User? newUser) {
      if (newUser != null) {
        fetchUserProfile(newUser.uid);  // ✅ Fetch updated data when user logs in

        user.value = UserModel(
          uid: newUser.uid,
          username: newUser.displayName ?? "",
          email: newUser.email ?? "",
          profilePic: newUser.photoURL ?? "",
          phone: newUser.phoneNumber ?? "",
        );
      } else {
        user.value = null;
      }
    });
  }



  Future<void> signUp(String username, String email, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match!", backgroundColor: AppColor.redColor);
      return;
    }
    isLoading.value = true;
    UserModel? newUser = await _authRepository.signUp(username, email, password);
    if (newUser != null) {
      user.value = newUser;

      // ✅ Save user data in Firestore
      await _firestore.collection("users").doc(newUser.uid).set(newUser.toJson());

      print("✅ User saved to Firestore: ${newUser.toJson()}");
      Get.snackbar("Sigun", "Sigup Successfully", backgroundColor: Colors.green);

      // Get.offAll(HomeScreen());
    }
    isLoading.value = false;
  }

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    UserModel? loggedInUser = await _authRepository.login(email, password);
    if (loggedInUser != null) {
      user.value = loggedInUser;
      Get.snackbar("Login", "Login Successfully", backgroundColor: Colors.green);
      isLoading.value = false;

      return true; // ✅ Return true when login is successful

    }
    isLoading.value = false;
    return false;

  }




  void logout() async {
    await _authRepository.logout();
    user.value = null;
    Get.offAll(LoginScreen1());
  }

  void setGender(String gender) {
    selectedGender.value = gender;
  }

  void selectDate(String date) {
    selectedDate.value = date;
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      await uploadImageToFirebase();
    }
  }

  Future<void> fetchUserProfile(String uid) async {
    try {
      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        profileImage.value = userData['profileImage'] ?? ''; // ✅ Update profile image
        user.value = UserModel(
          uid: uid,
          username: userData['username'] ?? '',
          email: userData['email'] ?? '',
          profilePic: userData['profileImage'] ?? '', // ✅ Ensure correct mapping
          phone: userData['phone'] ?? '',
        );
      }
    } catch (e) {
      print("Error fetching user profile: $e");
    }
  }

//   Future<void> uploadImageToFirebase() async {
//     if (selectedImage.value == null) return;
//
//     try {
//       final AuthController authController = Get.find<AuthController>(); // Get the AuthController instance
// print(authController.user.value!.uid);
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child("profile_images/${authController.user.value!.uid}.jpg");
//
//
//       // TaskSnapshot snapshot = await storageRef.putFile(selectedImage.value!);
//       // if (snapshot.state == TaskState.success) {
//       //   String downloadURL = await snapshot.ref.getDownloadURL();
//       //   // Continue as normal
//       // } else {
//       //   print("Upload failed");
//       // }
//       String downloadURL = await storageRef.getDownloadURL();
//
//       // Update profile image in Firestore
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(authController.user.value!.uid)
//           .update({'profileImage': downloadURL});
//
//       // Update locally
//       profileImage.value = downloadURL;
//       // user.value!.profilePic = downloadURL;  // ✅ Update locally
//       user.update((user) {
//         if (user != null) {
//           user.profilePic = downloadURL;
//         }
//       }); // ✅ Update locally
//
//     } catch (e) {
//       print("Error uploading image: $e");
//     }
//   }
  Future<void> uploadImageToFirebase() async {
    if (selectedImage.value == null) return;

    try {
      final AuthController authController = Get.find<AuthController>();

      final userId = authController.user.value?.uid;
      if (userId == null) {
        print("❌ UID is null. Make sure user is logged in.");
        return;
      }

      print("Uploading for UID: $userId");


      String fileExtension = path.extension(selectedImage.value!.path); // e.g., ".png"

      final storageRef = FirebaseStorage.instance
          .ref()
          .child("profile_images/$userId$fileExtension");

      // ✅ Upload the file
      UploadTask uploadTask = storageRef.putFile(selectedImage.value!);
      TaskSnapshot snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        // ✅ Get download URL AFTER successful upload
        String downloadURL = await snapshot.ref.getDownloadURL();
        print("✅ Download URL: $downloadURL");

        // ✅ Update profile image in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'profileImage': downloadURL});

        // ✅ Update locally
        profileImage.value = downloadURL;
        user.update((user) {
          if (user != null) {
            user.profilePic = downloadURL;
          }
        });
      } else {
        print("❌ Upload failed with state: ${snapshot.state}");
      }

    } catch (e) {
      print("❌ Error uploading image: $e");
    }
  }

  // Future<void> uploadImage() async {
  //   if (selectedImage.value == null) return;
  //
  //   isLoading.value = true;
  //   try {
  //     String uid = _auth.currentUser!.uid;
  //     String filePath = "profile_pictures/$uid.jpg";
  //
  //     UploadTask uploadTask = FirebaseStorage.instance
  //         .ref()
  //         .child(filePath)
  //         .putFile(selectedImage.value!);
  //
  //     TaskSnapshot snapshot = await uploadTask;
  //     String downloadUrl = await snapshot.ref.getDownloadURL();
  //
  //     profileImage.value = downloadUrl;
  //
  //     // Update Firestore user document
  //     await _firestore.collection("users").doc(uid).update({
  //       "profileImage": downloadUrl,
  //     });
  //   } catch (e) {
  //     print("Image upload error: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }


  // Future<void> updateProfile( String uid,
  //     String username,
  //     String email,
  //     String phone,
  //     String dob,
  //     String gender, VoidCallback onSuccess,) async {
  //   isLoading.value = true;
  //
  //   try {
  //     await FirebaseFirestore.instance.collection('users').doc(uid).update({
  //       'phone': phone,
  //       'username': username,
  //       'email': email,
  //       'dob': dob,
  //       'gender': gender,
  //       'profileImage': profileImage.value, // Ensure this has the Firebase Storage URL
  //     });
  //
  //     onSuccess();
  //     Get.snackbar("Login", "Account Created Successfully", backgroundColor: Colors.green);
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to update profile: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //

  Future<void> updateProfile(String uid,String username,String email, String phone ,String dob, String gender, void showSuccessBottomSheet) async {
    isLoading.value = true;

    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'phone': phone,
        'dob': dob,
        'gender': gender,
        'email':email,
        'username':username,

        'profileImage': profileImage.value, // Ensure this has the Firebase Storage URL
      });

      Get.snackbar("Login", "Account Created Successfully", backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile: $e");
    } finally {
      isLoading.value = false;
    }
  }


  // Future<void> updateProfile(String username, String phone) async {
  //   if (user.value != null) {
  //     await _authRepository.updateProfile(user.value!.uid, username, phone);
  //     user.value!.username = username;
  //     user.value!.phone = phone;
  //     update();
  //   }
  // }
  //
  // // ✅ Upload Profile Picture
  // Future<void> uploadProfilePicture(File imageFile) async {
  //   if (user.value != null) {
  //     String imageUrl = await _authRepository.uploadProfilePicture(user.value!.uid, imageFile);
  //     user.value!.profilePic = imageUrl;
  //     update();
  //   }
  // }
  //
  // // ✅ Update Location
  // Future<void> updateLocation(double latitude, double longitude, String address) async {
  //   if (user.value != null) {
  //     await _authRepository.updateLocation(user.value!.uid, latitude, longitude, address);
  //     user.value!.location = {"latitude": latitude, "longitude": longitude, "address": address};
  //     update();
  //   }
  //   }




}


