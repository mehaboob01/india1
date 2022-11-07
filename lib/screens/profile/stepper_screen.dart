import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/profile/common/profile_stepper.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';

import '../../widgets/loyalty_common_header.dart';
import 'number_stepper.dart';

class StepperScreen extends StatelessWidget {
  final int stepNumber;

  StepperScreen({Key? key, required this.stepNumber}) : super(key: key);

  ProfileController profileController = Get.put(ProfileController());

  GlobalKey<FormState> personalForm = GlobalKey<FormState>();
  GlobalKey<FormState> residentialForm = GlobalKey<FormState>();
  GlobalKey<FormState> occupationForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: CustomAppBar(
              heading: 'Profile',
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Obx(
                  () => NumberStepper(
                    totalSteps: profileController.titleList.length,
                    width: MediaQuery.of(context).size.width,
                    curStep: profileController.currentStep.value,
                    stepCompleteColor: AppColors.pointsColor,
                    currentStepColor: AppColors.pointsColor,
                    inactiveColor: Color(0xffbababa),
                    lineWidth: 2,
                    title: profileController.titleList,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Obx(() => SingleChildScrollView(
                        child: Column(
                          children: [
                            if (profileController.currentStep.value == 1) ...[
                              ProfileStepper().personalDetails(context, personalForm),
                            ] else if (profileController.currentStep.value == 2) ...[
                              ProfileStepper().residentialDetails(residentialForm),
                            ] else if (profileController.currentStep.value == 3) ...[
                              ProfileStepper().occupationDetails(occupationForm),
                            ]
                          ],
                        ),
                      )),
                ),
                Obx(() => profileController.addPersonalLoading.value || profileController.addResidentialLoading.value || profileController.addOccupationLoading.value
                    ? CircularProgressIndicator()
                    : InkWell(
                        onTap: () {
                          if (profileController.currentStep.value <= 3) {
                            if (profileController.currentStep.value == 1) {
                              if (!personalForm.currentState!.validate()) {
                                print("Not validate");
                              } else if (profileController.gender.value == '') {
                                Flushbar(
                                  title: "Alert!",
                                  message: "Select gender",
                                  duration: Duration(seconds: 3),
                                )..show(context);
                              } else if (profileController.maritalStatus.value == '') {
                                Flushbar(
                                  title: "Alert!",
                                  message: "Select marital status",
                                  duration: Duration(seconds: 3),
                                )..show(context);
                              } else {
                                profileController.addPersonalDetails();
                              }
                            } else if (profileController.currentStep.value == 2) {
                              if (!residentialForm.currentState!.validate()) {
                                print("Not validate");
                              } else if (profileController.city.value == '') {
                                Flushbar(
                                  title: "Alert!",
                                  message: "Enter valid pincode for city",
                                  duration: Duration(seconds: 3),
                                )..show(context);
                              } else if (profileController.state.value == '') {
                                Flushbar(
                                  title: "Alert!",
                                  message: "Enter valid pincode for state",
                                  duration: Duration(seconds: 3),
                                )..show(context);
                              } else {
                                profileController.addResidentialDetails();
                              }
                            } else if (profileController.currentStep.value == 3) {
                              if (!occupationForm.currentState!.validate()) {
                                print("Not validate");
                              } else if (profileController.employmentType.value == '') {
                                Flushbar(
                                  title: "Alert!",
                                  message: "Select employment type",
                                  duration: Duration(seconds: 3),
                                )..show(context);
                              } else {
                                profileController.addOccupationDetails();
                              }
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Text(
                                    'Save ${profileController.titleList[(profileController.currentStep.value) - 1]} Details',
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  Spacer(),
                                  if (1 == 1)
                                    SizedBox(
                                      height: 48,
                                      child: Image.asset(
                                        "assets/images/btn_img.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                gradient: new LinearGradient(
                                  end: Alignment.topRight,
                                  colors: 1 == 1
                                      ? [
                                          Colors.orange,
                                          Colors.redAccent,
                                        ]
                                      : [
                                          AppColors.btnDisableColor,
                                          AppColors.btnDisableColor,
                                        ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white70.withOpacity(0.8),
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
                                color: 1 == 1 ? AppColors.btnColor : AppColors.btnDisableColor,
                                borderRadius: BorderRadius.circular(6.0),
                              )),
                        ),
                      )),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
