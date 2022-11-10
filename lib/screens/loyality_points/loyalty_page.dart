import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/screens/loyality_points/general_history/general_history_ui.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:india_one/widgets/your_reward_card.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../constant/theme_manager.dart';
import 'loyality_manager.dart';

class LoyaltyScreen extends StatelessWidget {
  LoyaltyManager _loyaltyManager = Get.put(LoyaltyManager());
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();

    // // list of your reward Card
    // List<YourRewardCard> yourRewarCardList = const <YourRewardCard>[
    //   YourRewardCard(
    //     rewardState: RewardState.won,
    //     rewardtype: Rewardtype.cashTransaction,
    //     date: '14 Nov 2022',
    //     points: 10,
    //   ),
    //   YourRewardCard(
    //     rewardState: RewardState.expired,
    //     rewardtype: Rewardtype.recharge,
    //     date: '25 Sep 2022',
    //     points: 10,
    //   ),
    //   YourRewardCard(
    //     rewardState: RewardState.used,
    //     rewardtype: Rewardtype.referralBonus,
    //     date: '24 Oct 2022',
    //     points: 50,
    //   ),
    //   YourRewardCard(
    //     rewardState: RewardState.won,
    //     rewardtype: Rewardtype.recharge,
    //     date: '14 Oct 2022',
    //     points: 10,
    //   ),
    //   YourRewardCard(
    //     rewardState: RewardState.used,
    //     rewardtype: Rewardtype.loan,
    //     date: '2 Oct 2022',
    //     points: 10,
    //   ),
    //   YourRewardCard(
    //     rewardState: RewardState.used,
    //     rewardtype: Rewardtype.referralBonus,
    //     date: '20 Oct 2022',
    //     points: 50,
    //   ),
    //   YourRewardCard(
    //     rewardState: RewardState.expired,
    //     rewardtype: Rewardtype.loan,
    //     date: '14 Nov 2022',
    //     points: 10,
    //   ),
    //   YourRewardCard(
    //     rewardState: RewardState.used,
    //     rewardtype: Rewardtype.referralBonus,
    //     date: '14 Nov 2022',
    //     points: 10,
    //   ),
    // ];
//  your reward card list ends here

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              heading: 'Loyalty program',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
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
                              child: Text(
                                'History',
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
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Center(
                                      child: LoadingAnimationWidget.inkDrop(
                                        size: 36,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text('Loading ...',
                                        style: AppStyle.shortHeading.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w400))
                                  ],
                                )
                              : _loyaltyManager.recentRewardTransactionsList
                                          .length ==
                                      0
                                  ? Center(child: Text("No Rewards"))
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
                                          rewardState: date.isBefore(_loyaltyManager
                                                  .recentRewardTransactionsList[
                                                      index]
                                                  .expiryDate!
                                                  .toLocal())
                                              ? RewardState.won
                                              : RewardState.expired,
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
                                                          "nonCacheTransaction"
                                                      ? Rewardtype.recharge
                                                      : Rewardtype
                                                          .cashTransaction,
                                          date: "Expired on 02 Nov 2022",
                                          points: _loyaltyManager
                                              .recentRewardTransactionsList[
                                                  index]
                                              .points!
                                              .toInt(),
                                        ),
                                      ),
                                    ),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
