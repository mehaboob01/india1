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

  @override
  void initState() {
    super.initState();
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
                                () {
                                  return TextFormField(
                                    controller: mapManager.controller.value,
                                    cursorColor: Colors.white,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      mapManager.getSuggestion(value);
                                    },
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.white),
                                      focusColor: Colors.white,
                                      suffixIcon: IconButton(
                                        onPressed: () async {
                                          mapManager.controller.value.clear();
                                        },
                                        icon: Icon(Icons.clear),
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
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
                      mapManager.controller.value.text = "Search Location";
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
                child: Obx(
                  () => Visibility(
                    visible: mapManager.areSuggestionsVisible.value,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: mapManager
                          .itemCount(mapManager.placeList.value.length),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            mapManager.getLatLng(
                                mapManager.placeList[index]["place_id"]);
                            mapManager.controller.value.text =
                                mapManager.placeList[index]["description"];
                            mapManager.placeList.value.clear();
                            mapManager.areSuggestionsVisible.value = false;
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: ListTile(
                              title: Text(mapManager.placeList.value[index]
                                  ["description"]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              child: DraggableScrollableSheet(
                controller: mapManager.scrollableController.value,
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
                                      return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: AtmDetailsCard(
                                            scrollCtrl: scrollController,
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
  AtmDetailsCard(
      {key,
      required this.address,
      this.status,
      this.distance,
      required this.atmName,
      required this.index,
      required this.scrollCtrl})
      : super(key: key);
  int? distance;
  String address;
  String? status;
  String atmName;
  int index;
  ScrollController scrollCtrl;

  MapManager mapManager = Get.put(MapManager());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        mapManager.removeHighlights();
        mapManager.mapCoordinateList[index].isHighlighted = false;
        mapManager.mapController!.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
              mapManager.mapCoordinateList[index].geoLocation!.lat!.toDouble(),
              mapManager.mapCoordinateList[index].geoLocation!.lon!.toDouble(),
            ),
            zoom: 14,
          )),
        );
        mapManager.bringSelectedTileToFirst(index);
        mapManager.scrollableController.value.animateTo(0.4,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        scrollCtrl.animateTo(0,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      },
      child: Card(
        color: mapManager.mapCoordinateList[index].isHighlighted != null
            ? (mapManager.mapCoordinateList[index].isHighlighted == true
                ? Colors.white
                : Colors.white)
            : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Container(
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
                              fontWeight: mapManager.mapCoordinateList[index]
                                          .isHighlighted !=
                                      null
                                  ? (mapManager.mapCoordinateList[index]
                                              .isHighlighted ==
                                          true
                                      ? FontWeight.w700
                                      : FontWeight.w500)
                                  : null,
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
                                  color: mapManager.mapCoordinateList[index]
                                              .isHighlighted !=
                                          null
                                      ? (mapManager.mapCoordinateList[index]
                                                  .isHighlighted ==
                                              true
                                          ? Colors.green
                                          : AppColors.primary)
                                      : AppColors.primary,
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
                          // border: Border.all(color: Color(0xFFF2642C)),
                          border: Border.all(
                            color: mapManager.mapCoordinateList[index]
                                        .isHighlighted !=
                                    null
                                ? (mapManager.mapCoordinateList[index]
                                            .isHighlighted ==
                                        true
                                    ? Colors.green
                                    : Color(0xFFF2642C))
                                : Color(0xFFF2642C),
                          ),
                          borderRadius: BorderRadius.circular(6)),
                      width: Get.width * 0.25,
                      child: GestureDetector(
                        onTap: () {
                          mapManager.openDirections(
                            mapManager
                                .mapCoordinateList[index].geoLocation!.lat!
                                .toDouble(),
                            mapManager
                                .mapCoordinateList[index].geoLocation!.lon!
                                .toDouble(),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.directions,
                              color: mapManager.mapCoordinateList[index]
                                          .isHighlighted !=
                                      null
                                  ? (mapManager.mapCoordinateList[index]
                                              .isHighlighted ==
                                          true
                                      ? Colors.green
                                      : Color(0xFFF2642C))
                                  : Color(0xFFF2642C),
                            ),
                            SizedBox(
                              width: Get.width * 0.008,
                            ),
                            Expanded(
                              child: Text(
                                "Directions",
                                style: TextStyle(
                                  color: mapManager.mapCoordinateList[index]
                                              .isHighlighted !=
                                          null
                                      ? (mapManager.mapCoordinateList[index]
                                                  .isHighlighted ==
                                              true
                                          ? Colors.green
                                          : Color(0xFFF2642C))
                                      : Color(0xFFF2642C),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            )),
      ),
    );
  }
}
