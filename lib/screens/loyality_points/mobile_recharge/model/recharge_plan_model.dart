// To parse this JSON data, do
//
//     final planesModel = planesModelFromJson(jsonString);

import 'dart:convert';

PlanesModel planesModelFromJson(String str) => PlanesModel.fromJson(json.decode(str));

String planesModelToJson(PlanesModel data) => json.encode(data.toJson());

class PlanesModel {
  PlanesModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory PlanesModel.fromJson(Map<String, dynamic> json) => PlanesModel(
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
    this.plans,
  });

  List<Plan>? plans;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    plans: json["plans"] == null ? null : List<Plan>.from(json["plans"].map((x) => Plan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "plans": plans == null ? null : List<dynamic>.from(plans!.map((x) => x.toJson())),
  };
}

class Plan {
  Plan({
    this.type,
    this.amount,
    this.description,
    this.validity,
  });

  String? type;
  int? amount;
  String? description;
  String? validity;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    type: json["type"] == null ? null : json["type"],
    amount: json["amount"] == null ? null : json["amount"],
    description: json["description"] == null ? null : json["description"],
    validity: json["validity"] == null ? null : json["validity"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "amount": amount == null ? null : amount,
    "description": description == null ? null : description,
    "validity": validity == null ? null : validity,
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
