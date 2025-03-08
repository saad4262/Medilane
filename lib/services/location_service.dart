//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
//
// import '../models/auth/user_model.dart';
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class MapService {
//   static const String _apiKey = "AlzaSyAnMKQD7qbvqi_JgWiJXrBuS3De-Zu7Q4K";
//
//   // Fetch place suggestions from Google Places API
//   Future<List<Map<String, dynamic>>> getPlaceSuggestions(String query) async {
//     String url =
//         "https://maps.gomaps.pro/maps/api/place/autocomplete/json?input=$query&key=$_apiKey";
//     final response = await http.get(Uri.parse(url));
//     final data = json.decode(response.body);
//
//     if (response.statusCode == 200) {
//       return data["predictions"];
//     } else {
//       throw Exception("Failed to fetch suggestions");
//     }
//   }
//
//   // Get selected place details
//   Future<PlaceModel> getPlaceDetails(String placeId) async {
//     String url =
//         "https://maps.gomaps.pro/maps/api/place/details/json?place_id=$placeId&key=$_apiKey";
//     final response = await http.get(Uri.parse(url));
//     final data = json.decode(response.body);
//
//     if (response.statusCode == 200) {
//       return PlaceModel.fromJson(data["result"]);
//     } else {
//       throw Exception("Failed to fetch place details");
//     }
//   }
// }
//
