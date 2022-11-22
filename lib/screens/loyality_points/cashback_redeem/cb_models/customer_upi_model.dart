// To parse this JSON data, do
//
//     final fetchCustomerUpiModel = fetchCustomerUpiModelFromJson(jsonString);

import 'dart:convert';

FetchCustomerUpiModel fetchCustomerUpiModelFromJson(String str) => FetchCustomerUpiModel.fromJson(json.decode(str));

String fetchCustomerUpiModelToJson(FetchCustomerUpiModel data) => json.encode(data.toJson());

class FetchCustomerUpiModel {
  FetchCustomerUpiModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory FetchCustomerUpiModel.fromJson(Map<String, dynamic> json) => FetchCustomerUpiModel(
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
    this.upiIds,
  });

  List<UpiId>? upiIds;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    upiIds: json["upiIds"] == null ? null : List<UpiId>.from(json["upiIds"].map((x) => UpiId.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "upiIds": upiIds == null ? null : List<dynamic>.from(upiIds!.map((x) => x.toJson())),
  };
}

class UpiId {
  UpiId({
    this.id,
    this.upiId,
  });

  String? id;
  String? upiId;

  factory UpiId.fromJson(Map<String, dynamic> json) => UpiId(
    id: json["id"] == null ? null : json["id"],
    upiId: json["upiId"] == null ? null : json["upiId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "upiId": upiId == null ? null : upiId,
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
