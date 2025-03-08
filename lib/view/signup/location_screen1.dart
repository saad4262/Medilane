import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medilane/res/assets/image_assets.dart';
import 'package:medilane/res/routes/routes_name.dart';
import 'package:medilane/res/widgets/custom_button.dart';
import 'package:medilane/view_models/auth_vm/auth_vm.dart';
import '../../res/colors/app_color.dart';
import '../../res/media-queries/media_query.dart';
import '../../view_models/location_vm.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  final MapController controller = Get.put(MapController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQueryHelper(context);

    return Scaffold(
      body: Stack(
        children: [

          Obx(() => Container(
                key: ValueKey(
                    controller.selectedLocation.value), // Forces UI rebuild

                child: GoogleMap(
                  onMapCreated: controller.setMapController,
                  initialCameraPosition: CameraPosition(
                    target: controller.selectedLocation.value,
                    zoom: 14,
                  ),
                  markers: controller.markers.toSet(),
                ),
              )),
          Obx(() => controller.searchResults.isNotEmpty
              ? Padding(
                  padding:
                      const EdgeInsets.only(top: 180.0, left: 15, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26, // Soft shadow effect
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          15), // Ensures content respects borders
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            vertical: 10), // Adds spacing inside
                        itemCount: controller.searchResults.length,
                        itemBuilder: (context, index) {
                          final place = controller.searchResults[index];
                          return Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.location_on,
                                    color: Colors.blueAccent),
                                title: Text(
                                  place.description,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                onTap: () {
                                  controller.selectPlace(place.placeId);
                                },
                              ),
                              if (index != controller.searchResults.length - 1)
                                Divider(
                                    thickness: 1,
                                    color: Colors.grey[300]), // Separator
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink()),
          Obx(
                () {
              final placeDetails = controller.selectedPlaceDetails.value;

              if (placeDetails == null) {
                // Show CircularProgressIndicator first
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColor.blueMain,
                  ),
                );
              }

              return Positioned(
                bottom: 120,
                left: 15,
                right: 15,
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location Details'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF234F68),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              child: Image.asset(ImageAssets.marker),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                placeDetails.address,
                                style: TextStyle(fontSize: 14),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Obx(
          //   () => controller.selectedPlaceDetails.value != null
          //       //     ? Align(
          //       //   alignment: Alignment.bottomCenter,
          //       //   child: Card(
          //       //     margin: EdgeInsets.all(10),
          //       //     child: Padding(
          //       //       padding: EdgeInsets.all(10),
          //       //       child: Column(
          //       //         mainAxisSize: MainAxisSize.min,
          //       //         children: [
          //       //           Text(
          //       //             "Name: ${controller.selectedPlaceDetails.value!.name}",
          //       //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //       //           ),
          //       //           Text(
          //       //             "Address: ${controller.selectedPlaceDetails.value!.address}",
          //       //             style: TextStyle(fontSize: 14),
          //       //           ),
          //       //         ],
          //       //       ),
          //       //     ),
          //       //   ),
          //       // )
          //       ? Positioned(
          //           bottom: 120,
          //           left: 15,
          //           right: 15,
          //           child: Card(
          //             elevation: 5,
          //             child: Padding(
          //               padding: const EdgeInsets.all(16.0),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     ' Location Details',
          //                     style: const TextStyle(
          //                         fontWeight: FontWeight.bold,
          //                         fontSize: 18,
          //                         color: Color(0xFF234F68)),
          //                   ),
          //                   const SizedBox(height: 5),
          //                   Row(
          //                     children: [
          //                       Container(
          //                         height: 50,
          //                         child: Image.asset(ImageAssets.marker),
          //                       ),
          //                       const SizedBox(width: 10),
          //                       Expanded(
          //                         child: Text(
          //                           controller
          //                               .selectedPlaceDetails.value!.address,
          //                           style: TextStyle(fontSize: 14),
          //                           maxLines: 3,
          //                           overflow: TextOverflow.ellipsis,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         )
          //       // : Align(
          //       //     alignment: Alignment.bottomCenter,
          //       //     child: Card(
          //       //       margin: EdgeInsets.all(10),
          //       //       child: Padding(
          //       //         padding: EdgeInsets.all(10),
          //       //         child: Column(
          //       //           mainAxisSize: MainAxisSize.min,
          //       //           children: [
          //       //             Text(
          //       //               "Your Current Location",
          //       //               style: TextStyle(
          //       //                   fontSize: 16, fontWeight: FontWeight.bold),
          //       //             ),
          //       //             Text(
          //       //               "Lat: ${controller.selectedLocation.value.latitude}, Lng: ${controller.selectedLocation.value.longitude}",
          //       //               style: TextStyle(fontSize: 14),
          //       //             ),
          //       //           ],
          //       //         ),
          //       //       ),
          //       //     ),
          //       //   ),
          //   : CircularProgressIndicator(
          //
          //       color: AppColor.greenMain,
          //   )
          // ),

          Positioned(
            child: Padding(
              padding: mediaQuery.paddingOnly(left: 6, top: 5),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFFF5F4F8),
                    child: Icon(Icons.arrow_back_ios_new)),
              ),
            ),
          ),
          Positioned(
            top: 110,
            left: 15,
            right: 15,
            child: Padding(
              padding: const EdgeInsets.all(10),
              // child: TextField(
              //   onChanged: (query) => controller.searchPlaces(query),
              //   decoration: InputDecoration(
              //     hintText: "Search location",
              //     prefixIcon: Icon(Icons.search),
              //     suffixIcon: IconButton(
              //       icon: Icon(Icons.cancel),
              //       onPressed: () {
              //         controller.searchResults.clear();
              //       },
              //     ),
              //   ),
              // ),
              child: TextField(
                onChanged: (query) => controller.searchPlaces(query),
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.settings_voice_rounded,
                    color: AppColor.blueMain,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColor.blueMain,
                  ),
                  hintText: 'Find Location'.tr,
                  filled: true,
                  fillColor: Color(0xFFF5F4F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: mediaQuery.height(4),
            left: mediaQuery.width(15),
            child: CustomButton(
                text: "Choose your location".tr,
                isLoading: authController.isLoading.value,
                color: AppColor.greenMain,
                textColor: AppColor.whiteColor,
                borderRadius: 12,
                isFullWidth: false,
                height: mediaQuery.height(7),
                width: mediaQuery.width(70),
                onPressed: () {
                  if (controller.selectedPlaceDetails.value != null) {
                    controller.selectPlace(
                        controller.selectedPlaceDetails.value!.name);

                    // Navigate after ensuring the location is set
                    Future.delayed(Duration(milliseconds: 200), () {
                      Get.toNamed(RouteName.ProfileScreen);
                    });
                  } else {
                    Get.snackbar("Error", "Please select a location first!");
                  }
                }),
          )
        ],
      ),
    );
  }
}
