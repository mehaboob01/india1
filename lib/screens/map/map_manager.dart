import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/data/local/shared_preference_keys.dart';
import 'package:http/http.dart' as http;
import '../../core/data/remote/api_constant.dart';
import 'map_model.dart';

class MapManager extends GetxController {
  var mapCoordinateList = <Location>[].obs;
  var mapCoordinateListSend = <Location>[];

  var mapPlotList = <Location>[].obs;
  var mapPlotListSend = <Location>[];
  var isLoading = false.obs;
  var cameraPosition = CameraPosition(target: LatLng(0, 0), zoom: 15).obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  List<Marker> allMarkers = <Marker>[].obs;
  List<GeoLocation?> markersList = <GeoLocation?>[].obs;
  GoogleMapController? mapController;
  List<GeoLocation?> markersListSend = <GeoLocation?>[].obs;

  addMarker(
    String markerId,
    GeoLocation? loc,
  ) async {
    var marker = Marker(
        markerId: MarkerId(markerId),
        position: LatLng(loc!.lat!.toDouble(), loc.lon!.toDouble()),
        infoWindow: InfoWindow(title: markerId));
    allMarkers.add(marker);
  }

  Completer<GoogleMapController> _completer = Completer();

  Future<void> animateTo(double lat, double lng) async {
    final p = LatLng(lat, lng);
    await mapController!.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: p, zoom: 13)));
  }

  getCurrentLocation() async {
    Position position;

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      getLocations(position.latitude, position.longitude);
      animateTo(position.latitude, position.longitude);
    } else {
      Get.back();
    }
  }

  void getLocations(double lat, double long) async {
    mapCoordinateList.clear();
    mapCoordinateListSend.clear();
    markersList.clear();
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

        for (var index in mapCordinatesModel.data!.locations!) {
          mapCoordinateList.add(index);
          mapCoordinateListSend.add(index);
          markersList.add(index.geoLocation);
          markersListSend.add(index.geoLocation);
        }
        markersList.addAll(markersListSend);

        mapCoordinateList.addAll(mapCoordinateListSend);
        for (var i = 0; i < mapCoordinateList.length; i++) {
          addMarker("$i", mapCoordinateList[i].geoLocation);
        }
        isLoading(false);

        if (mapCordinatesModel!.status!.code == 2000) {
          isLoading(false);
          print("http success in model!!");
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

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    mapController!.dispose();
  }
}
