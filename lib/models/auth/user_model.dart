class UserModel {
  String uid;
  String username;
  String email;
  Map<String, dynamic>? location;
  String phone;
  String profilePic;
  String dob;
  String gender;

  UserModel({required this.uid, required this.username, required this.email ,
    this.location,
    this.phone = "",
    this.profilePic = "",
    this.dob = "",
    this.gender = "Male",
  });

  // Convert UserModel to a Map (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
      "phone": phone,
      "profilePic": profilePic,
      "dob": dob,
      "gender": gender,
      "location": location,
    };
  }

  // Convert Firestore Map to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      username: json["username"],
      email: json["email"],
      phone: json["phone"] ?? "",
      profilePic: json["profilePic"] ?? "",
      dob: json["dob"] ?? "",
      gender: json["gender"] ?? "Male",
      location: json["location"] ?? {},
    );
  }
}

class PlaceSuggestion {
  final String placeId;
  final String description;

  PlaceSuggestion({required this.placeId, required this.description});

  factory PlaceSuggestion.fromJson(Map<String, dynamic> json) {
    return PlaceSuggestion(
      placeId: json['place_id'],
      description: json['description'],
    );
  }
}

class PlaceDetails {
  final double lat;
  final double lng;
  final String address;
  final String name;

  PlaceDetails({
    required this.lat,
    required this.lng,
    required this.address,
    required this.name,
  });

  factory PlaceDetails.fromJson(Map<String, dynamic> json) {
    final result = json['result'];
    return PlaceDetails(
      lat: result['geometry']['location']['lat'],
      lng: result['geometry']['location']['lng'],
      address: result['formatted_address'] ?? "No address available",
      name: result['name'] ?? "No name available",
    );
  }
}
