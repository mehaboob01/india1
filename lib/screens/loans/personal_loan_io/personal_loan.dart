import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/bank_manage_edit_screen.dart/common_validation.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/screens/loans/lenders_list.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/model/create_loan_model.dart';
import 'package:india_one/screens/loyality_points/mobile_recharge/mobile_recharge_ui.dart';
import 'package:india_one/screens/profile/common/profile_stepper.dart';
import 'package:india_one/utils/common_appbar_icons.dart';
import 'package:india_one/utils/common_methods.dart';
import 'package:india_one/widgets/circular_progressbar.dart';
import 'package:india_one/widgets/divider_io.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:india_one/widgets/my_stepper/another_stepper.dart';
import 'package:intl/intl.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../widgets/custom_slider.dart';
import '../../profile/controller/profile_controller.dart';

enum ButtonState { inActive, active }

class PersonalLoan extends StatefulWidget {
  @override
  State<PersonalLoan> createState() => _PersonalLoanState();
}

class _PersonalLoanState extends State<PersonalLoan> {
  LoanController loanController = Get.put(LoanController());
  final GlobalKey<FormBuilderState> _loanAmountKey =
      GlobalKey<FormBuilderState>();

  double widthIs = 0, heightIs = 0;

  TextEditingController loanAmountEditingController = TextEditingController();
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();

    profileController.setData();
    loanController.currentScreen.value = Steps.LOAN_AMOUNT.index;
    loanController.createLoanApplication(
        loanType: LoanType.PersonalLoan,
        callBack: (CreateLoanModel createLoanModel) {
          loanController.minValue.value = double.parse(loanController
              .createLoanModel.value.loanConfiguration!.minLoanAmount
              .toString());
          loanController.maxValue.value = double.parse(loanController
              .createLoanModel.value.loanConfiguration!.maxLoanAmount
              .toString());
          if (createLoanModel.loanAmount != null) {
            if (double.parse(createLoanModel.loanAmount.toString()) >=
                    loanController.minValue.value &&
                double.parse(createLoanModel.loanAmount.toString()) <=
                    loanController.maxValue.value) {
              loanController.sliderValue.value =
                  double.parse(createLoanModel.loanAmount.toString());
              loanAmountEditingController.text = CommonMethods()
                  .indianRupeeValue(createLoanModel.loanAmount!.toDouble());
            }
          } else {
            loanAmountEditingController.text =
                CommonMethods().indianRupeeValue(loanController.minValue.value);
          }
        });
  }

  GlobalKey<FormState> personalForm = GlobalKey<FormState>();
  GlobalKey<FormState> residentialForm = GlobalKey<FormState>();
  GlobalKey<FormState> occupationForm = GlobalKey<FormState>();
  GlobalKey<FormState> additionalForm = GlobalKey<FormState>();

  @override
  void dispose() {
    profileController.resetData();
    super.dispose();
  }

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    print('account formatted');
    print(CommonMethods().accountFormattedText('23456789'));
    // print('Hello world');
    // print(loanController.createLoanModel.value.loanAmount.toString());
    // print(loanAmountEditingController.text);
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;
    return Obx(
      () => loanController.createLoanLoading.value == true
          ? CircularProgressbar()
          : IgnorePointer(
              ignoring: _controller.ignorePointer.value,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                body: SafeArea(
                  child: SizedBox(
                    width: widthIs,
                    child: Obx(
                      () => Stack(
                        children: [
                          Column(
                            children: [
                              CustomAppBar(
                                heading: 'Personal loan',
                                customActionIconsList: commonAppIcons,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Obx(
                                      () => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DividerIO(
                                            height: 21,
                                          ),
                                          Obx(
                                            () => IgnorePointer(
                                              child: AnotherStepper(
                                                stepperList:
                                                    loanController.titleList
                                                        .map((e) => StepperData(
                                                              title: "$e",
                                                            ))
                                                        .toList(),
                                                titleTextStyle: TextStyle(
                                                  fontFamily: AppFonts.appFont,
                                                  fontSize: Dimens.font_12sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                stepperDirection:
                                                    Axis.horizontal,
                                                iconWidth: 25,
                                                iconHeight: 25,
                                                inverted: true,
                                                activeBarColor:
                                                    AppColors.pointsColor,
                                                activeIndex: loanController
                                                    .currentScreen.value,
                                                callBack: (i) {
                                                  loanController
                                                      .currentScreen.value = i;
                                                },
                                              ),
                                            ),
                                          ),
                                          loanController.currentScreen.value ==
                                                  Steps.LOAN_AMOUNT.index
                                              ? loanAmountUi()
                                              : loanController.currentScreen
                                                          .value ==
                                                      Steps.PERSONAL.index
                                                  ? personalInfoUi()
                                                  : loanController.currentScreen
                                                              .value ==
                                                          Steps
                                                              .RESIDENTIAL.index
                                                      ? residentialInfoUi()
                                                      : loanController
                                                                  .currentScreen
                                                                  .value ==
                                                              Steps.ADDITIONAL
                                                                  .index
                                                          ? additionalInfoUI()
                                                          : occupationInfoUi()
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: loanController.currentScreen.value ==
                                        Steps.LOAN_AMOUNT.index
                                    ? loanAmountButton()
                                    : loanController.currentScreen.value ==
                                            Steps.PERSONAL.index
                                        ? personalInfoButton()
                                        : loanController.currentScreen.value ==
                                                Steps.RESIDENTIAL.index
                                            ? residentialInfoButton()
                                            : loanController
                                                        .currentScreen.value ==
                                                    Steps.ADDITIONAL.index
                                                ? additionalInfoButton()
                                                : occupationButton(),
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
        _loanAmountKey.currentState!.save();
        if (_loanAmountKey.currentState!.validate()) {
          double newVal = double.tryParse(
                  loanAmountEditingController.text.replaceAll(',', '')) ??
              0;
          if (newVal <= loanController.minValue.value &&
              newVal >= loanController.maxValue.value) {
            Flushbar(
              title: "Alert!",
              message: "Amount must between min and max loan amount",
              duration: Duration(seconds: 3),
            )..show(context);
          } else {
            loanController.updateLoanAmount(
                amount: loanAmountEditingController.text
                    .replaceAll(",", "")
                    .trim());
          }
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
          child: InkWell(
            onTap: () => loanController.updateScreen(Steps.LOAN_AMOUNT.index),
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
                      loanController.updateScreen(Steps.RESIDENTIAL.index);
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
            onTap: () => loanController.updateScreen(Steps.PERSONAL.index),
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
                      loanController.updateScreen(Steps.OCCUPATION.index);
                    });
              }
            },
            child: LoanCommon().nextButton(),
          ),
        ),
      ],
    );
  }

  // OCCUPATION INFO BUTTON
  Widget occupationButton() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => loanController.updateScreen(Steps.RESIDENTIAL.index),
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
              } else if (profileController.accountType!.value == '') {
                Flushbar(
                  title: "Alert!",
                  message: "Select Salary Mode",
                  duration: Duration(seconds: 3),
                )..show(context);
              } else {
                profileController.addOccupationDetails(
                    isFromLoan: true,
                    loanApplicationId:
                        loanController.createLoanModel.value.loanApplicationId,
                    callBack: () {
                      // profileController.setData();
                      loanController.updateScreen(Steps.ADDITIONAL.index);
                      // Get.to(() => LendersList(
                      //       title: 'Personal loan',
                      //     ));
                    });
              }
            },
            child: LoanCommon().nextButton(),
          ),
        ),
      ],
    );
  }

  // LOAN AMOUNT BUTTON
  Widget additionalInfoButton() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => loanController.updateScreen(Steps.OCCUPATION.index),
            child: LoanCommon().backButton(context: context),
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              // profileController.autoValidation.value = true;
              // if (!occupationForm.currentState!.validate()) {
              //   print("Not validate");
              //   Flushbar(
              //     title: "Alert!",
              //     message: "missing some values",
              //     duration: Duration(seconds: 3),
              //   )..show(context);
              // } else if (profileController.employmentType.value == '') {
              //   Flushbar(
              //     title: "Alert!",
              //     message: "Select employment type",
              //     duration: Duration(seconds: 3),
              //   )..show(context);
              // } else {
              //   profileController.addOccupationDetails(
              //       isFromLoan: true,
              //       loanApplicationId:
              //           loanController.createLoanModel.value.loanApplicationId,
              //       callBack: () {
              //         Get.to(() => LendersList(
              //               title: 'Personal loan',
              //             ));
              //         // loanController.updateScreen(Steps.ADDITIONAL.index);
              //       });
              // }
              // profileController.autoValidation.value = true;
              if (!additionalForm.currentState!.validate()) {
                Flushbar(
                  title: "Alert!",
                  message: "missing some values",
                  duration: Duration(seconds: 3),
                )..show(context);
              } else if (profileController.netbanking.value == '') {
                Flushbar(
                  title: "Alert!",
                  message: "Select if you use netbanking",
                  duration: Duration(seconds: 3),
                )..show(context);
              } else if (profileController.existingLoan.value == '') {
                Flushbar(
                  title: "Alert!",
                  message: "Select if you have existing loans",
                  duration: Duration(seconds: 3),
                )..show(context);

                // log("Validation error");
              } else if (profileController.highestQualification.value == '' ||
                  profileController.highestQualification.value.text.isEmpty ||
                  profileController.highestQualification.value.text
                      .contains("null")) {
                Flushbar(
                  title: "Alert!",
                  message: "Select your highest qualification",
                  duration: Duration(seconds: 3),
                )..show(context);
              } else if (profileController.existingLoan
                          .toLowerCase()
                          .replaceAll(' ', '') ==
                      'yes' &&
                  (profileController.activeOrExistingLoans.value.text.isEmpty ||
                      profileController.activeOrExistingLoans.value.text ==
                          '')) {
                Flushbar(
                  title: "Alert!",
                  message: "Enter the no. of active or existing loans",
                  duration: Duration(seconds: 3),
                )..show(context);
              } else {
                // navigate to next screen

                print(
                    "loans id====> ${loanController.createLoanModel.value.loanApplicationId}");

                print(
                    "print value of additional details==>${profileController.noOfMonthsResiding.value.text.toString()}");
                profileController.addAdditionalDetails(
                    isFromLoan: true,
                    loanApplicationId:
                        loanController.createLoanModel.value.loanApplicationId,
                    callBack: () {
                      profileController.setData();
                      Get.to(() => LendersList(
                            title: 'Personal loan',
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
    print(loanAmountEditingController.text.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DividerIO(
          height: 38,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loan Amount',
                style: AppStyle.shortHeading.copyWith(
                    fontSize: Dimens.font_18sp,
                    color:
                        loanController.currentScreen == Steps.LOAN_AMOUNT.index
                            ? Colors.black
                            : AppColors.black26Color,
                    fontWeight:
                        loanController.currentScreen == Steps.LOAN_AMOUNT.index
                            ? FontWeight.w600
                            : FontWeight.w400),
              ),
              DividerIO(
                height: 24,
              ),
              Text(
                'Enter the loan amount required using the slider OR type in the text field.',
                style: AppStyle.shortHeading.copyWith(
                    fontSize: Dimens.font_14sp,
                    color:
                        loanController.currentScreen == Steps.LOAN_AMOUNT.index
                            ? Colors.grey
                            : AppColors.black26Color,
                    fontWeight:
                        loanController.currentScreen == Steps.LOAN_AMOUNT.index
                            ? FontWeight.w600
                            : FontWeight.w400),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 28, 0, 28),
          child: CustomSlider(
            isAmount: true,
            sliderValue: loanController.sliderValue,
            textEditingController: loanAmountEditingController,
            minValue: loanController.minValue,
            maxValue: loanController.maxValue,
          ),
        ),
        DividerIO(
          height: 18,
        ),
        Padding(
            padding: EdgeInsets.only(
              left: 4.0,
              right: 4,
            ),
            child: FormBuilder(
              key: _loanAmountKey,
              initialValue: {
                // "loan_amount": "",
              },
              child: FormBuilderTextField(
                keyboardType: TextInputType.number,
                controller: loanAmountEditingController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [
                  CurrencyInputFormatter(),
                ],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimens.font_16sp,
                    fontWeight: FontWeight.w600),
                decoration: new InputDecoration(
                  focusColor: Colors.blue,
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("₹",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimens.font_16sp,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFFCDCBCB), width: 1.0),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: 'Loan amount',
                  labelStyle: new TextStyle(color: Color(0xFF787878)),
                ),
                autocorrect: true,
                validator: (value) {
                  // return value!.isNotEmpty ? 'looser' : 'winner';
                  return CommonValidations().maxAmountLengthValidate(
                    value: value,
                    maxValue: loanController.maxValue.value.round(),
                    minValue: loanController.minValue.value.round(),
                  );
                },
                onChanged: (value) {
                  double newVal =
                      double.tryParse(value.toString().replaceAll(',', '')) ??
                          0;
                  if (newVal >= loanController.minValue.value &&
                      newVal <= loanController.maxValue.value) {
                    loanController.sliderValue.value = newVal;
                  } else {
                    loanController.sliderValue.value =
                        loanController.minValue.value;
                  }
                  // loanAmountEditingController.text = (int.parse((value)!.replaceAll(",", "").replaceAll(".", "")).priceString()).toString();
                  // loanAmountEditingController.selection = TextSelection.collapsed(offset: loanAmountEditingController.text.length);
                },
                name: 'loan_amount',
              ),
            )),
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
    );
  }

  //Residential info

  Widget residentialInfoUi() {
    return ProfileStepper().residentialDetails(
      residentialForm,
      isFromLoan: true,
    );
  }

  // Occupation info

  Widget occupationInfoUi() {
    return ProfileStepper().occupationDetails(
      occupationForm,
      isFromLoan: true,
    );
  }

  Widget additionalInfoUI() {
    return ProfileStepper().additionalDetails(
      additionalForm,
    );
  }
}

enum Steps { LOAN_AMOUNT, PERSONAL, RESIDENTIAL, OCCUPATION, ADDITIONAL }
