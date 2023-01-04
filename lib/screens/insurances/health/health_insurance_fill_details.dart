import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/screens/insurances/controller/insurance_controller.dart';
import 'package:india_one/screens/profile/common/profile_stepper.dart';
import 'package:india_one/utils/common_appbar_icons.dart';
import 'package:india_one/widgets/my_stepper/dto/stepper_data.dart';
import 'package:india_one/widgets/my_stepper/widgets/another_stepper.dart';

import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../constant/theme_manager.dart';
import '../../../widgets/divider_io.dart';
import '../../../widgets/loyalty_common_header.dart';
import '../../profile/controller/profile_controller.dart';

class HealthInsuranceFillDetails extends StatefulWidget {
  final bool isAccidentInsurance;

  const HealthInsuranceFillDetails({
    Key? key,
    required this.isAccidentInsurance,
  }) : super(key: key);

  @override
  State<HealthInsuranceFillDetails> createState() =>
      _HealthInsuranceFillDetailsState();
}

class _HealthInsuranceFillDetailsState
    extends State<HealthInsuranceFillDetails> {
  InsuranceController insuranceController = Get.put(InsuranceController());
  GlobalKey<FormState> personalForm = GlobalKey<FormState>();
  GlobalKey<FormState> residentialForm = GlobalKey<FormState>();
  GlobalKey<FormState> occupationForm = GlobalKey<FormState>();
  GlobalKey<FormState> nomineeForm = GlobalKey<FormState>();
  GlobalKey<FormState> healthForm = GlobalKey<FormState>();

  final GlobalKey<FormBuilderState> _loanAmountKey =
      GlobalKey<FormBuilderState>();
  ProfileController profileController = Get.put(ProfileController());

  double widthIs = 0, heightIs = 0;

  @override
  void initState() {
    super.initState();
    profileController.setData();

    profileController.autoValidation.value = true;
    insuranceController.currentScreen.value = InsuranceStep.PERSONAL.index;
  }

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;
    return IgnorePointer(
      ignoring: _controller.ignorePointer.value,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: widthIs,
          height: heightIs,
          child: SafeArea(
            child: Column(
              children: [
                CustomAppBar(
                    heading: widget.isAccidentInsurance
                        ? 'Accident Insurance'
                        : "Critical Illness",
                    customActionIconsList: commonAppIcons),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DividerIO(
                              height: 21,
                            ),
                            Obx(
                              () => Container(
                                child: AnotherStepper(
                                  stepperList: insuranceController.titleList
                                      .map((e) => StepperData(
                                            title: "$e",
                                          ))
                                      .toList(),
                                  stepperDirection: Axis.horizontal,
                                  iconWidth: 25,
                                  iconHeight: 25,
                                  inverted: true,
                                  activeBarColor: AppColors.pointsColor,
                                  activeIndex:
                                      insuranceController.currentScreen.value,
                                  callBack: (i) {
                                    // print("find me");
                                    // if (i <=
                                    //     insuranceController
                                    //         .insuranceCompletedIndex.value) {
                                    //   insuranceController.currentScreen.value = i;
                                    // }
                                  },
                                ),
                              ),
                            ),
                            /*insuranceController.currentScreen.value ==
                                    Steps.LOAN_AMOUNT.index
                                ? loanAmountUi()
                                : loanController.currentScreen.value ==
                                        Steps.PERSONAL.index
                                    ? personalInfoUi()
                                    : residentialInfoUi()*/
                            getBody(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.0), child: bottomBtnWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    if (insuranceController.currentScreen.value ==
        InsuranceStep.PERSONAL.index) {
      return personalInfoUi();
    } else if (insuranceController.currentScreen.value ==
        InsuranceStep.RESIDENTIAL.index) {
      return residentialInfoUi();
    } else if (insuranceController.currentScreen.value ==
        InsuranceStep.OCCUPATION.index) {
      return occupationInfoUi();
    } else if (insuranceController.currentScreen.value ==
        InsuranceStep.NOMINEE.index) {
      return nomineeInfoUi();
    } else if (insuranceController.currentScreen.value ==
        InsuranceStep.HEALTH.index) {
      return healthInfoUi();
    }
    return SizedBox();
  }

  Widget personalInfoUi() {
    return ProfileStepper().personalDetails(
      context,
      personalForm,
      isFromLoan: true,
    );
  }

  //Residential info

  Widget residentialInfoUi() {
    return ProfileStepper().residentialDetails(
      residentialForm,
      isFromInsurance: true,
    );
  }

  Widget occupationInfoUi() {
    return ProfileStepper().occupationDetails(
      occupationForm,
      isFromInsurance: true,
    );
  }

  Widget nomineeInfoUi() {
    return ProfileStepper().nomineeDetails(
      context,
      nomineeForm,
      isFromInsurance: true,
    );
  }

  Widget healthInfoUi() {
    return ProfileStepper().healthStepper(
      healthForm,
    );
  }

  Widget bottomBtnWidget() {
    return Container(
      width: widthIs,
      child: Obx(() {
        return Row(
          children: [
            if (insuranceController.currentScreen > 0) ...[
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      insuranceController
                          .updateScreen(insuranceController.currentScreen - 1);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.9,
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Back',
                            style: AppTextThemes.button,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                          end: Alignment.topRight,
                          colors: [Color(0xFF357CBE), Color(0xFF004280)],
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    )
                    //  Container(
                    //   // width: MediaQuery.of(context).size.height * 0.9,
                    //   height: 48,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Text(
                    //             'BACK',
                    //             style: AppTextThemes.button,
                    //           ),
                    //           SizedBox(
                    //             width: 6,
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    //   decoration: BoxDecoration(
                    //     gradient: new LinearGradient(
                    //       end: Alignment.topRight,
                    //       colors: [Colors.orange, Colors.redAccent],
                    //     ),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.white.withOpacity(0.8),
                    //         offset: Offset(
                    //           -6.0,
                    //           -6.0,
                    //         ),
                    //         blurRadius: 16.0,
                    //       ),
                    //       BoxShadow(
                    //         color: AppColors.darkerGrey.withOpacity(0.4),
                    //         offset: Offset(6.0, 6.0),
                    //         blurRadius: 16.0,
                    //       ),
                    //     ],
                    //     // color: termConditionChecked == true
                    //     //     ? AppColors.btnColor
                    //     //     : AppColors.btnDisableColor,
                    //     borderRadius: BorderRadius.circular(6.0),
                    //   ),
                    // ),
                    ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (isValidData()) {
                    nextAction();
                  }
                },
                child: Container(
                  // width: MediaQuery.of(context).size.height * 0.9,
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            insuranceController.currentScreen.value ==
                                    InsuranceStep.HEALTH.index
                                ? 'View Summary'
                                : 'NEXT',
                            style: AppTextThemes.button,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                        ],
                      ),
                      Spacer(),
                      // SizedBox(
                      //   height: 48,
                      //   child: Image.asset(
                      //     "assets/images/btn_img.png",
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      end: Alignment.topRight,
                      colors: [Colors.orange, Colors.redAccent],
                    ),
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
                    // color: termConditionChecked == true
                    //     ? AppColors.btnColor
                    //     : AppColors.btnDisableColor,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  bool isValidData() {
    profileController.autoValidation.value = true;

    if (insuranceController.currentScreen.value ==
        InsuranceStep.PERSONAL.index) {
      personalForm.currentState!.save();
      profileController.autoValidation.value = true;
      if (!personalForm.currentState!.validate()) {
        Flushbar(
          title: "Alert!",
          message: "missing some values",
          duration: Duration(seconds: 3),
        )..show(context);
      } else {
        return true;
      }
    } else if (insuranceController.currentScreen.value ==
        InsuranceStep.RESIDENTIAL.index) {
      if (!residentialForm.currentState!.validate()) {
        Flushbar(
          title: "Alert!",
          message: "missing some values",
          duration: Duration(seconds: 3),
        )..show(context);
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
        return true;
      }
    } else if (insuranceController.currentScreen.value ==
        InsuranceStep.OCCUPATION.index) {
      profileController.autoValidation.value = true;
      if (!occupationForm.currentState!.validate()) {
        print("Not validate");
        Flushbar(
          title: "Alert!",
          message: "missing some values",
          duration: Duration(seconds: 3),
        )..show(context);
      } else if (profileController.employmentType.value == '') {
        Flushbar(
          title: "Alert!",
          message: "Select employment type",
          duration: Duration(seconds: 3),
        )..show(context);
      } else if (profileController.monthlyIncomeController.value.text
          .trim()
          .isEmpty) {
        Flushbar(
          title: "Alert!",
          message: "enter your income",
          duration: Duration(seconds: 3),
        )..show(context);
      } else if (profileController.panNumberController.value.text
          .trim()
          .isEmpty) {
        Flushbar(
          title: "Alert!",
          message: "enter your pan number",
          duration: Duration(seconds: 3),
        )..show(context);
      } else {
        return true;
      }
    } else if (insuranceController.currentScreen.value ==
        InsuranceStep.NOMINEE.index) {
      if (!nomineeForm.currentState!.validate()) {
        Flushbar(
          title: "Alert!",
          message: "missing some values",
          duration: Duration(seconds: 3),
        )..show(context);
      } else if (profileController.nomineeRelationship.value.trim().isEmpty) {
        Flushbar(
          title: "Alert!",
          message: "select relationship",
          duration: Duration(seconds: 3),
        )..show(context);
      } else {
        return true;
      }
    } else if (insuranceController.currentScreen.value ==
        InsuranceStep.HEALTH.index) {
      return true;
    }

    return false;
  }

  void nextAction() {
    // if (insuranceController.currentScreen.value ==
    //     InsuranceStep.HEALTH.index) {
    //   Get.toNamed(MRouter.insuranceSummary);
    // } else {
    //   insuranceController
    //       .updateScreen(insuranceController.currentScreen.value + 1);
    // }
    if (insuranceController.currentScreen.value ==
        InsuranceStep.PERSONAL.index) {
      profileController.addPersonalDetails(
          isFromLoan: true,
          insuranceApplicationId:
              insuranceController.insuranceApplicationModel.value.id,
          callBack: () {
            if (insuranceController.insuranceCompletedIndex.value <
                InsuranceStep.RESIDENTIAL.index) {
              insuranceController.insuranceCompletedIndex.value =
                  InsuranceStep.RESIDENTIAL.index;
            }
            insuranceController.updateScreen(InsuranceStep.RESIDENTIAL.index);
          });
      return;
    } else if (insuranceController.currentScreen.value ==
        InsuranceStep.RESIDENTIAL.index) {
      profileController.addResidentialDetails(
          isFromLoan: true,
          insuranceApplicationId:
              insuranceController.insuranceApplicationModel.value.id,
          callBack: () {
            insuranceController.insuranceCompletedIndex.value =
                InsuranceStep.OCCUPATION.index;
            insuranceController
                .updateScreen(insuranceController.currentScreen.value + 1);
            // LoanCommon().bottomSheet(
            //   context,
            //   lenderId: "lenders.id ?? ''",
            //   callBack: () {
            //     // Get.off(() => LendersList(
            //     //           title: 'Farm loan',
            //     //         ));
            //     loanController.applyLoan(
            //       providerId: '',
            //       lenderId: '',
            //     );
            //   },
            //   providerId: '',
            // );
          });
      return;
    } else if (insuranceController.currentScreen.value ==
        InsuranceStep.OCCUPATION.index) {
      profileController.addOccupationDetails(
          isFromLoan: true,
          insuranceApplicationId:
              insuranceController.insuranceApplicationModel.value.id,
          callBack: () {
            insuranceController.insuranceCompletedIndex.value =
                InsuranceStep.NOMINEE.index;
            insuranceController
                .updateScreen(insuranceController.currentScreen.value + 1);
          });
      return;
    } else if (insuranceController.currentScreen.value ==
        InsuranceStep.NOMINEE.index) {
      profileController.addNomineeDetails(
          insuranceApplicationId:
              insuranceController.insuranceApplicationModel.value.id,
          callBack: () {
            insuranceController.insuranceCompletedIndex.value =
                InsuranceStep.HEALTH.index;
            insuranceController
                .updateScreen(insuranceController.currentScreen.value + 1);
          });
      return;
    } else if (insuranceController.currentScreen.value ==
        InsuranceStep.HEALTH.index) {
      insuranceController.insuranceCompletedIndex.value =
          InsuranceStep.RESIDENTIAL.index;
      Get.toNamed(MRouter.insuranceSummary);
      return;
    }

    // insuranceController
    //     .updateScreen(insuranceController.currentScreen.value + 1);
  }
}
