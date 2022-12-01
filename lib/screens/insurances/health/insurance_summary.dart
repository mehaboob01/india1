import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/insurances/controller/insurance_controller.dart';
import 'package:india_one/screens/onboarding_login/user_login/tnc_io.dart';
import 'package:india_one/widgets/circular_progressbar.dart';

import '../insurance_common.dart';

class InsuranceSummary extends StatefulWidget {
  InsuranceSummary({key});

  @override
  State<InsuranceSummary> createState() => _InsuranceSummaryState();
}

class _InsuranceSummaryState extends State<InsuranceSummary> {
  bool? termConditionChecked = false;
  bool? alertTextShow = false;
  InsuranceController insuranceController = Get.find();

  @override
  void initState() {
    super.initState();
    insuranceController.fetchInsuranceSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() {
        if (insuranceController.insuranceSummaryLoading.value) {
          return CircularProgressbar();
        } else {
          return SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Get.height * 0.47,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              scale: 1,
                              image: AssetImage(AppImages.homebg),
                              fit: BoxFit.fill,
                            ),
                          ),
                          height: Get.height * 0.28,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Spacer(),
                                      ImageIcon(
                                        AssetImage(AppImages.rupees_icon),
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "${insuranceController.insuranceSummaryModel.value.totalAmount}",
                                        style: TextStyle(
                                            fontSize: 70, color: Colors.white),
                                      ),
                                      Spacer(),
                                    ],
                                  )),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xFFD9D9D9).withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(8)),
                                    height: Get.height * 0.04,
                                    width: Get.width * 0.3,
                                    child: Center(
                                        child: Text(
                                      "Total Amount",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFFFFFFF),
                                          fontSize: 16),
                                    )),
                                  ))
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              // boxShadow: <BoxShadow>[
                              //   BoxShadow(
                              //       color: Colors.white.,
                              //       blurRadius: 15.0,
                              //       blurStyle: BlurStyle.normal,
                              //       offset: Offset(0.0, 0.3)),
                              // ],
                              boxShadow: kElevationToShadow[2],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8)),
                              color: Colors.white,
                            ),
                            height: Get.height * 0.22,
                            width: double.maxFinite,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 1),
                                    child: Text(
                                      "Price Details",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Container(
                                    height: Get.height * 0.125,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF7F7F7),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Premium amount",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                "₹ ${insuranceController.insuranceSummaryModel.value.premiumAmount}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "GST",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                "₹ ${insuranceController.insuranceSummaryModel.value.gstAmount}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            thickness: 1.5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Total amount",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                "₹ ${insuranceController.insuranceSummaryModel.value.totalAmount}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "View Summary",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        expansionTile("Plan Details"),
                        expansionTile("Insured Member Details"),
                        expansionTile("Insured Member Address"),
                        expansionTile("Nominee Details"),
                        Row(
                          children: [
                            Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                // Rounded Checkbox
                                activeColor: AppColors.facebookBlue,
                                //only check box
                                value: termConditionChecked,
                                //unchecked
                                onChanged: (bool? value) {
                                  //value returned when checkbox is clicked
                                  setState(() {
                                    termConditionChecked = value;
                                    alertTextShow = false;
                                  });
                                }),
                            SizedBox(
                              width: 4,
                            ),
                            SingleChildScrollView(
                              child: Row(
                                children: [
                                  Text(
                                    "i_accept".tr,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontFamily: 'Graphik',
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black,
                                      fontSize: Dimens.font_16sp,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Tnc_IO()),
                                      );
                                    },
                                    child: Text(
                                      "term_condition".tr,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontFamily: 'Graphik',
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.facebookBlue,
                                        fontSize: Dimens.font_16sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Visibility(
                              visible: alertTextShow == true ? true : false,
                              child: Icon(
                                CupertinoIcons.exclamationmark_circle_fill,
                                color: AppColors.googleRed,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Visibility(
                              visible: alertTextShow == true ? true : false,
                              child: Expanded(
                                child: Text(
                                  'checkbox_select_error'.tr,
                                  overflow: TextOverflow.visible,
                                  maxLines: 2,
                                  style: TextStyle(
                                    overflow: TextOverflow.visible,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.googleRed,
                                    fontSize: Dimens.font_12sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            /*termConditionChecked!
                                ? {print("Checked")}
                                : setState(() {
                                    alertTextShow = true;
                                  });*/
                            if (termConditionChecked!) {
                              print("Checked");
                            } else {
                              setState(() {
                                alertTextShow = true;
                              });
                              InsuranceCommon().bottomSheet(context,
                                  callBack: () {
                                insuranceController.applyForInsurance();
                              });
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.height * 0.9,
                            height: 48,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      "Proceed to Pay",
                                      style: AppTextThemes.button,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                termConditionChecked!
                                    ? SizedBox(
                                        height: 48,
                                        child: Image.asset(
                                          "assets/images/btn_img.png",
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                            decoration: BoxDecoration(
                              gradient: termConditionChecked!
                                  ? new LinearGradient(
                                      end: Alignment.topRight,
                                      colors: [Colors.orange, Colors.redAccent],
                                    )
                                  : LinearGradient(colors: [
                                      AppColors.btnDisableColor,
                                      AppColors.btnDisableColor
                                    ]),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.8),
                                  offset: Offset(
                                    -6.0,
                                    -6.0,
                                  ),
                                  blurRadius: 16.0,
                                ),
                                BoxShadow(
                                  color: AppColors.darkerGrey.withOpacity(0.4),
                                  offset: Offset(6.0, 6.0),
                                  blurRadius: 16.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        )
                      ],
                    ),
                  ),
                ]),
          );
        }
      })),
    );
  }

  expansionTile(titletext) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Theme(
          data: ThemeData(dividerColor: Colors.transparent),
          child: Container(
            margin: EdgeInsets.only(bottom: 0, top: 0, right: 0, left: 0),
            child: ExpansionTile(
              collapsedIconColor: Colors.grey,
              collapsedTextColor: Colors.grey,
              textColor: Colors.grey,
              iconColor: Colors.grey,
              childrenPadding: EdgeInsets.all(1),
              tilePadding: EdgeInsets.all(0),
              title: Text(
                titletext,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              children: [
                if (titletext == "Plan Details") ...[
                  planDetails(),
                ] else if (titletext == "Insured Member Details") ...[
                  insuredMemberDetails(),
                ] else if (titletext == 'Insured Member Address') ...[
                  insuredMemberAddress(),
                ] else if (titletext == "Nominee Details") ...[
                  nomineeDetails(),
                ] else ...[
                  SizedBox()
                ]
              ],
            ),
          ),
        ),
        Divider(
          thickness: 0.5,
          indent: 5,
          endIndent: 5,
        ),
      ],
    );
  }

  final TextStyle _stats = const TextStyle(
      fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF2D2D2D));

  final TextStyle _statsTitle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF333333));

  planDetails() {
    return Column(
      children: [
        Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: Color(0xFFF6F6F6),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: Get.height * 0.2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      height: Get.height * 0.055,
                      width: Get.width * 0.09,
                      color: Colors.white,
                      child: Image.network(insuranceController
                              .insuranceSummaryModel.value.logoUrl ??
                          ""),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${insuranceController.insuranceSummaryModel.value.name}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color(0xFF2D2D2D),
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: Get.height * 0.004,
                        ),
                        Text(
                          "${insuranceController.insuranceSummaryModel.value.type}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF999999),
                              fontSize: 14),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.025,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "₹ ${insuranceController.insuranceSummaryModel.value.sumInsured}",
                              style: _stats),
                          Text(
                            "Sum Insured",
                            style: _statsTitle,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${insuranceController.insuranceSummaryModel.value.tenureInYears} year",
                            style: _stats,
                          ),
                          Text(
                            "Tenure",
                            style: _statsTitle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              "₹ ${insuranceController.insuranceSummaryModel.value.totalAmount}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: _stats.color)
                              // color: _statusColor(index),
                              ),
                          Text(
                            "Premium",
                            style: _statsTitle,
                          )
                        ],
                      )
                    ])
              ]),
            ),
          ),
        ),
      ],
    );
  }

  insuredMemberDetails() {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFFF6F6F6), borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${insuranceController.insuranceSummaryModel.value.profile?.firstName} ${insuranceController.insuranceSummaryModel.value.profile?.lastName}",
                          style: _stats,
                        ),
                        Text(
                          "${insuranceController.insuranceSummaryModel.value.profile?.maritalStatus}",
                          style: _statsTitle,
                        ),
                      ],
                    )),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${insuranceController.insuranceSummaryModel.value.profile?.dateOfBirth}",
                            style: _stats,
                          ),
                          Text(
                            "${insuranceController.insuranceSummaryModel.value.profile?.gender}",
                            style: _statsTitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "+91 ${insuranceController.insuranceSummaryModel.value.profile?.mobileNumber}",
                            style: _stats,
                          ),
                          Text(
                            "Mobile Number",
                            style: _statsTitle,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "+91 ${insuranceController.insuranceSummaryModel.value.profile?.alternateNumber}",
                            style: _stats,
                          ),
                          Text(
                            "Alternate Number",
                            style: _statsTitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${insuranceController.insuranceSummaryModel.value.profile?.email}",
                            style: _stats,
                          ),
                          Text(
                            "Email ID",
                            style: _statsTitle,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${insuranceController.insuranceSummaryModel.value.profile?.panNumber}",
                            style: _stats,
                          ),
                          Text(
                            "PAN number",
                            style: _statsTitle,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rs. ${insuranceController.insuranceSummaryModel.value.profile?.income}",
                            style: _stats,
                          ),
                          Text(
                            "Monthly Income",
                            style: _statsTitle,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${insuranceController.insuranceSummaryModel.value.profile?.occupation}",
                            style: _stats,
                          ),
                          Text(
                            "Occupation",
                            style: _statsTitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  insuredMemberAddress() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          width: double.maxFinite,
          height: Get.height * 0.15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Color(0xFFF6F6F6)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Residential Address",
                  style: _stats,
                ),
                SizedBox(height: Get.height * 0.015),
                Text(
                  "${insuranceController.insuranceSummaryModel.value.profile?.address?.addressLine1}\n${insuranceController.insuranceSummaryModel.value.profile?.address?.addressLine2}",
                  style: _statsTitle,
                ),
              ],
            ),
          )),
    );
  }

  nomineeDetails() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          width: double.maxFinite,
          height: Get.height * 0.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Color(0xFFF6F6F6)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${insuranceController.insuranceSummaryModel.value.nominee?.name}",
                      style: _stats,
                    ),
                    Text(
                      "${insuranceController.insuranceSummaryModel.value.nominee?.dateOfBirth}",
                      style: _stats,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${insuranceController.insuranceSummaryModel.value.nominee?.relationship}",
                      style: _statsTitle,
                    ),
                    Text(
                      "${insuranceController.insuranceSummaryModel.value.nominee?.gender}",
                      style: _statsTitle,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
    ;
  }
}
