import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  // List to store the data coming from API;
  var mapCoordinateList = <Locations>[].obs;

  // A google map controller
  late GoogleMapController? mapController;

  //to show indicator if loading
  var isLoading = false.obs;

  // providing initial camera poistion
  var cameraPosition = CameraPosition(target: LatLng(12.9715998,
      77.594563), zoom: 15).obs;

  // Boolean value to check if suggestions should be visible
  RxBool areSuggestionsVisible = false.obs;

  // Controller for listview animation
  var scrollableController = DraggableScrollableController().obs;

  // List to store autocomplete suggestions
  RxList placeList = [].obs;

  // this is the list shown on UI as markers
  List<Marker> allMarkersPlot = <Marker>[].obs;

  // List to store geolocation data that is to be added to markers
  List<GeoLocation?> markersCoordinateList = <GeoLocation?>[].obs;

  // Text editing controller
  var controller = TextEditingController().obs;

  @override
  void onReady() {
    // Calling this function 1 frame after init...
    getCurrentLocation();
    super.onReady();
  }

  getCurrentLocation() async {
    // clearing map data coming from API
    mapCoordinateList.clear();

    // Getting current coordinates of the device
    Position position;
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    //API Call method
    getLocations(position.latitude, position.longitude);

    // Getting the address that is to be displayed after getting suggestions
    await getAddressFromLatLong(position.latitude, position.longitude);

    // animating camera to current location
    await animateTo(position.latitude, position.longitude);
  }

  // API CALL TO GET NEARBY ATM's

  void getLocations(double lat, double long) async {
    mapCoordinateList.clear();
    markersCoordinateList.clear();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
      String? accessToken = prefs.getString(SPKeys.ACCESS_TOKEN);

      isLoading.value = true;

      var response = await http.get(
          Uri.parse(baseUrl +
              Apis.mapLocations +
              customerId.toString() +
              "&lat=$lat&lon=$long"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234",
            "Authorization": "Bearer " + accessToken.toString()
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        MapCordinatesModel mapCordinatesModel =
            MapCordinatesModel.fromJson(jsonData);

        if (mapCordinatesModel.data!.locations!.isEmpty) {
          // Flushbar(
          //   title: "No ATM nearby",
          //   message: "There's no ATM nearby",
          //   duration: Duration(seconds: 10),
          // )..show(Get.context!);
          Fluttertoast.showToast(
            msg: "There is no ATM nearby",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        } else {
          // Called when there is successful response
          for (var element in mapCordinatesModel.data!.locations!) {
            // adds every element to map cordinates list
            mapCoordinateList.add(element);
            // adds just the geolocation to map coordinates list
            markersCoordinateList.add(element.geoLocation);
          }
          // this methods calls to add markers
          for (var i = 0; i < mapCoordinateList.length; i++) {
            await addMarker("$i", mapCoordinateList[i].geoLocation, i);
          }
          isLoading(false);
        }
        if (mapCordinatesModel!.status!.code == 2000) {
          isLoading(false);
        } else {
          Fluttertoast.showToast(
            msg: "Error! ${mapCordinatesModel.status!.message.toString()}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Server Error! Please try again later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Server Error! Please try again later",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      isLoading(false);
    }
  }

  //Function to add markers

  addMarker(String markerId, GeoLocation? loc, index) async {
    var marker = Marker(
      markerId: MarkerId(markerId),
      position: LatLng(loc!.lat!.toDouble(), loc.lon!.toDouble()),
      infoWindow: InfoWindow(title: mapCoordinateList[index].name),
    );

    allMarkersPlot.add(marker);
  }

  // Bitmap descriptor for custom Icon
  late BitmapDescriptor customIcon;

  // Function to create a custom icon
  getCustomIcon() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(50, 70)),
      AppImages.markerIcon,
    ).then((d) {
      customIcon = d;
    });
  }

  // Getting address from current location to show in search field.
  Future<void> getAddressFromLatLong(lat, long) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=${Apis.kPLACES_API_KEY}';

    var response = await http.get(Uri.parse(baseURL));
    if (response.statusCode == 200) {
      controller.value.text =
          (json.decode(response.body)['results'][0]["formatted_address"]);
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  // Function to animate camera to specified latitude and longitude.
  Future<void> animateTo(double lat, double lng) async {
    final p = LatLng(lat, lng);
    await mapController!.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: p, zoom: 13)));
  }

  // Getting latitude and longitude from a formatted address
  void getLatLng(String placeId) async {
    String baseURL =
        "https://maps.googleapis.com/maps/api/geocode/json?place_id=$placeId&key=${Apis.kPLACES_API_KEY}";
    var response = await http.get(Uri.parse(baseURL));
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      var lat = result["results"][0]["geometry"]["location"]["lat"];
      var lng = result["results"][0]["geometry"]["location"]["lng"];
      mapController!
          .animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(lat, lng), zoom: 14)))
          .then((value) {
        getLocations(lat, lng);
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  // Getting suggestions from autocomplete places api
  void getSuggestion(String input) async {
    areSuggestionsVisible.value = false;
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&components=country:IN& &types=establishment&key=${Apis.kPLACES_API_KEY}';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      print(response.body);
      placeList.value = json.decode(response.body)['predictions'];
      if (placeList.value.isNotEmpty) {
        areSuggestionsVisible.value = true;
      }
    } else {
      areSuggestionsVisible.value = false;
      throw Exception('Failed to load predictions');
    }
  }

  // Function to determine the count of suggestions to be displayed
  int itemCount(int count) {
    if (count < 5) {
      return count;
    } else {
      return 5;
    }
  }

  // Function to open maps application on mobile while passing latitude and longitude
  Future<void> openDirections(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch((googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }

  // Function to bring the selected tile to the index of 0 for better UX
  bringSelectedTileToFirst(int index) async {
    var temp;
    temp = mapCoordinateList[index];
    mapCoordinateList[index] = mapCoordinateList[0];
    mapCoordinateList[0] = temp;
    mapCoordinateList[0].isHighlighted = true;
  }

  // Function to ensure only one tile is highlighted
  removeHighlights() {
    for (var element in mapCoordinateList) {
      if (element.isHighlighted == true) {
        element.isHighlighted = false;
      }
    }
  }
}
