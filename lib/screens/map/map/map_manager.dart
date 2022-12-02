// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;

import '../../../constant/theme_manager.dart';
import '../../../core/data/local/shared_preference_keys.dart';
import '../../../core/data/remote/api_constant.dart';
import 'map_model.dart';

class MapManager extends GetxController {
  var mapCoordinateList = <Locations>[].obs;
  late GoogleMapController? mapController;
  var isLoading = false.obs;
  var cameraPosition = CameraPosition(target: LatLng(0, 0), zoom: 15).obs;
  var locationText = "Search Location".obs;

  @override
  void onReady() {
    getCurrentLocation();
    super.onReady();
  }

  late BitmapDescriptor customIcon;
  getCustomIcon() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(50, 70)),
      AppImages.markerIcon,
    ).then((d) {
      customIcon = d;
    });
  }

  List<Marker> allMarkersPlot = <Marker>[].obs;
  List<GeoLocation?> markersCoordinateList = <GeoLocation?>[].obs;

  addMarker(String markerId, GeoLocation? loc, index) async {
    var marker = Marker(
        onTap: () {},
        markerId: MarkerId(markerId),
        position: LatLng(loc!.lat!.toDouble(), loc.lon!.toDouble()),
        infoWindow: InfoWindow(title: mapCoordinateList[index].name));

    allMarkersPlot.add(marker);
  }

  getCurrentLocation() async {
    Position position;
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    await getAddressFromLatLong(position.latitude, position.longitude);
    getLocations(position.latitude, position.longitude);
    await animateTo(position.latitude, position.longitude);
    // cameraPosition.value = CameraPosition(
    //     target: LatLng(position.latitude, position.longitude), zoom: 13);
    // print(cameraPosition.value);
  }

  void getLocations(double lat, double long) async {
    mapCoordinateList.clear();
    markersCoordinateList.clear();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);

      isLoading.value = true;

      var response = await http.get(
          Uri.parse(baseUrl +
              Apis.mapLocations +
              customerId.toString() +
              "&lat=${lat}&lon=${long}"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      print("response for map==> ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        MapCordinatesModel mapCordinatesModel =
            MapCordinatesModel.fromJson(jsonData);

        if (mapCordinatesModel.data!.locations!.isEmpty) {
          print("Empty");
          Flushbar(
            title: "No ATM nearby",
            message: "There's no ATM nearby",
            duration: Duration(seconds: 10),
          )..show(Get.context!);
        } else {
          for (var index in mapCordinatesModel.data!.locations!) {
            mapCoordinateList.add(index);

            markersCoordinateList.add(index.geoLocation);
          }

          for (var i = 0; i < mapCoordinateList.length; i++) {
            await addMarker("$i", mapCoordinateList[i].geoLocation, i);
          }
          isLoading(false);
        }
        if (mapCordinatesModel!.status!.code == 2000) {
          isLoading(false);
        } else {
          Flushbar(
            title: "Error!",
            message: mapCordinatesModel.status!.message.toString(),
            duration: Duration(seconds: 2),
          )..show(Get.context!);
        }
      } else {
        Flushbar(
          title: "Server Error!",
          message: "Please try after sometime ...",
          duration: Duration(seconds: 1),
        )..show(Get.context!);
      }
    } catch (e) {
      Flushbar(
        title: "Server Error!",
        message: "Please try after sometime",
        duration: Duration(seconds: 1),
      )..show(Get.context!);
    } finally {
      isLoading(false);
    }
  }

  Future<void> getAddressFromLatLong(lat, long) async {
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=${Apis.kPLACES_API_KEY}';

    var response = await http.get(Uri.parse(baseURL));
    if (response.statusCode == 200) {
      locationText.value =
          (json.decode(response.body)['results'][0]["formatted_address"]);
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  Future<void> animateTo(double lat, double lng) async {
    final p = LatLng(lat, lng);
    await mapController!.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: p, zoom: 13)));
  }

  Future<void> openDirections(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch((googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }
}
