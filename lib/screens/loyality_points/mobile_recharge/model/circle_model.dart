// To parse this JSON data, do
//
//     final rcCircleModel = rcCircleModelFromJson(jsonString);

import 'dart:convert';

RcCircleModel rcCircleModelFromJson(String str) => RcCircleModel.fromJson(json.decode(str));

String rcCircleModelToJson(RcCircleModel data) => json.encode(data.toJson());

class RcCircleModel {
  RcCircleModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory RcCircleModel.fromJson(Map<String, dynamic> json) => RcCircleModel(
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
    this.circles,
  });

  List<Circle>? circles;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    circles: json["circles"] == null ? null : List<Circle>.from(json["circles"].map((x) => Circle.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "circles": circles == null ? null : List<dynamic>.from(circles!.map((x) => x.toJson())),
  };
}

class Circle {
  Circle({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Circle.fromJson(Map<String, dynamic> json) => Circle(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
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
