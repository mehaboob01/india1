// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapModel {
  String? name;
  double? distance;
  String? address;
  String? status;
  LatLng? latLng;
  MapModel({
    this.name,
    required this.distance,
    required this.address,
    required this.status,
    required this.latLng,
  });
}
