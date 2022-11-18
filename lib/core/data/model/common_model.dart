// To parse this JSON data, do
//
//     final commonApiResponseModel = commonApiResponseModelFromJson(jsonString);

import 'dart:convert';

CommonApiResponseModel commonApiResponseModelFromJson(String str) => CommonApiResponseModel.fromJson(json.decode(str));

String commonApiResponseModelToJson(CommonApiResponseModel data) => json.encode(data.toJson());

class CommonApiResponseModel {
  CommonApiResponseModel({
    this.data,
    this.status,
  });

  dynamic data;
  Status? status;

  factory CommonApiResponseModel.fromJson(Map<String, dynamic> json) => CommonApiResponseModel(
    data: json["data"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "status": status == null ? null : status!.toJson(),
  };
}

class Status {
  Status({
    this.message,
    this.code,
  });

  String? message;
  int? code;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    message: json["message"] == null ? null : json["message"],
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "code": code == null ? null : code,
  };
}
