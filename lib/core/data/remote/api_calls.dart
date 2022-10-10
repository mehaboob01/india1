





import 'package:http/http.dart' as http;

class ApiCalls {

  static Future<http.Response> post(String url, {dynamic body, dynamic headers}) {
    return http.post(
      Uri.parse('https://reqres.in/api/users'),
      headers: headers,
      body: body,

    );


    // static Future<Response> post(String url, {dynamic body, dynamic headers}) async {
    //   try {
    //     print('hitting url => ' + url);
    //     print('with parameter => ' + body.toString());
    //     print('with headers => ' + headers.toString());
    //     Response response;
    //     Dio dio = new Dio();
    //     response = await dio.post(url, data: body, options: Options(headers: headers));
    //     print('response => ' + response.data.toString());
    //     return response;
    //   } catch (e) {
    //     print(e);
    //
    //     return Response(
    //         data: {'status': "false", "message":"somwthing went wrong"}, requestOptions: e as RequestOptions);
    //   }
    // }
    //
    // static Future<Response> get(String url, {dynamic headers}) async {
    //   try {
    //     print('hitting url => ' + url);
    //     print('with headers => ' + headers.toString());
    //     Response response;
    //     Dio dio = new Dio();
    //     response = await dio.get(url, options: Options(headers: headers));
    //     print('response => ' + response.data.toString());
    //     return response;
    //   } catch (e) {
    //     print(e);
    //     if (e.toString() != null) {
    //       print(e.toString());
    //       // return (e.toString());
    //     }
    //     return Response(data: {
    //       'status': "false",
    //       "message": " AppMessages.somethingWentWrong",
    //     }, requestOptions: null as RequestOptions);
    //   }
    // }
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
