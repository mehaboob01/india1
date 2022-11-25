import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/screens/loans/lenders_list.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/model/create_loan_model.dart';
import 'package:india_one/screens/profile/common/profile_stepper.dart';
import 'package:india_one/widgets/circular_progressbar.dart';
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
          loanController.minValue.value =double.parse( loanController.createLoanModel.value.loanConfiguration!.minLoanAmount.toString());
          loanController.maxValue.value =double.parse( loanController.createLoanModel.value.loanConfiguration!.maxLoanAmount.toString());
          if (createLoanModel.loanAmount != null) {
            if (double.parse(createLoanModel.loanAmount.toString()) >= loanController.minValue.value && double.parse(createLoanModel.loanAmount.toString()) <= loanController.maxValue.value) {
              loanController.sliderValue.value = double.parse(createLoanModel.loanAmount.toString());
              loanAmountEditingController.text = createLoanModel.loanAmount.toString();
            }
          }
        });
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
    return

      Obx(  ()=>   loanController.createLoanLoading == true ? CircularProgressbar():
     Scaffold(
        resizeToAvoidBottomInset: false,
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
                          // CustomActionIcons(
                          //   image: AppImages.bottomNavHome,
                          // ),
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
                                    () => IgnorePointer(
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
    ),
      );
  }

  // LOAN AMOUNT BUTTON
  Widget loanAmountButton() {
    return GestureDetector(
      onTap: () {
        _loanAmountKey.currentState!.save();
        if (_loanAmountKey.currentState!.validate()) {
          double newVal = double.tryParse(loanAmountEditingController.text.toString()) ?? 0;
          if (newVal <= loanController.minValue.value && newVal >= loanController.maxValue.value) {
            Flushbar(
              title: "Alert!",
              message: "Amount must between min and max loan amount",
              duration: Duration(seconds: 3),
            )..show(context);
          } else {
            loanController.updateLoanAmount(amount: loanAmountEditingController.text);
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
                    loanApplicationId: loanController.createLoanModel.value.loanApplicationId,
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
                    loanApplicationId: loanController.createLoanModel.value.loanApplicationId,
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
