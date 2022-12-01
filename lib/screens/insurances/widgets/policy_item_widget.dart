import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/screens/insurances/model/insurance_application_model.dart';
import 'package:india_one/screens/loans/model/loan_lenders_model.dart';
import 'package:india_one/screens/loans/provider_details.dart';

import '../../../constant/routes.dart';
import '../../../constant/theme_manager.dart';
import '../health/health_insurance_fill_details.dart';

class PolicyItemWidget extends StatelessWidget {
  final Plans plan;
  final bool isAccidentInsurance;

  const PolicyItemWidget({
    Key? key,
    required this.plan,
    required this.isAccidentInsurance,
  }) : super(key: key);

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
                  child: Image.network(
                    plan.imageUrl ?? "",
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.name ?? "Unknown",
                        style: AppTextThemes.button
                            .apply(color: AppColors.lightBlack),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        plan.type ?? "Unknown",
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
              height: 16,
            ),
            /* Row(
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
            ),*/
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.height * 0.9,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View Plan',
                          style: AppTextThemes.button.apply(
                            // color: AppColors.backGroundgradient1,
                            color: AppColors.greyTextColor,
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
                        // color: AppColors.backGroundgradient1,
                        color: AppColors.greyTextColor,
                      ),
                      // color: termConditionChecked == true
                      //     ? AppColors.btnColor
                      //     : AppColors.btnDisableColor,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Get.toNamed(MRouter.healthInsuranceFillDetails);
                      Get.to(() => HealthInsuranceFillDetails(
                            isAccidentInsurance: isAccidentInsurance,
                          ));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.9,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Buy for ₹${plan.amount}',
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
