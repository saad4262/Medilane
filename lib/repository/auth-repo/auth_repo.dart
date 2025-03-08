import 'dart:io';

import '../../models/auth/user_model.dart';
import '../../services/auth/auth_service.dart';

class AuthRepository {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  Future<UserModel?> signUp(String username, String email, String password) {
    return _firebaseAuthService.signUp(username, email, password);
  }

  Future<UserModel?> login(String email, String password) {
    return _firebaseAuthService.login(email, password);
  }

  Future<void> logout() {
    return _firebaseAuthService.logout();
  }

  Future<void> updateUser(UserModel user) async {
    await _firebaseAuthService.updateProfile(user);
  }

  Future<String> uploadProfilePic(String uid, File imageFile) async {
    return await _firebaseAuthService.uploadProfilePic(uid, imageFile);
  }


}
