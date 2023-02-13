import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:india_one/screens/onboarding_login/user_login/user_login_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../local/shared_preference_keys.dart';
import 'api_calls.dart';
import 'api_constant.dart';

enum Type { GET, POST, PUT, DELETE }

class DioApiCall {
  Dio dio = Dio();



  // intercepter
  DioApiCall() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);
      if (!options.path.contains('http')) {
        options.path = baseUrl + options.path;
      }
      options.headers['Authorization'] = 'Bearer $accessToken';
      return handler.next(options);
    }, onError: (DioError error, handler) async {

      if ((error.response?.statusCode == 403 ||
          error.response?.data['message'] == "Invalid JWT")) {


        if (await refreshToken()) {
          return handler.resolve(await _retry(error.requestOptions));
        }
        // return;

      }
      return handler.next(error);
    }));


  }



  Future commonApiCall({
    required String endpoint,
    data,
    required Type method,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? getParam,
    bool? isLogout,
  }) async {



    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs!.getString(SPKeys.ACCESS_TOKEN);
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "x-digital-api-key": "1234",
        "Authorization": "Bearer " + accessToken.toString()
      },
    );
    if (headers != null) {
      dio.options.headers.addAll(headers);
    }
    d.Response? response;

    try {
      if (method == Type.PUT)
        response = await dio.put(
          endpoint,
          data: data,
        );
      if (method == Type.POST)
        response = await dio.post(
          endpoint,
          data: data,
        );
      if (method == Type.GET)
        response = await dio.get(
          endpoint,
        );
      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {


          if (response.data['status']['code'] != 2000) {
            Fluttertoast.showToast(
                msg: "${response.data['status']['message']}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                fontSize: 16.0);
            return null;
          }
          if (response.data['data'] != null) {
            return response.data['data'];
          }
          if (isLogout == true) {
            if (response.data['status']['code'] == 2000) {
              await prefs.clear();
              Get.offAll(() => UserLogin());
            }
          }
        } else {
         
          return null;
        }
      }
      return null;
    } catch (exception) {

      return null;
    }
  }

  Future<d.Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  // method for refresh token api call
  // method for refresh token api call
  Future<bool> refreshToken() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs!.getString(SPKeys.REFRESH_TOKEN);


    var response = await ApiCalls().postForRefreshToken(Apis.refreshTokenApi,
        {"refreshToken": refreshToken!}).catchError((err) {});



    if (response == null) return false;
    var jsonData = jsonDecode(response.body); // map for response
    var data = jsonData['data']; // map for data

    // Saving tokens again after it expired.
    prefs.remove(SPKeys.ACCESS_TOKEN).then((value) => prefs!.setString(SPKeys.ACCESS_TOKEN, data['accessToken'].toString()));
   // prefs.remove(SPKeys.REFRESH_TOKEN).then((value) => prefs!.setString(SPKeys.REFRESH_TOKEN, data['refreshToken'].toString()));
    return true;
  }
}
