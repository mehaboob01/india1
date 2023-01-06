import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/profile/common/profile_stepper.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';
import 'package:india_one/widgets/my_stepper/dto/stepper_data.dart';
import 'package:india_one/widgets/my_stepper/widgets/another_stepper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../connection_manager/ConnectionManagerController.dart';
import '../../constant/routes.dart';
import '../../widgets/loyalty_common_header.dart';

class StepperScreen extends StatefulWidget {
  final int stepNumber;

  StepperScreen({Key? key, required this.stepNumber}) : super(key: key);

  @override
  State<StepperScreen> createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  ProfileController profileController = Get.put(ProfileController());

  GlobalKey<FormState> personalForm = GlobalKey<FormState>();

  GlobalKey<FormState> residentialForm = GlobalKey<FormState>();

  GlobalKey<FormState> occupationForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    profileController.autoValidation.value = false;
    profileController.setData();
  }

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
          body: Column(
            children: [
              SafeArea(
                child: CustomAppBar(
                  heading: 'Profile',
                  customActionIconsList: [
                    CustomActionIcons(
                        image: "assets/svg/homeSvg.svg",
                        isSvg: true,
                        onHeaderIconPressed: () async {
                          Get.toNamed(MRouter.homeScreen);
                        })
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    Obx(
                      () => AnotherStepper(
                        stepperList: profileController.titleList
                            .map((e) => StepperData(
                                  title: "$e",
                                ))
                            .toList(),
                        stepperDirection: Axis.horizontal,
                        iconWidth: 25,
                        iconHeight: 25,
                        inverted: true,
                        activeBarColor: AppColors.pointsColor,
                        activeIndex: profileController.currentStep.value - 1,
                        callBack: (i) {
                          profileController.currentStep.value = i + 1;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Obx(() => SingleChildScrollView(
                            child: Column(
                              children: [
                                if (profileController.currentStep.value ==
                                    1) ...[
                                  ProfileStepper()
                                      .personalDetails(context, personalForm),
                                ] else if (profileController
                                        .currentStep.value ==
                                    2) ...[
                                  ProfileStepper()
                                      .residentialDetails(residentialForm),
                                ] else if (profileController
                                        .currentStep.value ==
                                    3) ...[
                                  ProfileStepper()
                                      .occupationDetails(occupationForm),
                                ]
                              ],
                            ),
                          )),
                    ),
                    Obx(
                      () => profileController.addPersonalLoading.value ||
                              profileController.addResidentialLoading.value ||
                              profileController.addOccupationLoading.value
                          ? LoadingAnimationWidget.inkDrop(
                              size: 34,
                              color: AppColors.primary,
                            )
                          : InkWell(
                              onTap: () {
                                if (profileController.currentStep.value <= 3) {
                                  profileController.autoValidation.value = true;
                                  if (profileController.currentStep.value ==
                                      1) {
                                    if (personalForm.currentState!.validate()) {
                                      profileController.addPersonalDetails(
                                        loanApplicationId: null,
                                      );
                                    }
                                  } else if (profileController
                                          .currentStep.value ==
                                      2) {
                                    if (residentialForm.currentState!
                                        .validate()) {
                                      // if (profileController.city.value.isEmpty ||
                                      //     profileController.state.value.isEmpty) {
                                      //   Fluttertoast.showToast(
                                      //     msg: "Enter valid pin code",
                                      //     toastLength: Toast.LENGTH_SHORT,
                                      //     gravity: ToastGravity.BOTTOM,
                                      //     fontSize: 16.0,
                                      //   );
                                      // } else {
                                      profileController.addResidentialDetails();
                                    }
                                  } else if (profileController
                                          .currentStep.value ==
                                      3) {
                                    if (occupationForm.currentState!
                                        .validate()) {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Spacer(),
                                        Text(
                                          'Save ${profileController.titleList[(profileController.currentStep.value) - 1]} Details',
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
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
                                          color:
                                              Colors.white70.withOpacity(0.8),
                                          offset: Offset(
                                            -6.0,
                                            -6.0,
                                          ),
                                          blurRadius: 16.0,
                                        ),
                                        BoxShadow(
                                          color: AppColors.darkerGrey
                                              .withOpacity(0.4),
                                          offset: Offset(6.0, 6.0),
                                          blurRadius: 16.0,
                                        ),
                                      ],
                                      color: 1 == 1
                                          ? AppColors.btnColor
                                          : AppColors.btnDisableColor,
                                      borderRadius: BorderRadius.circular(6.0),
                                    )),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
