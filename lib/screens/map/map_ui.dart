import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/map/map_manager.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';

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

  late BitmapDescriptor customIcon;

  @override
  void initState() {
    // TODO: implement initState
    getCustomIcon();
    //get current location if wanted
    super.initState();
  }

  getCustomIcon() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(12, 12)),
      AppImages.markerIcon,
    ).then((d) {
      customIcon = d;
    });
  }

  MapManager mapManager = Get.put(MapManager());

  _body() {
    GoogleMapController _mapController;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SafeArea(
          child: CustomAppBar(
            heading: "Maps",
            customActionIconsList: [
              // CustomActionIcons(
              //   image: AppImages.bottomNavHome,
              //   isSvg: false, onHeaderIconPressed: () {  },
              // )
            ],
          ),
        ),
        Expanded(
          child: Stack(children: [
            Obx(
              () => GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    mapManager.latitude.value,
                    mapManager.longitude.value,
                  ),
                  zoom: 15,
                ),
                onMapCreated: (controller) {
                  _mapController = controller;
                  for (var i = 0; i < mapManager.markersList.length; i++) {
                    mapManager.markersList.forEach((key, value) {
                      mapManager.addMarker(key, value);
                    });
                  }
                },
                markers: mapManager.allMarkers.toSet(),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Row(
                children: [
                  //=------------------------=
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.73,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.backGroundgradient1,
                          AppColors.backGroundgradient2
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 15, 15, 15),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: Get.width * 0.03,
                          ),
                          Text(
                            "Enable your location",
                            style: TextStyle(
                                color: Color(0xFFEEEEEECC),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                          Spacer(),
                          ImageIcon(
                            AssetImage(AppImages.locationIcon),
                            color: Color(0xFFEEEEEE),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Container(
                    height: Get.height * 0.06,
                    width: Get.width * 0.135,
                    decoration: BoxDecoration(
                        // gradient: LinearGradient(
                        //   colors: [
                        //     AppColors.cardScreenBg,
                        //     AppColors.white,
                        //   ],
                        // ),
                        color: Colors.white,
                        border:
                            Border.all(width: 1, color: AppColors.cardScreenBg),
                        borderRadius: BorderRadius.circular(10)),
                    child: ImageIcon(
                      AssetImage(AppImages.searchIcon),
                    ),
                  )
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.4,
              maxChildSize: 0.85,
              minChildSize: 0.4,
              builder: (context, scrollController) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Container(
                      height: Get.height * 0.25,
                      child:

                      Obx(
                        ()=> ListView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.all(0),
                          itemCount: mapManager.mapCoordinateList.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: AtmDetailsCard(
                                index: index,
                                address: mapManager.mapCoordinateList[index].address.toString(),
                                atmName:  mapManager.mapCoordinateList[index].name.toString(),

                              ),
                            );
                          }),
                        ),
                      )),
                );
              },
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
  double? distance;
  String address;
  String? status;
  String atmName;
  int index;

  MapManager mapManager = Get.put(MapManager());
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
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
                  Row(
                    children: [

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,

                        child: Container(
                          height: 26,
                          width: 240,
                          child: Text(
                            address.toString(),
                            overflow: TextOverflow.visible,
                            maxLines: 4,
                            style: TextStyle(
                              overflow: TextOverflow.visible,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                              fontSize: Dimens.font_14sp,
                            ),
                          ),
                        ),
                      ),

                    ]


                  ),
               //   Text(, softWrap: false, overflow: TextOverflow.ellipsis, maxLines: 4,)

                ],
              ),
              Container(
                  height: 38,


                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFF2642C)),
                      borderRadius: BorderRadius.circular(6)),
                  width: 80,
                  child: Row(
                    children: [
                      Icon(
                        Icons.directions,
                        color: Color(0xFFF2642C),
                      ),
                      SizedBox(
                        width: Get.width * 0.008,
                      ),
                      Text(
                        "Routes",
                        style: TextStyle(color: Color(0xFFF2642C)),
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}
