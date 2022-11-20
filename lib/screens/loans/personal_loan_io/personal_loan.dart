import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/screens/loans/lenders_list.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/profile/common/profile_stepper.dart';
import 'package:india_one/widgets/divider_io.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:india_one/widgets/my_stepper/another_stepper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../widgets/custom_slider.dart';
import '../../profile/controller/profile_controller.dart';

enum ButtonState { inActive, active }

class PersonalLoan extends StatefulWidget {
  @override
  State<PersonalLoan> createState() => _PersonalLoanState();
}

class _PersonalLoanState extends State<PersonalLoan> {
  LoanController loanController = Get.put(LoanController());
  final GlobalKey<FormBuilderState> _loanAmountKey = GlobalKey<FormBuilderState>();

  double widthIs = 0, heightIs = 0;

  late TextEditingController loanAmountEditingController;
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.setData();
    loanAmountEditingController = TextEditingController();
    loanController.createLoanApplication(loanType: LoanType.PersonalLoan);
    loanController.currentScreen.value = Steps.LOAN_AMOUNT.index;
    loanController.sliderValue.value = loanController.minValue.value;
  }

  GlobalKey<FormState> personalForm = GlobalKey<FormState>();
  GlobalKey<FormState> residentialForm = GlobalKey<FormState>();
  GlobalKey<FormState> occupationForm = GlobalKey<FormState>();

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
                      heading: 'Personal loan',
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
                                      stepperList: loanController.titleList
                                          .map((e) => StepperData(
                                                title: "$e",
                                              ))
                                          .toList(),
                                      stepperDirection: Axis.horizontal,
                                      iconWidth: 25,
                                      iconHeight: 25,
                                      inverted: true,
                                      activeBarColor: AppColors.pointsColor,
                                      activeIndex: loanController.currentScreen.value,
                                      callBack: (i) {
                                        loanController.currentScreen.value = i;
                                      },
                                    ),
                                  ),
                                ),
                                loanController.currentScreen.value == Steps.LOAN_AMOUNT.index
                                    ? loanAmountUi()
                                    : loanController.currentScreen.value == Steps.PERSONAL.index
                                        ? personalInfoUi()
                                        : loanController.currentScreen.value == Steps.RESIDENTIAL.index
                                            ? residentialInfoUi()
                                            : occupationInfoUi()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: loanController.currentScreen.value == Steps.LOAN_AMOUNT.index
                          ? loanAmountButton()
                          : loanController.currentScreen.value == Steps.PERSONAL.index
                              ? personalInfoButton()
                              : loanController.currentScreen.value == Steps.RESIDENTIAL.index
                                  ? residentialInfoButton()
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
    );
  }

  // LOAN AMOUNT BUTTON
  Widget loanAmountButton() {
    return GestureDetector(
      onTap: () {
        _loanAmountKey.currentState!.save();
        if (_loanAmountKey.currentState!.validate()) {
          if (profileController.gender.value == '') {
            Flushbar(
              title: "Alert!",
              message: "Choose gender",
              duration: Duration(seconds: 3),
            )..show(context);
          } else if (profileController.maritalStatus.value == '') {
            Flushbar(
              title: "Alert!",
              message: "Choose marital status",
              duration: Duration(seconds: 3),
            )..show(context);
          } else {
            loanController.updateLoanAmount(amount: loanAmountEditingController.text);
          }
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
          child: Container(
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
                    loanApplicationId: loanController.createLoanModel.value.loanApplicationId,
                    callBack: () {
                      loanController.updateScreen(Steps.RESIDENTIAL.index);
                    });
              }
            },
            child: Container(
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
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => loanController.updateScreen(Steps.PERSONAL.index),
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
                      loanController.updateScreen(Steps.OCCUPATION.index);
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

  // OCCUPATION INFO BUTTON
  Widget occupationButton() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => loanController.updateScreen(Steps.RESIDENTIAL.index),
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

                // color: termConditionChecked == true
                //     ? AppColors.btnColor
                //     : AppColors.btnDisableColor,
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
              } else {
                profileController.addOccupationDetails(
                    isFromLoan: true,
                    loanApplicationId: loanController.createLoanModel.value.loanApplicationId,
                    callBack: () {
                      Get.to(() => LendersList(
                            title: 'Personal loan',
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
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
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
        Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loan Amount',
                style: AppStyle.shortHeading.copyWith(
                    fontSize: Dimens.font_18sp,
                    color: loanController.currentScreen == Steps.LOAN_AMOUNT.index ? Colors.black : AppColors.black26Color,
                    fontWeight: loanController.currentScreen == Steps.LOAN_AMOUNT.index ? FontWeight.w600 : FontWeight.w400),
              ),
              DividerIO(
                height: 24,
              ),
              Text(
                'Choose the loan amount you want from slider or enter in the text field',
                style: AppStyle.shortHeading.copyWith(
                    fontSize: Dimens.font_14sp,
                    color: loanController.currentScreen == Steps.LOAN_AMOUNT.index ? Colors.grey : AppColors.black26Color,
                    fontWeight: loanController.currentScreen == Steps.LOAN_AMOUNT.index ? FontWeight.w600 : FontWeight.w400),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 28, 0, 28),
          child: CustomSlider(
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
                "loan_amount": "",
              },
              child: FormBuilderTextField(
                keyboardType: TextInputType.number,
                controller: loanAmountEditingController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(color: Colors.black, fontSize: Dimens.font_16sp, fontWeight: FontWeight.w600),
                decoration: new InputDecoration(
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("₹", style: TextStyle(color: Colors.black, fontSize: Dimens.font_16sp, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFCDCBCB), width: 1.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderSide: const BorderSide(color: Color(0xFFCDCBCB), width: 1.0),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: 'Loan amount',
                  labelStyle: new TextStyle(color: Color(0xFF787878)),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
                onChanged: (value) {
                  double newVal = double.tryParse(value.toString()) ?? 0;
                  if (newVal >= loanController.minValue.value && newVal <= loanController.maxValue.value) {
                    loanController.sliderValue.value = newVal;
                  } else {
                    loanController.sliderValue.value = loanController.minValue.value;
                  }
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
}

enum Steps { LOAN_AMOUNT, PERSONAL, RESIDENTIAL, OCCUPATION }
