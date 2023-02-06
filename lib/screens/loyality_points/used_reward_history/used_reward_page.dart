import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:india_one/screens/loyality_points/used_reward_history/used_reward_controller.dart';
import 'package:india_one/screens/loyality_points/used_reward_history/used_reward_model.dart';
import 'package:india_one/utils/common_methods.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:shimmer/shimmer.dart';

import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../constant/colors_constant.dart';
import '../../../constant/theme_manager.dart';
import '../../../widgets/your_reward_card.dart';

class UsedRewardHistory extends StatelessWidget {
  UsedRewardHistory({super.key});

  final _usedPointsController = Get.put(UsedRewardController());
  final DataTableSource _data = MyData();

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Obx(() {
                return Column(
                  children: [
                    CustomAppBar(heading: 'History'),
                    Expanded(
                      child: _usedPointsController.loadingData.value == true
                          ? Center(child: CircularProgressIndicator())
                          : _usedPointsController.usedpointsList.isEmpty
                              ? Center(
                                  child:
                                      text('You have not Redeemed Any Points'),
                                )
                              : SingleChildScrollView(
                                  child: Container(
                                    height: Get.height,
                                    width: Get.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [

                                        Card(
                                          elevation: 8,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0, right: 8),
                                            child: Container(
                                              height: 60,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: AppColors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 24,
                                                    ),
                                                    SizedBox(
                                                      height: 120,
                                                      width: 120,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: const [
                                                          SizedBox(height: 24),
                                                          Icon(
                                                            Icons.update,
                                                            color: AppColors.redIconGradient1,
                                                            size: 26,
                                                          ),
                                                          SizedBox(
                                                            width: 4,
                                                          ),
                                                          Text('DATE',
                                                              style: TextStyle(
                                                                  fontSize: Dimens
                                                                      .font_12sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColors
                                                                      .primary)),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: SizedBox(
                                                        height: 120,
                                                        width: 120,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: const [
                                                              SizedBox(
                                                                  height: 24),
                                                              Icon(
                                                                CupertinoIcons
                                                                    .checkmark_circle,
                                                                color: AppColors.redIconGradient1,
                                                                size: 26,
                                                              ),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text(
                                                                'STATUS',
                                                                style: TextStyle(
                                                                    fontSize: Dimens
                                                                        .font_12sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppColors
                                                                        .primary),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: SizedBox(
                                                        height: 120,
                                                        width: 120,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: const [
                                                              SizedBox(
                                                                  height: 24),
                                                              Icon(
                                                                CupertinoIcons
                                                                    .gift_fill,
                                                                color: AppColors.redIconGradient1,
                                                                size: 24,
                                                              ),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text('POINTS',
                                                                  style: TextStyle(
                                                                      fontSize: Dimens
                                                                          .font_12sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: AppColors
                                                                          .primary)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          height: Get.height,
                                          width: Get.width,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0, right: 2),
                                            child: ListView.builder(
                                              itemCount: _usedPointsController
                                                  .usedpointsList.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  height: 64,
                                                  child: Card(
                                                    elevation: 16,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: 40,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                              _usedPointsController
                                                                  .usedpointsList[
                                                                      index]
                                                                  .date
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10),
                                                              style: TextStyle(
                                                                  fontSize: Dimens
                                                                      .font_14sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColors
                                                                      .primary)),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                              _usedPointsController
                                                                  .usedpointsList[
                                                                      index]
                                                                  .typeId
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: Dimens
                                                                      .font_14sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColors
                                                                      .primary)),
                                                        ),
                                                        SizedBox(
                                                          width: 44,
                                                        ),

                                                        Expanded(
                                                          child: Text(
                                                              _usedPointsController
                                                                  .usedpointsList[
                                                                      index]
                                                                  .points
                                                                  .toString()
                                                                  .replaceAll(
                                                                      '-', ''),
                                                              style: TextStyle(
                                                                  fontSize: Dimens
                                                                      .font_16sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColors
                                                                      .greenColor)),
                                                        ),
                                                      ],
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
                    ),
                  ],
                );
              }),
            )),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
      200,
      (index) => {
            "id": index,
            "title": "Item $index",
            "price": Random().nextInt(10000)
          });

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(
        _data[index]['id'].toString(),
        style: TextStyle(
            fontSize: Dimens.font_14sp,
            fontWeight: FontWeight.w600,
            color: AppColors.greenColor),
      )),
      DataCell(Text(_data[index]["title"],
          style: TextStyle(
              fontSize: Dimens.font_14sp,
              fontWeight: FontWeight.w600,
              color: AppColors.greenColor))),
      DataCell(Text(_data[index]["price"].toString(),
          style: TextStyle(
              fontSize: Dimens.font_14sp,
              fontWeight: FontWeight.w600,
              color: AppColors.greenColor))),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
