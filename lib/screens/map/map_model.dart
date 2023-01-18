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

MapCordinatesModel mapCordinatesModelFromJson(String str) =>
    MapCordinatesModel.fromJson(json.decode(str));

String mapCordinatesModelToJson(MapCordinatesModel data) =>
    json.encode(data.toJson());

class MapCordinatesModel {
  MapCordinatesModel({
    this.data,
    this.status,
  });

  Data? data;
  Status? status;

  factory MapCordinatesModel.fromJson(Map<String, dynamic> json) =>
      MapCordinatesModel(
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

  List<Locations>? locations;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        locations: json["locations"] == null
            ? null
            : List<Locations>.from(
                json["locations"].map((x) => Locations.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "locations": locations == null
            ? null
            : List<dynamic>.from(locations!.map((x) => x.toJson())),
      };
}

class Locations {
  Locations(
      {this.name,
      this.address,
      this.rewardsMultiplier,
      this.geoLocation,
      this.isHighlighted,
      this.distance});

  String? name;
  String? address;
  int? rewardsMultiplier;
  GeoLocation? geoLocation;
  int? distance;
  bool? isHighlighted;

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        rewardsMultiplier: json["rewardsMultiplier"] == null
            ? null
            : json["rewardsMultiplier"],
        geoLocation: json["geoLocation"] == null
            ? null
            : GeoLocation.fromJson(json["geoLocation"]),
        distance: json["distance"] == null ? null : json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "rewardsMultiplier":
            rewardsMultiplier == null ? null : rewardsMultiplier,
        "geoLocation": geoLocation == null ? null : geoLocation!.toJson(),
        "distance": distance == null ? null : distance,
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

LatLongModel latLongModelFromJson(String str) =>
    LatLongModel.fromJson(json.decode(str));

String latLongModelToJson(LatLongModel data) => json.encode(data.toJson());

class LatLongModel {
  LatLongModel({
    this.results,
    this.status,
  });

  List<Result>? results;
  String? status;

  factory LatLongModel.fromJson(Map<String, dynamic> json) => LatLongModel(
        results: json["results"] == null
            ? null
            : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "status": status == null ? null : status,
      };
}

class Result {
  Result({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.plusCode,
    this.types,
  });

  List<AddressComponent>? addressComponents;
  String? formattedAddress;
  Geometry? geometry;
  String? placeId;
  PlusCode? plusCode;
  List<String>? types;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        addressComponents: json["address_components"] == null
            ? null
            : List<AddressComponent>.from(json["address_components"]
                .map((x) => AddressComponent.fromJson(x))),
        formattedAddress: json["formatted_address"] == null
            ? null
            : json["formatted_address"],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        placeId: json["place_id"] == null ? null : json["place_id"],
        plusCode: json["plus_code"] == null
            ? null
            : PlusCode.fromJson(json["plus_code"]),
        types: json["types"] == null
            ? null
            : List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "address_components": addressComponents == null
            ? null
            : List<dynamic>.from(addressComponents!.map((x) => x.toJson())),
        "formatted_address": formattedAddress == null ? null : formattedAddress,
        "geometry": geometry == null ? null : geometry!.toJson(),
        "place_id": placeId == null ? null : placeId,
        "plus_code": plusCode == null ? null : plusCode!.toJson(),
        "types":
            types == null ? null : List<dynamic>.from(types!.map((x) => x)),
      };
}

class AddressComponent {
  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  String? longName;
  String? shortName;
  List<String>? types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"] == null ? null : json["long_name"],
        shortName: json["short_name"] == null ? null : json["short_name"],
        types: json["types"] == null
            ? null
            : List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName == null ? null : longName,
        "short_name": shortName == null ? null : shortName,
        "types":
            types == null ? null : List<dynamic>.from(types!.map((x) => x)),
      };
}

class Geometry {
  Geometry({
    this.location,
    this.locationType,
    this.viewport,
  });

  Location? location;
  String? locationType;
  Viewport? viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        locationType:
            json["location_type"] == null ? null : json["location_type"],
        viewport: json["viewport"] == null
            ? null
            : Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location == null ? null : location!.toJson(),
        "location_type": locationType == null ? null : locationType,
        "viewport": viewport == null ? null : viewport!.toJson(),
      };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  Location? northeast;
  Location? southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: json["northeast"] == null
            ? null
            : Location.fromJson(json["northeast"]),
        southwest: json["southwest"] == null
            ? null
            : Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast == null ? null : northeast!.toJson(),
        "southwest": southwest == null ? null : southwest!.toJson(),
      };
}

class PlusCode {
  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String? compoundCode;
  String? globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode:
            json["compound_code"] == null ? null : json["compound_code"],
        globalCode: json["global_code"] == null ? null : json["global_code"],
      );

  Map<String, dynamic> toJson() => {
        "compound_code": compoundCode == null ? null : compoundCode,
        "global_code": globalCode == null ? null : globalCode,
      };
}