

import 'dart:convert';

BankListModel bankListModelFromJson(String str) => BankListModel.fromJson(json.decode(str));

String bankListModelToJson(BankListModel data) => json.encode(data.toJson());

class BankListModel {
  BankListModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory BankListModel.fromJson(Map<String, dynamic> json) => BankListModel(
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
    this.banks,
  });

  List<Bank>? banks;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    banks: json["banks"] == null ? null : List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "banks": banks == null ? null : List<dynamic>.from(banks!.map((x) => x.toJson())),
  };
}

class Bank {
  Bank({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
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
