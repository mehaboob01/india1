





import 'package:http/http.dart' as http;

class ApiCalls {

  static Future<http.Response> post(String url, {dynamic body, dynamic headers}) {
    return http.post(
      Uri.parse('https://reqres.in/api/users'),
      headers: headers,
      body: body,

    );



  }}

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
