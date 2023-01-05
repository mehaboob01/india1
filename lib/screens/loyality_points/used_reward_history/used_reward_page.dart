import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:india_one/screens/loyality_points/used_reward_history/used_reward_controller.dart';
import 'package:india_one/screens/loyality_points/used_reward_history/used_reward_model.dart';
import 'package:india_one/utils/common_methods.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';

import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../constant/theme_manager.dart';
import '../../../widgets/your_reward_card.dart';

class UsedRewardHistory extends StatelessWidget {
  UsedRewardHistory({super.key});

  final _usedPointsController = Get.put(UsedRewardController());

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(body: SafeArea(
          child: Obx(() {
            return Column(
              children: [
                CustomAppBar(heading: 'History'),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: _usedPointsController.loadingData.value == true
                        ? Center(child: CircularProgressIndicator())
                        : _usedPointsController.usedpointsList.isEmpty
                            ? Center(
                                child: Text('You have not Redeemed Any Points'),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 40),
                                    // Container(
                                    //   margin: EdgeInsets.symmetric(
                                    //     vertical: 25,
                                    //   ),
                                    //   height: 50,
                                    //   color: Colors.transparent,
                                    //   child: Row(
                                    //     children: [
                                    //       Expanded(
                                    //         flex: 2,
                                    //         child: Material(
                                    //           type: MaterialType.transparency,
                                    //           elevation: 6,
                                    //           child: Container(
                                    //             decoration: BoxDecoration(
                                    //                 boxShadow: [
                                    //                   BoxShadow(
                                    //                       color: Colors.black
                                    //                           .withOpacity(0.1),
                                    //                       offset: Offset(0, 3),
                                    //                       blurRadius: 1),
                                    //                 ],
                                    //                 color: Colors.white,
                                    //                 borderRadius: BorderRadius.all(
                                    //                     Radius.circular(10))),
                                    //             margin: EdgeInsets.only(right: 10),
                                    //             padding: EdgeInsets.all(10.0),
                                    //             height: 50,
                                    //             child: Row(
                                    //               mainAxisAlignment:
                                    //                   MainAxisAlignment
                                    //                       .spaceBetween,
                                    //               children: [
                                    //                 Text(
                                    //                   'All transactions',
                                    //                   style: AppStyle.shortHeading
                                    //                       .copyWith(
                                    //                           color: const Color(
                                    //                               0xff2d2d2d),
                                    //                           fontWeight:
                                    //                               FontWeight.w600),
                                    //                 ),
                                    //                 InkWell(
                                    //                     onTap: () {},
                                    //                     child: Icon(Icons
                                    //                         .keyboard_arrow_down))
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       Expanded(
                                    //         flex: 1,
                                    //         child: Material(
                                    //           type: MaterialType.transparency,
                                    //           elevation: 5,
                                    //           child: Container(
                                    //             margin: EdgeInsets.only(left: 10),
                                    //             padding: EdgeInsets.all(10.0),
                                    //             decoration: BoxDecoration(
                                    //                 boxShadow: [
                                    //                   BoxShadow(
                                    //                       color: Colors.black
                                    //                           .withOpacity(0.1),
                                    //                       offset: Offset(0, 3),
                                    //                       blurRadius: 1),
                                    //                 ],
                                    //                 color: Colors.white,
                                    //                 borderRadius: BorderRadius.all(
                                    //                     Radius.circular(10))),
                                    //             height: 50,
                                    //             child: Row(
                                    //               mainAxisAlignment:
                                    //                   MainAxisAlignment
                                    //                       .spaceBetween,
                                    //               children: [
                                    //                 Text(
                                    //                   'All time',
                                    //                   style: AppStyle.shortHeading
                                    //                       .copyWith(
                                    //                           color: const Color(
                                    //                               0xff2d2d2d),
                                    //                           fontWeight:
                                    //                               FontWeight.w600),
                                    //                 ),
                                    //                 InkWell(
                                    //                     onTap: () {},
                                    //                     child: Icon(Icons
                                    //                         .keyboard_arrow_down))
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       )
                                    //     ],
                                    //   ),
                                    // ),
                                    Text(
                                      'View used points',
                                      style: AppStyle.shortHeading.copyWith(
                                          color: const Color(0xff2d2d2d),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      child: GridView(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 1,
                                                  crossAxisSpacing: 4.0.wp,
                                                  mainAxisSpacing: 4.0.wp),
                                          children: List.generate(
                                              _usedPointsController
                                                  .usedpointsList
                                                  .length, (index) {
                                            var rewardHistoryCard =
                                                _usedPointsController
                                                    .usedpointsList[index];
                                            return YourRewardCard(
                                                rewardState: RewardState.used,
                                                rewardtype:
                                                    Rewardtype.cashTransaction,
                                                date: CommonMethods()
                                                    .getOnlyDate(
                                                        date:
                                                            _usedPointsController
                                                                .usedpointsList[
                                                                    index]
                                                                .date),
                                                points:
                                                    rewardHistoryCard.points!);
                                          })),
                                    )
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
