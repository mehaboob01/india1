import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/screens/loans/model/loan_lenders_model.dart';
import 'package:india_one/screens/loans/provider_details.dart';

import '../../../constant/theme_manager.dart';

class PolicyItemWidget extends StatelessWidget {
  const PolicyItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Aditya Birla Insurance",
                        style: AppTextThemes.button
                            .apply(color: AppColors.lightBlack),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Health Insurance",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                          fontSize: Dimens.font_14sp,
                          fontFamily: "Graphik",
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyColors,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "10%",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                            fontSize: Dimens.font_14sp,
                            fontFamily: "Graphik",
                          ),
                        ),
                        Text(
                          " Claim settled",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.iconColorDark,
                            fontSize: Dimens.font_14sp,
                            fontFamily: "Graphik",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyColors,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "2 hrs",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                            fontSize: Dimens.font_14sp,
                            fontFamily: "Graphik",
                          ),
                        ),
                        Text(
                          " Claim approval",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.iconColorDark,
                            fontSize: Dimens.font_14sp,
                            fontFamily: "Graphik",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Get.to(
                      //   ProviderDetail(
                      //       title: "", lenders: Lenders(), personalLoan: false),
                      // );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.9,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'View Plan',
                            style: AppTextThemes.button.apply(
                              color: AppColors.backGroundgradient1,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        // gradient: new LinearGradient(
                        //   end: Alignment.topRight,
                        //   colors: [Colors.orange, Colors.redAccent],
                        // ),
                        border: Border.all(
                          color: AppColors.backGroundgradient1,
                        ),
                        // color: termConditionChecked == true
                        //     ? AppColors.btnColor
                        //     : AppColors.btnDisableColor,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.9,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Buy for ₹1234',
                            style: AppTextThemes.button,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                          end: Alignment.topRight,
                          colors: [Colors.orange, Colors.redAccent],
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
