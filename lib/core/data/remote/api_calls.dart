





import 'package:http/http.dart' as http;

import 'api_constant.dart';

// class ApiCalls {
//
//
//   var client  = http.Client();
//
//
//
//
//   //GET
//   Future<dynamic> get(String api) async {
//     var url = Uri.parse(baseUrl + api);
//     var _headers = {
//       'Content-type': 'application/json',
//       'Accept': 'application/json',
//       "x-digital-api-key": "1234",
//       "Authorization": "Bearer "+accessToken.toString()
//     };
//
//     var response = await client.get(url, headers: _headers);
//     if (response.statusCode == 200) {
//       return response.body;
//     } else {
//       //throw exception and catch it in UI
//     }
//   }
//
//   Future<dynamic> post(String api) async {}
//
//   Future<dynamic> put(String api) async {}
//
//   Future<dynamic> delete(String api) async {}
//
//
//
//   }

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
