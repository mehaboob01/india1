// To parse this JSON data, do
//
//     final rcOperatorModel = rcOperatorModelFromJson(jsonString);

import 'dart:convert';

RcOperatorModel rcOperatorModelFromJson(String str) => RcOperatorModel.fromJson(json.decode(str));

String rcOperatorModelToJson(RcOperatorModel data) => json.encode(data.toJson());

class RcOperatorModel {
  RcOperatorModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory RcOperatorModel.fromJson(Map<String, dynamic> json) => RcOperatorModel(
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
    this.operators,
  });

  List<Operator>? operators;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    operators: json["operators"] == null ? null : List<Operator>.from(json["operators"].map((x) => Operator.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "operators": operators == null ? null : List<dynamic>.from(operators!.map((x) => x.toJson())),
  };
}

class Operator {
  Operator({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Operator.fromJson(Map<String, dynamic> json) => Operator(
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
