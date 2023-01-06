// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  PaymentModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
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
    this.link,
    this.sessionId,
    this.shortLink,
  });

  String? link;
  String? sessionId;
  String? shortLink;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    link: json["link"] == null ? null : json["link"],
    sessionId: json["sessionId"] == null ? null : json["sessionId"],
    shortLink: json["shortLink"] == null ? null : json["shortLink"],
  );

  Map<String, dynamic> toJson() => {
    "link": link == null ? null : link,
    "sessionId": sessionId == null ? null : sessionId,
    "shortLink": shortLink == null ? null : shortLink,
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
