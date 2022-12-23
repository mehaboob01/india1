// To parse this JSON data, do
//
//     final banerAdsMOdel = banerAdsMOdelFromJson(jsonString);

import 'dart:convert';

BanerAdsMOdel banerAdsMOdelFromJson(String str) => BanerAdsMOdel.fromJson(json.decode(str));

String banerAdsMOdelToJson(BanerAdsMOdel data) => json.encode(data.toJson());

class BanerAdsMOdel {
  BanerAdsMOdel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory BanerAdsMOdel.fromJson(Map<String, dynamic> json) => BanerAdsMOdel(
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
    this.ads,
  });

  List<Ad>? ads;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    ads: json["ads"] == null ? null : List<Ad>.from(json["ads"].map((x) => Ad.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ads": ads == null ? null : List<dynamic>.from(ads!.map((x) => x.toJson())),
  };
}

class Ad {
  Ad({
    this.id,
    this.route,
    this.redirectUrl,
    this.title,
    this.subTitle,
    this.imageUrl,
    this.adPlacement,
  });

  String? id;
  String? route;
  String? redirectUrl;
  String? title;
  String? subTitle;
  String? imageUrl;
  String? adPlacement;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    id: json["id"] == null ? null : json["id"],
    route: json["route"] == null ? null : json["route"],
    redirectUrl: json["redirectUrl"] == null ? null : json["redirectUrl"],
    title: json["title"] == null ? null : json["title"],
    subTitle: json["subTitle"] == null ? null : json["subTitle"],
    imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
    adPlacement: json["adPlacement"] == null ? null : json["adPlacement"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "route": route == null ? null : route,
    "redirectUrl": redirectUrl == null ? null : redirectUrl,
    "title": title == null ? null : title,
    "subTitle": subTitle == null ? null : subTitle,
    "imageUrl": imageUrl == null ? null : imageUrl,
    "adPlacement": adPlacement == null ? null : adPlacement,
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
