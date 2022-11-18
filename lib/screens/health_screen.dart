import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../constant/theme_manager.dart';

class HealthConsent extends StatefulWidget {
  const HealthConsent({Key? key}) : super(key: key);

  @override
  State<HealthConsent> createState() => _HealthConsentState();
}

class _HealthConsentState extends State<HealthConsent> {
  bool? termConditionChecked = false;
  bool? alertTextShow = false;
  List<Text> _list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Proposed member's health",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Text(
              "Do the proposed member to be insured suffer from below listed issues?",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Container(
              decoration: BoxDecoration(
                  // color:
                  color: Colors.grey.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8)),
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: Text(
                  """
Diabetes, Hypertension, Thyroid Disorder, Nervous 
disorder, fits, mental condition, heart & circulatory disorder, Respiratory disorder, Disorders of stomach including intestine, Kidney stones, Prostrate disorder, Disorder of spine and joints, Tumours or cancer, Ever reported positive for hepatitis B, HIV / AIDS or other sexually transmitted disease or is pregnant at the time of application
data""",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pickBox("Yes"),
                pickBox("No"),
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(
              "Do any of the proposed members to be insured suffer from any  pre-existing diseases?",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.11),
                  borderRadius: BorderRadius.circular(8)),
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: Text(
                  """
Please choose “Yes” in case any of the proposed person to be insured has been / are under any continuous medication for treatment for any illness (Excluding vitamins, supplements) or under treatment for any illness.""",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pickBox("Yes"),
                pickBox("No"),
              ],
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                termConditionChecked!
                    ? {print("Checked")}
                    : setState(() {
                        alertTextShow = true;
                      });
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
                          "View Summary",
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
          ],
        ),
      )),
    );
  }

  pickBox(String? text) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          height: Get.height * 0.055,
          width: Get.width * 0.43,
          child: radioButton(
              value: text.toString(),
              groupValue: "groupValue",
              callBack: () {})),
    );
  }

  Widget radioButton({
    required String value,
    required String groupValue,
    required Function callBack,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          // color: (value.toLowerCase() == profileController.gender.value)
          //     ? AppColors.homeGradient1Color
          //     : AppColors.greySecond,
          color: Colors.grey,
          width: 2,
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Radio(
            activeColor: AppColors.homeGradient1Color,
            value: value,
            groupValue: groupValue,
            onChanged: (value) => callBack(value),
          ),
          Text(value),
          SizedBox(
            width: 16,
          )
        ],
      ),
    );
  }
}
