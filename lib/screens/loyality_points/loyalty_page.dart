import 'package:flutter/material.dart';
import 'package:india_one/constant/extensions.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/loyalty_common_header.dart';
import '../../widgets/your_reward_card.dart';



class LoyaltyScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    List<YourRewardCard> yourRewarCardList = const <YourRewardCard>[
      YourRewardCard(
        rewardState: RewardState.won,
        rewardtype: Rewardtype.cashTransaction,
        date: '14 Nov 2022',
        points: 10,
      ),
      YourRewardCard(
        rewardState: RewardState.expired,
        rewardtype: Rewardtype.recharge,
        date: '25 Sep 2022',
        points: 10,
      ),
      YourRewardCard(
        rewardState: RewardState.used,
        rewardtype: Rewardtype.referralBonus,
        date: '24 Oct 2022',
        points: 50,
      ),
      YourRewardCard(
        rewardState: RewardState.used,
        rewardtype: Rewardtype.recharge,
        date: '14 Oct 2022',
        points: 10,
      ),
      YourRewardCard(
        rewardState: RewardState.used,
        rewardtype: Rewardtype.loan,
        date: '2 Oct 2022',
        points: 10,
      ),
      YourRewardCard(
        rewardState: RewardState.used,
        rewardtype: Rewardtype.referralBonus,
        date: '20 Oct 2022',
        points: 50,
      ),
      YourRewardCard(
        rewardState: RewardState.expired,
        rewardtype: Rewardtype.loan,
        date: '14 Nov 2022',
        points: 10,
      ),
      YourRewardCard(
        rewardState: RewardState.used,
        rewardtype: Rewardtype.referralBonus,
        date: '14 Nov 2022',
        points: 10,
      ),
    ];

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
                        const HeadingContainer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your rewards',
                              style: AppStyle.shortHeading.copyWith(
                                  color: const Color(0xff2d2d2d),
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'History',
                              style: AppStyle.shortHeading.copyWith(
                                  fontSize: 11.0.sp,
                                  color: const Color(0xff2364A1),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.0.wp),
                        GridView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 4.0.wp,
                                  mainAxisSpacing: 4.0.wp),
                          children: List.generate(yourRewarCardList.length,
                              (index) => yourRewarCardList[index]),
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
