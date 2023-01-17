// To parse this JSON data, do
//
//     final refreshTokenModel = refreshTokenModelFromJson(jsonString);

import 'dart:convert';

RefreshTokenModel refreshTokenModelFromJson(String str) => RefreshTokenModel.fromJson(json.decode(str));

String refreshTokenModelToJson(RefreshTokenModel data) => json.encode(data.toJson());

class RefreshTokenModel {
  RefreshTokenModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) => RefreshTokenModel(
    data: json["data"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "status": status,
  };
}

class Data {
  Data({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
  });

  String? accessToken;
  String? refreshToken;
  String? tokenType;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
    tokenType: json["tokenType"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "tokenType": tokenType,
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
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}
