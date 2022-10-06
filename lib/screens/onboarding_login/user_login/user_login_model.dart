// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "status": status == null ? null : status!.toJson(),
  };
}

class Data {
  Data({
    this.token,
    this.retryInSeconds,
  });

  String? token;
  int? retryInSeconds;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"] == null ? null : json["token"],
    retryInSeconds: json["retryInSeconds"] == null ? null : json["retryInSeconds"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "retryInSeconds": retryInSeconds == null ? null : retryInSeconds,
  };
}

class Status {
  Status({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}
