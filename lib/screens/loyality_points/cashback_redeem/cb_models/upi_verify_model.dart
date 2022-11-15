// To parse this JSON data, do
//
//     final upiVerifyModel = upiVerifyModelFromJson(jsonString);

import 'dart:convert';

UpiVerifyModel upiVerifyModelFromJson(String str) => UpiVerifyModel.fromJson(json.decode(str));

String upiVerifyModelToJson(UpiVerifyModel data) => json.encode(data.toJson());

class UpiVerifyModel {
  UpiVerifyModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory UpiVerifyModel.fromJson(Map<String, dynamic> json) => UpiVerifyModel(
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
    this.verified,
  });

  bool? verified;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    verified: json["verified"] == null ? null : json["verified"],
  );

  Map<String, dynamic> toJson() => {
    "verified": verified == null ? null : verified,
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
