import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/personal_loan_io/personal_loan.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/screens/loans/lenders_list.dart';
import 'package:india_one/screens/profile/common/profile_stepper.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';
import 'package:india_one/widgets/divider_io.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:india_one/widgets/my_stepper/another_stepper.dart';

import '../../../../widgets/custom_slider.dart';


class GoldLoanIO extends StatefulWidget {
  @override
  State<GoldLoanIO> createState() => _GoldLoanIOState();
}

class _GoldLoanIOState extends State<GoldLoanIO> {
  LoanController _plManager = Get.put(LoanController());
  final GlobalKey<FormBuilderState> _loanAmountKey = GlobalKey<FormBuilderState>();

  double widthIs = 0, heightIs = 0;

  late TextEditingController loanAmountEditingController;
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    loanAmountEditingController = TextEditingController();
    super.initState();

    _plManager.currentScreen.value = Steps.LOAN_AMOUNT.index;
    _plManager.sliderValue.value = _plManager.minValue.value;
  }

  GlobalKey<FormState> personalForm = GlobalKey<FormState>();
  GlobalKey<FormState> residentialForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: widthIs,
          child: Obx(
                () => Column(
              children: [
                CustomAppBar(
                  heading: 'Gold loan',
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
        if (profileController.vehicleType.value == '') {
          Flushbar(
            title: "Alert!",
            message: "Select vehicle type",
            duration: Duration(seconds: 3),
          )..show(context);
        } else {
          if (_loanAmountKey.currentState!.validate()) {
            _plManager.updateScreen(Steps.PERSONAL.index);
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
                    callBack: () {
                      _plManager.updateScreen(Steps.RESIDENTIAL.index);
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
              callBack: () {
                Get.to(()=>LendersList(
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
                    color: _plManager.currentScreen == Steps.LOAN_AMOUNT.index ? Colors.black : AppColors.black26Color,
                    fontWeight: _plManager.currentScreen == Steps.LOAN_AMOUNT.index ? FontWeight.w600 : FontWeight.w400),
              ),
              DividerIO(
                height: 24,
              ),
              Text(
                'Choose the loan amount you want from slider or enter in the text field',
                style: AppStyle.shortHeading.copyWith(
                    fontSize: Dimens.font_14sp,
                    color: _plManager.currentScreen == Steps.LOAN_AMOUNT.index ? Colors.grey : AppColors.black26Color,
                    fontWeight: _plManager.currentScreen == Steps.LOAN_AMOUNT.index ? FontWeight.w600 : FontWeight.w400),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 28, 0, 28),
          child: CustomSlider(
            sliderValue: _plManager.sliderValue,
            textEditingController: loanAmountEditingController,
            minValue: _plManager.minValue,
            maxValue: _plManager.maxValue,
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
                  if (newVal >= _plManager.minValue.value && newVal <= _plManager.maxValue.value) {
                    _plManager.sliderValue.value = newVal;
                  } else {
                    _plManager.sliderValue.value = _plManager.minValue.value;
                  }
                },
                name: 'loan_amount',
              ),
            )),
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
          hint: 'Select the two wheeler you are buying',
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
    );
  }

  //Residential info

  Widget residentialInfoUi() {
    return ProfileStepper().residentialDetails(
      residentialForm,
    );
  }
}