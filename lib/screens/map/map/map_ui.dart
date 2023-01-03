import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:india_one/constant/theme_manager.dart';

import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constant/routes.dart';
import '../../../core/data/remote/api_constant.dart';
import 'map_manager.dart';

class Maps extends StatefulWidget {
  Maps({key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _body(),
    );
  }

  MapManager mapManager = Get.put(MapManager());
  var _controller = TextEditingController();

  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_controller.text.isNotEmpty) {
      getSuggestion(_controller.text);
    } else {
      _controller.clear();
      _placeList.clear();
    }
  }

  void getSuggestion(String input) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&components=country:IN&key=${Apis.kPLACES_API_KEY}';

    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  void getLatLng(String placeId) async {
    String baseURL =
        "https://maps.googleapis.com/maps/api/geocode/json?place_id=$placeId&key=${Apis.kPLACES_API_KEY}";
    var response = await http.get(Uri.parse(baseURL));
    var result = json.decode(response.body);
    if (response.statusCode == 200) {
      var lat = result["results"][0]["geometry"]["location"]["lat"];
      var lng = result["results"][0]["geometry"]["location"]["lng"];

      mapManager
        ..mapController!
            .animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(lat, lng), zoom: 14)))
            .then((value) {
          mapManager.getLocations(lat, lng);
        });

      _controller.clear();
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  _body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SafeArea(
          child: CustomAppBar(
            heading: "Maps",
            hasLogo: true,
            customActionIconsList: [
              CustomActionIcons(
                  image: AppImages.bottomNavHomeSvg,
                  onHeaderIconPressed: () async {
                    Get.offNamedUntil(
                        MRouter.homeScreen, (route) => route.isFirst);
                  })
            ],
          ),
        ),
        Expanded(
          child: Stack(children: [
            Obx(
              () => GoogleMap(
                buildingsEnabled: false,
                mapType: MapType.normal,
                zoomGesturesEnabled: false,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                initialCameraPosition: mapManager.cameraPosition.value,
                onMapCreated: (controller) async {
                  mapManager.mapController = controller;
                  mapManager.getCurrentLocation();
                },
                markers: mapManager.allMarkersPlot.toSet(),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Row(
                children: [
                  Container(
                    width: Get.width * 0.73,
                    height: Get.height * 0.06,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.blueColor,
                          AppColors.backGroundgradient2
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: SizedBox(
                                height: Get.height * 0.06,
                                child: Obx(
                                  () => TextFormField(
                                    onTap: () {
                                      _controller.text;
                                    },
                                    cursorColor: Colors.white,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.white),
                                    controller: _controller,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: mapManager.locationText.value,
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusColor: Colors.white,
                                      suffixIcon: IconButton(
                                        onPressed: () async {
                                          mapManager.locationText.value = "";
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.clear),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  GestureDetector(
                    onTap: () async {
                      mapManager.locationText.value = "Search Location";
                      await mapManager.getCurrentLocation();
                    },
                    child: Container(
                      height: Get.height * 0.06,
                      width: Get.width * 0.135,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1, color: AppColors.cardScreenBg),
                          borderRadius: BorderRadius.circular(10)),
                      child: ImageIcon(
                        AssetImage(
                          AppImages.locationIcon,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Visibility(
                  visible: _placeList.length > 0 ? true : false,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          getLatLng(_placeList[index]["place_id"]);
                          mapManager.locationText.value =
                              _placeList[index]["description"];
                          _placeList.clear();
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: ListTile(
                            title: Text(_placeList[index]["description"]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              child: DraggableScrollableSheet(
                initialChildSize: 0.4,
                maxChildSize: 0.85,
                minChildSize: 0.4,
                builder: (context, scrollController) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                    child: Container(
                        height: Get.height * 0.25,
                        child:
                            Obx(() => mapManager.mapCoordinateList.length != 0
                                ? ListView.builder(
                                    controller: scrollController,
                                    padding: EdgeInsets.all(0),
                                    itemCount:
                                        mapManager.mapCoordinateList.length,
                                    shrinkWrap: true,
                                    itemBuilder: ((context, index) {
                                      // if (mapManager.markersList.isEmpty) {}

                                      return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: AtmDetailsCard(
                                            index: index,
                                            address: mapManager
                                                .mapCoordinateList[index]
                                                .address
                                                .toString(),
                                            atmName: mapManager
                                                .mapCoordinateList[index].name
                                                .toString(),
                                            distance: mapManager
                                                .mapCoordinateList[index]
                                                .distance,
                                          ));
                                    }),
                                  )
                                : Container())),
                  );
                },
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class AtmDetailsCard extends StatelessWidget {
  AtmDetailsCard({
    key,
    required this.address,
    this.status,
    this.distance,
    required this.atmName,
    required this.index,
  }) : super(key: key);
  int? distance;
  String address;
  String? status;
  String atmName;
  int index;
  ScrollController? scrollCtrl;

  MapManager mapManager = Get.put(MapManager());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        mapManager.mapController!.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
              mapManager.mapCoordinateList[index].geoLocation!.lat!.toDouble(),
              mapManager.mapCoordinateList[index].geoLocation!.lon!.toDouble(),
            ),
            zoom: 14,
          )),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        atmName.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                            fontSize: 16),
                      ),

                      SizedBox(
                        height: Get.height * 0.005,
                      ),

                      Row(children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            height: Get.height * 0.08,
                            width: Get.width * 0.45,
                            child: Text(
                              (int.parse(distance.toString()) / 1000)
                                      .toString() +
                                  " Kms",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              style: TextStyle(
                                overflow: TextOverflow.visible,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                                fontSize: Dimens.font_16sp,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      //   Text(, softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 4,)
                    ],
                  ),
                ),
                Container(
                    height: Get.height * 0.05,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFF2642C)),
                        borderRadius: BorderRadius.circular(6)),
                    width: Get.width * 0.25,
                    child: GestureDetector(
                      onTap: () {
                        mapManager.openDirections(
                          mapManager.mapCoordinateList[index].geoLocation!.lat!
                              .toDouble(),
                          mapManager.mapCoordinateList[index].geoLocation!.lon!
                              .toDouble(),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.directions,
                            color: Color(0xFFF2642C),
                          ),
                          SizedBox(
                            width: Get.width * 0.008,
                          ),
                          Expanded(
                            child: Text(
                              "Directions",
                              style: TextStyle(color: Color(0xFFF2642C)),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}
