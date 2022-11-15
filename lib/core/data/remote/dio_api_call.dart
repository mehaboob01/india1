import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'api_constant.dart';

enum Type { GET, POST, PUT, DELETE }

class DioApiCall {
  Dio dio = Dio();

  Future commonApiCall({required String endpoint, data, required Type method, Map<String, dynamic>? headers, Map<String, dynamic>? getParam}) async {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "x-digital-api-key": "1234",
      },
    );
    if (headers != null) {
      dio.options.headers.addAll(headers);
    }
    Response? response;
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
        if (response.data['status']['code'] != 2000) {
          Fluttertoast.showToast(msg: "${response.data['status']['message']}", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 16.0);
          return null;
        }
        if (response.data['data'] != null) {
          return response.data['data'];
        }
        return null;
      }
      return null;
    } catch (exception) {
      print(exception);
      return null;
    }
  }
}
