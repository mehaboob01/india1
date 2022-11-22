import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data/local/shared_preference_keys.dart';
import 'package:http/http.dart' as http;
import '../../core/data/remote/api_constant.dart';
import 'map_model.dart';

class MapManager extends GetxController {
  var isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    getLocations();
  }

  List<MapModel> dummydata = [
    MapModel(
        distance: 1.3,
        address: "Bannerghata Main Road",
        status: "Open 24 Hours"),
    MapModel(
      distance: 12,
      address: "Bannerghata Main Road",
      status: "Closed",
    ),
    MapModel(
      distance: 2.1,
      address: "Bannerghata Main Road",
      status: "Open",
    ),
    MapModel(
        distance: 1.3,
        address: "Bannerghata Main Road",
        status: "Open 24 Hours"),
    MapModel(
      distance: 1.3,
      address: "Bannerghata Main Road",
      status: "Closed",
    ),
    MapModel(
      distance: 1.3,
      address: "NYC Main Road",
      status: "Open",
    ),
    MapModel(
        distance: 1.3, address: "Banglore Main Road", status: "Open 24 Hours"),
    MapModel(
      distance: 1.3,
      address: " Main Road",
      status: "Closed",
    ),
    MapModel(
      distance: 1.3,
      address: "Hassan",
      status: "Open",
    ),
  ];

  statusColor(index) {
    if (dummydata[index].status == "Open 24 Hours") {
      return Colors.green;
    } else if (dummydata[index].status == "Closed") {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  var latitude = 12.9075948553404.obs;
  var longitude = 77.60108253288585.obs;
  List<Marker> allMarkers = <Marker>[].obs;
  final Map<String, LatLng> markersList = const {
    "test 1": LatLng(12.9075948553404, 77.60108253288585),
    "test 2": LatLng(12.90604710573187, 77.6012971095981),
    "test 3": LatLng(12.905019912142421, 77.60148019087413),
  }.obs;

  addMarker(
    String markerId,
    LatLng loc,
  ) {
    var marker = Marker(
        markerId: MarkerId(markerId),
        position: loc,
        infoWindow: InfoWindow(title: markerId));
    allMarkers.add(marker);
  }

  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position;
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    latitude.value = position.latitude;
    longitude.value = position.longitude;
  }




  void getLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
    print("Customer Id ${customerId}");



      isLoading.value = true;
      var response = await http.get(
          Uri.parse(baseUrl + Apis.mapLocations + customerId.toString()+"&lat=12.947271&lon=77.561571"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      print("response for map==> ${response.body}");

    //   if (response.statusCode == 200 || response.statusCode == 201) {
    //     var jsonData = jsonDecode(response.body);
    //     HomeModel homeModel = HomeModel.fromJson(jsonData);
    //     print("data response");
    //     print("http success!!");
    //     print(homeModel.data);
    //
    //     if (homeModel!.status!.code == 2000) {
    //       isLoading(false);
    //       print("http success in model!!");
    //       pointsEarned.value = homeModel.data!.pointsSummary!.redeemablePoints!;
    //       pointsRedeemed.value = homeModel.data!.pointsSummary!.pointsRedeemed!;
    //       redeemablePoints.value =
    //       homeModel.data!.pointsSummary!.redeemablePoints!;
    //       atmRewards.value = homeModel.data!.atmRewards!.rewardsMultipliers![0];
    //     } else {
    //       Flushbar(
    //         title: "Error!",
    //         message: homeModel.status!.message.toString(),
    //         duration: Duration(seconds: 2),
    //       )..show(Get.context!);
    //     }
    //   } else {
    //     Flushbar(
    //       title: "Server Error!",
    //       message: "Please try after sometime ...",
    //       duration: Duration(seconds: 1),
    //     )..show(Get.context!);
    //   }
    // } catch (e) {
    //   Flushbar(
    //     title: "Server Error!",
    //     message: "Please try after sometime",
    //     duration: Duration(seconds: 1),
    //   )..show(Get.context!);
    // } finally {
    //   isLoading(false);
    // }
  }
}
