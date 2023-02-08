import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../constant/routes.dart';
import 'map_manager.dart';

class Maps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: _body(),
        ),
      );
    });
  }

  final MapManager mapManager = Get.put(MapManager());

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

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
                                          mapManager.areSuggestionsVisible
                                              .value = false;
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
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        mapManager.areSuggestionsVisible.value = false;
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
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: ListTile(
                              title: text(
                                mapManager.placeList.value[index]
                                    ["description"],
                                maxLines: 4,
                              ),
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
                initialChildSize:
                    mapManager.mapCoordinateList.length >= 3 ? 0.4 : 0.1,
                maxChildSize: 0.75,
                minChildSize:
                    mapManager.mapCoordinateList.length >= 3 ? 0.4 : 0.1,
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
  final int? distance;
  final String address;
  final String? status;
  final String atmName;
  final int index;
  final ScrollController scrollCtrl;

  final MapManager mapManager = Get.put(MapManager());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        mapManager.scrollableController.value.animateTo(0.4,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        scrollCtrl.animateTo(0,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        await mapManager.mapController!
            .animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
              mapManager.mapCoordinateList[index].geoLocation!.lat!.toDouble(),
              mapManager.mapCoordinateList[index].geoLocation!.lon!.toDouble(),
            ),
            zoom: 14,
          )),
        )
            .then((value) {
          mapManager.removeHighlights();
          mapManager.bringSelectedTileToFirst(index);
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
              border: mapManager.mapCoordinateList[index].isHighlighted != null
                  ? (mapManager.mapCoordinateList[index].isHighlighted == true
                      ? Border.all(color: AppColors.primary, width: 2)
                      : null)
                  : null,
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(
                          atmName.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF000000),
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: Get.height * 0.005,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          height: Get.height * 0.05,
                          decoration: BoxDecoration(
                              // border: Border.all(color: Color(0xFFF2642C)),
                              border: Border.all(
                                color: Color(0xFFF2642C),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.directions,
                                  color: Color(0xFFF2642C),
                                ),
                                Expanded(
                                  child: text(
                                    "Directions",
                                    textOverflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        // color: mapManager.mapCoordinateList[index]
                                        //             .isHighlighted !=
                                        //         null
                                        //     ? (mapManager.mapCoordinateList[index]
                                        //                 .isHighlighted ==
                                        //             true
                                        //         ? Colors.green
                                        //         : Color(0xFFF2642C))
                                        //     : Color(0xFFF2642C),
                                        color: Color(0xFFF2642C)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            text(
                              (int.parse(distance.toString()) / 1000)
                                      .toStringAsFixed(1) +
                                  " Kms",
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              style: TextStyle(
                                overflow: TextOverflow.visible,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                                fontSize: Dimens.font_16sp,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
