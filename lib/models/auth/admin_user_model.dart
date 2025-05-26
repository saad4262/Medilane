class UserModelAdmin {
  String uid;
  String medicalstoreName;
  String email;
  String phone;
  String profilePic;

  UserModelAdmin({
    required this.uid,
    required this.medicalstoreName,
    required this.email,
    this.phone = "",
    this.profilePic = "",
  });

  factory UserModelAdmin.fromJson(Map<String, dynamic> json) {
    return UserModelAdmin(
      uid: json['uid'],
      medicalstoreName: json['medicalstoreName'],
      email: json['email'],
      phone: json['phone'] ?? '',
      profilePic: json['profilePic'] ?? '',
    );
  }
}
