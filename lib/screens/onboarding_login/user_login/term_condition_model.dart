

import 'dart:convert';

TermConditionMpdel termConditionMpdelFromJson(String str) => TermConditionMpdel.fromJson(json.decode(str));

String termConditionMpdelToJson(TermConditionMpdel data) => json.encode(data.toJson());

class TermConditionMpdel {
  TermConditionMpdel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory TermConditionMpdel.fromJson(Map<String, dynamic> json) => TermConditionMpdel(
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
    this.termsAndConditions,
    this.privacyPolicy,
  });

  String? termsAndConditions;
  String? privacyPolicy;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    termsAndConditions: json["termsAndConditions"] == null ? null : json["termsAndConditions"],
    privacyPolicy: json["privacyPolicy"] == null ? null : json["privacyPolicy"],
  );

  Map<String, dynamic> toJson() => {
    "termsAndConditions": termsAndConditions == null ? null : termsAndConditions,
    "privacyPolicy": privacyPolicy == null ? null : privacyPolicy,
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
