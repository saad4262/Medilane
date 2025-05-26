import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





import '../models/auth/user_model.dart';

import '../models/auth/user_model.dart' as gmaps;
import '../repository/location-repo/location-repo.dart';




class MapController extends GetxController {
  final PlaceRepository _repository = PlaceRepository();

  var searchResults = <PlaceSuggestion>[].obs;
  var selectedLocation = LatLng(37.7749, -122.4194).obs; // Default SF
  var markers = <Marker>{}.obs;
  var selectedPlaceDetails = Rxn<gmaps.PlaceDetails>(); // Use the alias
  GoogleMapController? mapController;
  var isFetchingLocation = true.obs; // Track loading state


  void searchPlaces(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      final results = await _repository.fetchPlaceSuggestions(query);
      searchResults.assignAll(results);
    } catch (e) {
      print("Error: $e");
    }
  }

  void selectPlace(String placeId) async {
    try {
      final gmaps.PlaceDetails details = await _repository.fetchPlaceDetails(placeId);

      selectedLocation.value = LatLng(details.lat, details.lng);
      selectedPlaceDetails.value = details;

      // Clear old markers before adding a new one
      markers.clear();
      markers.add(
        Marker(

          markerId: MarkerId(placeId),
          position: selectedLocation.value,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // Change color

          infoWindow: InfoWindow(title: details.name, snippet: details.address),
        ),
      );

      markers.refresh(); // Ensure UI updates after marker changes

      // Ensure the map controller is initialized
      if (mapController != null) {
        await mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: selectedLocation.value,
              zoom: 14.0,
              tilt: 30.0,
              bearing: 0,
            ),
          ),
        );
      }






      await Future.delayed(Duration(milliseconds: 500));
      mapController?.showMarkerInfoWindow(MarkerId(placeId));

      searchResults.clear();
      searchResults.refresh(); // Ensure search UI updates

      await saveLocationToFirestore(details.lat, details.lng, details.address);

        } catch (e) {
      print("Error selecting place: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    _getUserCurrentLocation();
  }

  Future<void> _getUserCurrentLocation() async {
    try {
      isFetchingLocation.value = true; // Start loading
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        isFetchingLocation.value = false;
        return; // Handle permission denied case
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      selectedLocation.value = LatLng(position.latitude, position.longitude);

      // Reverse Geocoding to get place name
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        selectedPlaceDetails.value = gmaps.PlaceDetails(
          name: place.name ?? "Unknown Place",
          address: "${place.street}, ${place.locality}, ${place.country}",
          lat: position.latitude,
          lng: position.longitude,
        );
      }

      // Add marker for current location
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId("current_location"),
          position: selectedLocation.value,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(
            title: selectedPlaceDetails.value?.name ?? "Your Location",
            snippet: selectedPlaceDetails.value?.address ?? "",
          ),
        ),
      );

      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: selectedLocation.value,
              zoom: 14.0,
            ),
          ),
        );
      }

      isFetchingLocation.value = false; // Stop loading
    } catch (e) {
      isFetchingLocation.value = false;
      print("Error fetching location: $e");
    }
  }


  Future<void> saveLocationToFirestore(double lat, double lng, String address) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid; // Get current user UID

      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "location": {
          "latitude": lat,
          "longitude": lng,
          "address": address,
        }
      });

      Get.snackbar("User Location", "Location Saved Successfully", backgroundColor: Colors.green);
    } catch (e) {
      print("Error saving location: $e");
    }
  }




  void setMapController(GoogleMapController controller) {
      mapController = controller;
  }
}