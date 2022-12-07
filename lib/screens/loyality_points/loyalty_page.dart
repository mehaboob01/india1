import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/widgets/circular_progressbar.dart';
import 'package:india_one/widgets/common_banner.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:india_one/widgets/your_reward_card.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../constant/theme_manager.dart';
import '../../utils/common_methods.dart';
import 'loyality_manager.dart';

class LoyaltyScreen extends StatefulWidget {
  @override
  State<LoyaltyScreen> createState() => _LoyaltyScreenState();
}

class _LoyaltyScreenState extends State<LoyaltyScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    // your api here
    // _loyaltyManager.callLoyaltyDashboardApi();
    _refreshController.loadComplete();
  }

  void _onRefresh() async {
    //  _loyaltyManager.callLoyaltyDashboardApi();
    _refreshController.refreshCompleted();

    // your api here
  }

  LoyaltyManager _loyaltyManager = Get.put(LoyaltyManager());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: Column(
            children: [
              CustomAppBar(
                heading: 'Loyalty program',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    // padding
                    padding: EdgeInsets.all(4.0.wp),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadingContainer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Your rewards',
                                style: AppStyle.shortHeading.copyWith(
                                    color: const Color(0xff2d2d2d),
                                    fontWeight: FontWeight.w600),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(MRouter.generalHistory);
                                },
                                // history text will be there
                                child: Text(
                                  '',
                                  style: AppStyle.shortHeading.copyWith(
                                      fontSize: 11.0.sp,
                                      color: const Color(0xff2364A1),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.0.wp),
                          Obx(
                            () => _loyaltyManager.isLoading.value == true
                                ? Shimmer.fromColors(
                                    baseColor:
                                        AppColors.greySecond.withOpacity(0.5),
                                    highlightColor: AppColors.darkGrey!,
                                    child: ListView.builder(
                                      itemCount: _loyaltyManager
                                          .recentRewardTransactionsList.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          elevation: 1.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: SizedBox(height: 80),
                                        );
                                      },
                                    ),
                                  )
                                : _loyaltyManager.recentRewardTransactionsList
                                            .length ==
                                        0
                                    ? Center(
                                        child: Text(
                                        "No Rewards!",
                                        style: AppStyle.shortHeading.copyWith(
                                            color: const Color(0xff2d2d2d),
                                            fontWeight: FontWeight.w600),
                                      ))
                                    : GridView(
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
                                          _loyaltyManager
                                              .recentRewardTransactionsList
                                              .length,
                                          (index) => YourRewardCard(
                                            rewardState: isActive(_loyaltyManager
                                                .recentRewardTransactionsList[
                                                    index]
                                                .expiryDate!),

                                            // isActive(_loyaltyManager
                                            //         .recentRewardTransactionsList[
                                            //             index]
                                            //         .expiryDate!)
                                            //     ? RewardState.expired
                                            //     ? :RewardState.used,
                                            rewardtype: _loyaltyManager
                                                        .recentRewardTransactionsList[
                                                            index]
                                                        .typeId
                                                        .toString() ==
                                                    "referralBonnus"
                                                ? Rewardtype.referralBonus
                                                : _loyaltyManager
                                                            .recentRewardTransactionsList[
                                                                index]
                                                            .typeId
                                                            .toString() ==
                                                        "cacheTransaction"
                                                    ? Rewardtype.cashTransaction
                                                    : _loyaltyManager
                                                                .recentRewardTransactionsList[
                                                                    index]
                                                                .typeId
                                                                .toString() ==
                                                            "Recharge"
                                                        ? Rewardtype.recharge
                                                        : _loyaltyManager
                                                                    .recentRewardTransactionsList[
                                                                        index]
                                                                    .typeId
                                                                    .toString() ==
                                                                "nonCacheTransaction"
                                                            ? Rewardtype
                                                                .recharge
                                                            : Rewardtype
                                                                .cashTransaction,
                                            date: CommonMethods().getOnlyDate(
                                                date: _loyaltyManager
                                                    .recentRewardTransactionsList[
                                                        index]
                                                    .expiryDate!),
                                            points: _loyaltyManager
                                                .recentRewardTransactionsList[
                                                    index]
                                                .points!
                                                .toInt(),
                                          ),
                                        ),
                                      ),
                          ),
                          const SizedBox(height: 10),
                          CommonBanner(
                            margin: EdgeInsets.zero,
                          ),
                          const SizedBox(height: 10),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // bool isActive(String dateTime) {
  RewardState isActive(String dateTime) {
    DateTime dateNow = DateTime.now();
    DateTime startDateTemp =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(dateTime);
    final difference = dateNow.difference(startDateTemp);

    if (difference.inHours.abs() <= 12 && difference.isNegative) {
      return RewardState.won;
    } else if (difference.isNegative && difference.inHours.abs() > 12) {
      return RewardState.used;
    } else {
      return RewardState.expired;
    }
  }
}
