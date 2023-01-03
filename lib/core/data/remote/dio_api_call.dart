import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:india_one/screens/onboarding_login/user_login/user_login_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../local/shared_preference_keys.dart';
import 'api_constant.dart';

enum Type { GET, POST, PUT, DELETE }

class DioApiCall {
  Dio dio = Dio();

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
        "x-digital-api-key": "1234"
        //"Authorization": accessToken.toString()
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
          print('response data bro');
          print(response.data);
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
          Flushbar(
            title: "Error!",
            message: "Something went wrong ...",
            duration: Duration(seconds: 2),
          )..show(Get.context!);
          return null;
        }
      }
      return null;
    } catch (exception) {
      print(exception);
      return null;
    }
  }
}
