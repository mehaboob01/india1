import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/widgets/circular_progressbar.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:india_one/widgets/your_reward_card.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../constant/theme_manager.dart';
import '../../utils/common_methods.dart';
import 'loyality_manager.dart';

class LoyaltyScreen extends StatelessWidget {
  LoyaltyManager _loyaltyManager = Get.put(LoyaltyManager());
  @override
  Widget build(BuildContext context) {

    // print("DATE");
    // print('this is date ${CommonMethods().getOnlyDate(date: "2022-11-01T20:45:13Z")} ');
    DateTime date = DateTime.now();
    // print("Current date${date}");


    // DateFormat dateFormat = DateFormat("yyyy-MMM-dd");
    // // CommonMethods().getOnlyDate(date: "2022-11-01T20:45:13Z")
    // String stringValue = dateFormat.format(DateTime.now()); //Converting DateTime object to String
   // print('date now : ${CommonMethods().getOnlyDate(date: "2022-11-01T20:45:13Z")}');
    // DateTime dateTime = dateFormat.parse("2022-11-01T20:45:13Z"); //Converting String to DateTime object

    return Scaffold(
      body: Obx(
       ()=>  _loyaltyManager.isLoading.value == true ? CircularProgressbar(): SafeArea(
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

                           _loyaltyManager.recentRewardTransactionsList
                                            .length ==
                                        0
                                    ? Center(child: Text("No Rewards!", style: AppStyle.shortHeading.copyWith(
                            color: const Color(0xff2d2d2d),
                                fontWeight: FontWeight.w600),))
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
                                            rewardState: isExpried(_loyaltyManager.recentRewardTransactionsList[index].expiryDate!)
                                                ? RewardState.expired
                                                : RewardState.won,
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
                                            date: CommonMethods().getOnlyDate(date: _loyaltyManager.recentRewardTransactionsList[index].date!.toString()),
                                            points: _loyaltyManager
                                                .recentRewardTransactionsList[
                                                    index]
                                                .points!
                                                .toInt(),
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
      ),
    );
  }



  bool isExpried(String? dateTime) {
    final dateNow = DateTime.now().day;
    final startDateTemp =
    DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(dateTime!);
    //final difference = dateNow.difference(startDateTemp);
    if (dateNow != startDateTemp.day ) {
      return true;
    } else {
      return false;
    }
  }
}
