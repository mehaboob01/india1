import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/personal_loan_io/personal_loan.dart';
import 'package:india_one/screens/profile/common/profile_stepper.dart';
import 'package:india_one/widgets/divider_io.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:india_one/widgets/my_stepper/another_stepper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../widgets/custom_slider.dart';
import '../../profile/controller/profile_controller.dart';
import '../lenders_list.dart';

class BikeLoanIO extends StatefulWidget {
  @override
  State<BikeLoanIO> createState() => _BikeLoanIOState();
}

class _BikeLoanIOState extends State<BikeLoanIO> {
  LoanController _plManager = Get.put(LoanController());

  double widthIs = 0, heightIs = 0;

  late TextEditingController loanAmountEditingController;
  ProfileController profileController = Get.put(ProfileController());
  LoanController loanController = Get.put(LoanController());

  @override
  void initState() {
    loanAmountEditingController = TextEditingController();
    profileController.setData();
    super.initState();
    loanController.createLoanApplication(loanType: LoanType.BikeLoan);
    _plManager.currentScreen.value = Steps.LOAN_AMOUNT.index;
    _plManager.sliderValue.value = _plManager.minValue.value;
  }

  GlobalKey<FormState> personalForm = GlobalKey<FormState>();
  GlobalKey<FormState> residentialForm = GlobalKey<FormState>();

  @override
  void dispose() {
    profileController.resetData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: widthIs,
          child: Obx(
            () => Stack(
              children: [
                Column(
                  children: [
                    CustomAppBar(
                      heading: 'Bike loan',
                      customActionIconsList: [
                        CustomActionIcons(
                          image: AppImages.bottomNavHome,
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
                                      stepperList: _plManager.bikeLoanTitleList
                                          .map((e) => StepperData(
                                                title: "$e",
                                              ))
                                          .toList(),
                                      stepperDirection: Axis.horizontal,
                                      iconWidth: 25,
                                      iconHeight: 25,
                                      inverted: true,
                                      activeBarColor: AppColors.pointsColor,
                                      activeIndex: _plManager.currentScreen.value,
                                      callBack: (i) {
                                        _plManager.currentScreen.value = i;
                                      },
                                    ),
                                  ),
                                ),
                                _plManager.currentScreen.value == Steps.LOAN_AMOUNT.index
                                    ? loanAmountUi()
                                    : _plManager.currentScreen.value == Steps.PERSONAL.index
                                        ? personalInfoUi()
                                        : residentialInfoUi()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: _plManager.currentScreen.value == Steps.LOAN_AMOUNT.index
                          ? loanAmountButton()
                          : _plManager.currentScreen.value == Steps.PERSONAL.index
                              ? personalInfoButton()
                              : residentialInfoButton(),
                    ),
                  ],
                ),
                if (loanController.createLoanLoading.value == true)
                  Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: LoadingAnimationWidget.inkDrop(
                      size: 34,
                      color: AppColors.primary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // LOAN AMOUNT BUTTON
  Widget loanAmountButton() {
    return GestureDetector(
      onTap: () {
        //TODO remove before push
        //loanController.updateScreen(Steps.PERSONAL.index);

        if (profileController.vehicleType.value == '') {
          Flushbar(
            title: "Alert!",
            message: "Select vehicle type",
            duration: Duration(seconds: 3),
          )..show(context);
        } else {
            loanController.updateLoanAmount(amount: loanAmountEditingController.text);
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

  // PERSONAL INFO BUTTON
  Widget personalInfoButton() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _plManager.updateScreen(Steps.LOAN_AMOUNT.index),
            child: Container(
              width: MediaQuery.of(context).size.height * 0.9,
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'BACK',
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
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              personalForm.currentState!.save();
              profileController.autoValidation.value = true;
              if (!personalForm.currentState!.validate()) {
                Flushbar(
                  title: "Alert!",
                  message: "missing some values",
                  duration: Duration(seconds: 3),
                )..show(context);
              } else if (profileController.gender.value == '') {
                Flushbar(
                  title: "Alert!",
                  message: "Select gender",
                  duration: Duration(seconds: 3),
                )..show(context);
              } else {
                profileController.addPersonalDetails(
                    isFromLoan: true,
                    loanApplicationId: loanController.createLoanModel.value.loanApplicationId,
                    callBack: () {
                      loanController.updateScreen(Steps.RESIDENTIAL.index);
                    });
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.height * 0.9,
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'NEXT',
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
    );
  }

  // RESIDENTIAL INFO BUTTON

  Widget residentialInfoButton() {
    return InkWell(
      onTap: () {
        profileController.autoValidation.value = true;
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
          profileController.addResidentialDetails(
              isFromLoan: true,
              loanApplicationId: loanController.createLoanModel.value.loanApplicationId,
              callBack: () {
                Get.to(() => LendersList(
                      title: 'Bike loan',
                    ));
              });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.height * 0.9,
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NEXT',
              style: AppTextThemes.button,
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            end: Alignment.topRight,
            colors: [Colors.orange, Colors.redAccent],
          ),

          // color: termConditionChecked == true
          //     ? AppColors.btnColor
          //     : AppColors.btnDisableColor,
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
  }

  // SCREENS UI FOR DIFFERENT STEPS

  Widget loanAmountUi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DividerIO(
          height: 28,
        ),
        ProfileStepper().commonDropDown(
          item: <String>['2 wheeler - Scooty', '2 wheeler - Bike'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
          onChanged: (value) {
            profileController.vehicleType.value = value;
          },
          label: 'Two wheeler required',
          hint: 'Select the 2 wheeler you are buying',
          value: profileController.vehicleType.value == '' ? null : profileController.vehicleType.value,
        ),
        SizedBox(
          height: 54,
        )
      ],
    );
  }

  //Personal info UI

  Widget personalInfoUi() {
    return ProfileStepper().personalDetails(
      context,
      personalForm,
      isFromLoan: true,
      loanType: LoanType.BikeLoan,
    );
  }

  //Residential info

  Widget residentialInfoUi() {
    return ProfileStepper().residentialDetails(
      residentialForm,
      isFromLoan: true,
    );
  }
}