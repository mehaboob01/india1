// ignore_for_file: public_member_api_docs, sort_constructors_first

// old static model
import 'dart:convert';
class MapModel {
  String? name;
  double? distance;
  String? address;
  String? status;
  MapModel({
    this.name,
    required this.distance,
    required this.address,
    required this.status,
  });
}



// To parse this JSON data, do
//
//     final mapCordinatesModel = mapCordinatesModelFromJson(jsonString);

// map cordinated model

MapCordinatesModel mapCordinatesModelFromJson(String str) => MapCordinatesModel.fromJson(json.decode(str));

String mapCordinatesModelToJson(MapCordinatesModel data) => json.encode(data.toJson());

class MapCordinatesModel {
  MapCordinatesModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory MapCordinatesModel.fromJson(Map<String, dynamic> json) => MapCordinatesModel(
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
    this.locations,
  });

  List<Location>? locations;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    locations: json["locations"] == null ? null : List<Location>.from(json["locations"].map((x) => Location.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "locations": locations == null ? null : List<dynamic>.from(locations!.map((x) => x.toJson())),
  };
}

class Location {
  Location({
    this.name,
    this.address,
    this.rewardsMultiplier,
    this.geoLocation,
  });

  String? name;
  String? address;
  int? rewardsMultiplier;
  GeoLocation? geoLocation;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    rewardsMultiplier: json["rewardsMultiplier"] == null ? null : json["rewardsMultiplier"],
    geoLocation: json["geoLocation"] == null ? null : GeoLocation.fromJson(json["geoLocation"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "address": address == null ? null : address,
    "rewardsMultiplier": rewardsMultiplier == null ? null : rewardsMultiplier,
    "geoLocation": geoLocation == null ? null : geoLocation!.toJson(),
  };
}

class GeoLocation {
  GeoLocation({
    this.lat,
    this.lon,
  });

  double? lat;
  double? lon;

  factory GeoLocation.fromJson(Map<String, dynamic> json) => GeoLocation(
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lon: json["lon"] == null ? null : json["lon"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat == null ? null : lat,
    "lon": lon == null ? null : lon,
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

