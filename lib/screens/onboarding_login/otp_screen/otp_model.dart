// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  VerifyOtpModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
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
    this.accessToken,
    this.refreshToken,
    this.loyaltyPointsGained,
    this.customerId,
  });

  String? accessToken;
  String? refreshToken;
  int? loyaltyPointsGained;
  String? customerId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["accessToken"] == null ? null : json["accessToken"],
    refreshToken: json["refreshToken"] == null ? null : json["refreshToken"],
    loyaltyPointsGained: json["loyaltyPointsGained"] == null ? null : json["loyaltyPointsGained"],
    customerId: json["customerId"] == null ? null : json["customerId"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken == null ? null : accessToken,
    "refreshToken": refreshToken == null ? null : refreshToken,
    "loyaltyPointsGained": loyaltyPointsGained == null ? null : loyaltyPointsGained,
    "customerId": customerId == null ? null : customerId,
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
