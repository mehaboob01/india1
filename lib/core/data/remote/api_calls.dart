import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:india_one/core/data/local/shared_prefer_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/routes.dart';
import '../local/shared_preference_keys.dart';
import 'api_constant.dart';

class ApiCalls {
  var client = http.Client();

  //GET
  Future<dynamic> get(String api) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);

    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "x-digital-api-key": "1234",
      "Authorization": "Bearer " + accessToken.toString()
    };

    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      // throw exception and catch it in UI
      Fluttertoast.showToast(
        msg: "Server Error ...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    }
  }

  // post request
  Future<dynamic> post(String api, Map<String, String> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(data);
    var _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "x-digital-api-key": "1234",
      "Authorization": "Bearer " + accessToken.toString()
    };

    var response = await client.post(url, body: _payload, headers: _headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      // Fluttertoast.showToast(
      //   msg: "Server Error ...",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   fontSize: 16.0,
      // );
    }
  }

  // put request
  Future<dynamic> put(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "x-digital-api-key": "1234",
      "Authorization": "Bearer " + SPUtil.getString(SPKeys.ACCESS_TOKEN)
    };

    var response = await client.put(url, body: _payload, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

  // delete request
  Future<dynamic> delete(String api) async {
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "x-digital-api-key": "1234",
      "Authorization": "Bearer " + SPUtil.getString(SPKeys.ACCESS_TOKEN)
    };

    var response = await client.delete(url, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
    }
  }

  Future<dynamic> postForRefreshToken(
      String api, Map<String, String> data) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(data);
    var _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "x-digital-api-key": "1234",
    };

    var response = await client.post(url, body: _payload, headers: _headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else if (response.statusCode == 401) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Get.offAllNamed(MRouter.userLogin);
    } else {
      Fluttertoast.showToast(
        msg: "Server Error ...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    }
  }

  // method for refresh token api call
  // Future<bool> refreshToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? refreshToken = prefs!.getString(SPKeys.REFRESH_TOKEN);
  //   var response = await ApiCalls().postForRefreshToken(Apis.refreshTokenApi,
  //       {"refreshToken": refreshToken!}).catchError((err) {});
  //   if (response == null) return false;
  //   var jsonData = jsonDecode(response.body); // map for response
  //   var data  = jsonData['data'];   // map for data
  // //  print("refresh status access token ${data['accessToken'].toString()}");
  //   // Saving tokens again after it expired.
  //   prefs.remove(SPKeys.ACCESS_TOKEN).then((value) => prefs!.setString(SPKeys.ACCESS_TOKEN, data['accessToken'].toString()));
  //   return true;
  //
  // }
}

class CommonResponseModel {
  CommonResponseModel({
    required this.status,
    required this.message,
  });

  String status;
  String message;

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) =>
      CommonResponseModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
      };
}
