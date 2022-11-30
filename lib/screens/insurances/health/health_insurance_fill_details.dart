import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/screens/insurances/controller/insurance_controller.dart';
import 'package:india_one/screens/profile/common/profile_stepper.dart';
import 'package:india_one/widgets/my_stepper/dto/stepper_data.dart';
import 'package:india_one/widgets/my_stepper/widgets/another_stepper.dart';

import '../../../constant/theme_manager.dart';
import '../../../widgets/divider_io.dart';
import '../../../widgets/loyalty_common_header.dart';

class HealthInsuranceFillDetails extends StatefulWidget {
  const HealthInsuranceFillDetails({Key? key}) : super(key: key);

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

  double widthIs = 0, heightIs = 0;

  @override
  void initState() {
    super.initState();
    insuranceController.currentScreen.value = InsuranceStep.PERSONAL.index;
  }

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: widthIs,
        height: heightIs,
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                heading: 'Accident Insurance',
                customActionIconsList: [
                  CustomActionIcons(
                    image: AppImages.bottomNavHome, onHeaderIconPressed: () async{  },
                  ),
                ],
              ),
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
                                  print("find me");
                                  insuranceController.currentScreen.value = i;
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
    );
  }

  Widget occupationInfoUi() {
    return ProfileStepper().occupationDetails(occupationForm);
  }

  Widget nomineeInfoUi() {
    return ProfileStepper().nomineeDetails(context, nomineeForm);
  }

  Widget healthInfoUi() {
    return ProfileStepper().healthStepper(nomineeForm);
  }

  Widget bottomBtnWidget() {
    return GestureDetector(
      onTap: () {
        if (insuranceController.currentScreen.value ==
            InsuranceStep.HEALTH.index) {
          Get.toNamed(MRouter.insuranceSummary);
        } else {
          insuranceController
              .updateScreen(insuranceController.currentScreen.value + 1);
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
                  'NEXT',
                  style: AppTextThemes.button,
                ),
                SizedBox(
                  width: 6,
                ),
              ],
            ),
            Spacer(),
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
    );
  }
}