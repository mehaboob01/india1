import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/screens/loans/lenders_list.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/personal_loan_io/personal_loan.dart';
import 'package:india_one/screens/profile/common/profile_stepper.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';
import 'package:india_one/utils/common_appbar_icons.dart';
import 'package:india_one/widgets/divider_io.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:india_one/widgets/my_stepper/another_stepper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../connection_manager/ConnectionManagerController.dart';

class CarLoanIO extends StatefulWidget {
  @override
  State<CarLoanIO> createState() => _CarLoanIOState();
}

class _CarLoanIOState extends State<CarLoanIO> {
  LoanController _plManager = Get.put(LoanController());

  double widthIs = 0, heightIs = 0;

  late TextEditingController loanAmountEditingController;
  ProfileController profileController = Get.put(ProfileController());
  LoanController loanController = Get.put(LoanController());

  @override
  void initState() {
    profileController.setData();
    loanAmountEditingController = TextEditingController();
    super.initState();
    loanController.createLoanApplication(loanType: LoanType.CarLoan);

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

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: widthIs,
              child: Obx(
                () => Stack(
                  children: [
                    Column(
                      children: [
                        CustomAppBar(
                            heading: 'Car loan',
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
                                        child: IgnorePointer(
                                          child: AnotherStepper(
                                            stepperList:
                                                _plManager.bikeLoanTitleList
                                                    .map((e) => StepperData(
                                                          title: "$e".tr,
                                                        ))
                                                    .toList(),
                                            stepperDirection: Axis.horizontal,
                                            iconWidth: 25,
                                            iconHeight: 25,
                                            inverted: true,
                                            activeBarColor:
                                                AppColors.pointsColor,
                                            activeIndex:
                                                _plManager.currentScreen.value,
                                            callBack: (i) {
                                              _plManager.currentScreen.value =
                                                  i;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    _plManager.currentScreen.value ==
                                            Steps.LOAN_AMOUNT.index
                                        ? loanAmountUi()
                                        : _plManager.currentScreen.value ==
                                                Steps.PERSONAL.index
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
                          child: _plManager.currentScreen.value ==
                                  Steps.LOAN_AMOUNT.index
                              ? loanAmountButton()
                              : _plManager.currentScreen.value ==
                                      Steps.PERSONAL.index
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
        ),
      ),
    );
  }

  // LOAN AMOUNT BUTTON
  Widget loanAmountButton() {
    return GestureDetector(
      onTap: () {
        if (profileController.vehicleType.value == '') {
          Flushbar(
            title: "Alert!",
            message: "Select vehicle type",
            duration: Duration(seconds: 3),
          )..show(context);
        } else {
          loanController.updateLoanAmount(
              amount: loanAmountEditingController.text, type: LoanType.CarLoan);
        }
      },
      child: LoanCommon().nextButton(),
    );
  }

  // PERSONAL INFO BUTTON
  Widget personalInfoButton() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _plManager.updateScreen(Steps.LOAN_AMOUNT.index),
            child: LoanCommon().backButton(context: context),
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
              } else if (profileController.maritalStatus.value == '') {
                Flushbar(
                  title: "Alert!",
                  message: "Select marital status",
                  duration: Duration(seconds: 3),
                )..show(context);
              } else {
                profileController.addPersonalDetails(
                    isFromLoan: true,
                    loanApplicationId:
                        loanController.createLoanModel.value.loanApplicationId,
                    callBack: () {
                      _plManager.updateScreen(Steps.RESIDENTIAL.index);
                    });
              }
            },
            child: LoanCommon().nextButton(),
          ),
        ),
      ],
    );
  }

  // RESIDENTIAL INFO BUTTON

  Widget residentialInfoButton() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _plManager.updateScreen(Steps.PERSONAL.index),
            child: LoanCommon().backButton(context: context),
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: InkWell(
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
                    loanApplicationId:
                        loanController.createLoanModel.value.loanApplicationId,
                    callBack: () {
                      Get.to(() => LendersList(
                            title: 'Car loan',
                          ));
                    });
              }
            },
            child: LoanCommon().nextButton(),
          ),
        ),
      ],
    );
  }

  // SCREENS UI FOR DIFFERENT STEPS

  Widget loanAmountUi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DividerIO(
          height: 38,
        ),
        ProfileStepper().commonDropDown(
          item: [
            {"name": "4 wheeler - New", "value": "FourWheelerNew"},
            {"name": "4 wheeler - Preowned", "value": "FourWheelerPreowned"},
          ].map((value) {
            return DropdownMenuItem(
              value: value['value'],
              child: text(value['name'].toString()),
            );
          }).toList(),
          onChanged: (value) {
            print(value);
            profileController.vehicleType.value = value;
          },
          label: '4 wheeler required',
          hint: 'Select the car you are willing to buy',
          value: profileController.vehicleType.value == ''
              ? null
              : profileController.vehicleType.value,
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
      loanType: LoanType.CarLoan,
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
