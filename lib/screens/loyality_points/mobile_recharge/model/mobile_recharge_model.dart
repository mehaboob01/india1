// To parse this JSON data, do
//
//     final mobileRechargeModel = mobileRechargeModelFromJson(jsonString);

import 'dart:convert';

MobileRechargeModel mobileRechargeModelFromJson(String str) => MobileRechargeModel.fromJson(json.decode(str));

String mobileRechargeModelToJson(MobileRechargeModel data) => json.encode(data.toJson());

class MobileRechargeModel {
  MobileRechargeModel({
    this.data,
    this.status,
  });

  dynamic data;
  Status? status;

  factory MobileRechargeModel.fromJson(Map<String, dynamic> json) => MobileRechargeModel(
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
