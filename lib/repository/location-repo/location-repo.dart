import '../../models/auth/user_model.dart';





import 'dart:convert';
import 'package:http/http.dart' as http;

class PlaceRepository {
  static const String apiKey = "AlzaSyAnMKQD7qbvqi_JgWiJXrBuS3De-Zu7Q4K";
  static const String baseUrl = "https://maps.gomaps.pro/maps/api/place";

  Future<List<PlaceSuggestion>> fetchPlaceSuggestions(String input) async {
    final url = "$baseUrl/autocomplete/json?input=$input&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['predictions'] as List)
          .map((e) => PlaceSuggestion.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load place suggestions");
    }
  }

  Future<PlaceDetails> fetchPlaceDetails(String placeId) async {
    final url = "$baseUrl/details/json?place_id=$placeId&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PlaceDetails.fromJson(data);
    } else {
      throw Exception("Failed to load place details");
    }
  }
}
