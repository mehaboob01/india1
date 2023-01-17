import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/screens/loans/lenders_list.dart';
import 'package:india_one/screens/loans/lenders_list_others.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/model/create_loan_model.dart';
import 'package:india_one/screens/loans/personal_loan_io/personal_loan.dart';
import 'package:india_one/screens/profile/common/profile_stepper.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';
import 'package:india_one/utils/common_appbar_icons.dart';
import 'package:india_one/utils/common_methods.dart';
import 'package:india_one/widgets/divider_io.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:india_one/widgets/my_stepper/another_stepper.dart';

import '../../../../widgets/custom_slider.dart';
import '../../../connection_manager/ConnectionManagerController.dart';

class GoldLoanIO extends StatefulWidget {
  @override
  State<GoldLoanIO> createState() => _GoldLoanIOState();
}

class _GoldLoanIOState extends State<GoldLoanIO> {
  final GlobalKey<FormBuilderState> _loanAmountKey =
      GlobalKey<FormBuilderState>();

  double widthIs = 0, heightIs = 0;

  late TextEditingController loanAmountEditingController;
  ProfileController profileController = Get.put(ProfileController());

  LoanController loanController = Get.put(LoanController());
  CreateLoanModel createloanModel = CreateLoanModel();
  @override
  void initState() {
    profileController.setData();
    loanAmountEditingController = TextEditingController();
    super.initState();

    loanController.currentScreen.value = Steps.LOAN_AMOUNT.index;
    loanController.sliderValue.value = loanController.minValue.value;
    loanController.createLoanApplication(
        loanType: LoanType.GoldLoan,
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
              //createLoanModel.loanAmount.toString();
            }
          } else {
            loanAmountEditingController.text =
                CommonMethods().indianRupeeValue(loanController.minValue.value);
          }
        });
    loanAmountEditingController.text = createloanModel.loanAmount == null
        ? CommonMethods().indianRupeeValue(loanController.minValue.value)
        : CommonMethods()
            .indianRupeeValue(createloanModel.loanAmount!.toDouble());
  }

  GlobalKey<FormState> personalForm = GlobalKey<FormState>();
  GlobalKey<FormState> residentialForm = GlobalKey<FormState>();

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  void dispose() {
    profileController.resetData();
    super.dispose();
  }

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
                () => Column(
                  children: [
                    CustomAppBar(
                      heading: 'Gold loan',
                      customActionIconsList: commonAppIcons,
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
                                      stepperList:
                                          loanController.bikeLoanTitleList
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
                                          loanController.currentScreen.value,
                                      callBack: (i) {
                                        loanController.currentScreen.value = i;
                                      },
                                    ),
                                  ),
                                ),
                                loanController.currentScreen.value ==
                                        Steps.LOAN_AMOUNT.index
                                    ? loanAmountUi()
                                    : loanController.currentScreen.value ==
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
                      child: loanController.currentScreen.value ==
                              Steps.LOAN_AMOUNT.index
                          ? loanAmountButton()
                          : loanController.currentScreen.value ==
                                  Steps.PERSONAL.index
                              ? personalInfoButton()
                              : residentialInfoButton(),
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
          double newVal =
              double.tryParse(loanAmountEditingController.text.toString()) ?? 0;

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
                    .removeAllWhitespace,
                type: LoanType.GoldLoan);
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
          child: GestureDetector(
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
              }
              // else if (profileController.maritalStatus.value == '') {
              //   Flushbar(
              //     title: "Alert!",
              //     message: "Select marital status",
              //     duration: Duration(seconds: 3),
              //   )..show(context);
              // }

              else {
                profileController.addPersonalDetails(
                    isFromLoan: true,
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
                    callBack: () {
                      Get.to(() => LendersListOthers(
                            title: 'Gold loan',
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
              text(
                'Loan Amount',
                style: AppStyle.shortHeading.copyWith(
                    fontSize: Dimens.font_18sp,
                    color: loanController.currentScreen.value ==
                            Steps.LOAN_AMOUNT.index
                        ? Colors.black
                        : AppColors.black26Color,
                    fontWeight: loanController.currentScreen.value ==
                            Steps.LOAN_AMOUNT.index
                        ? FontWeight.w600
                        : FontWeight.w400),
              ),
              DividerIO(
                height: 24,
              ),
              text(
                'Enter the loan amount required using the slider OR type in the text field',
                style: AppStyle.shortHeading.copyWith(
                    fontSize: Dimens.font_14sp,
                    color: loanController.currentScreen.value ==
                            Steps.LOAN_AMOUNT.index
                        ? Colors.grey
                        : AppColors.black26Color,
                    fontWeight: loanController.currentScreen.value ==
                            Steps.LOAN_AMOUNT.index
                        ? FontWeight.w600
                        : FontWeight.w400),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 28, 0, 28),
          child: CustomSlider(
            sliderValue: loanController.sliderValue,
            isAmount: true,
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
              // initialValue: {
              //   "loan_amount": "",
              // },
              child: FormBuilderTextField(
                keyboardType: TextInputType.number,
                controller: loanAmountEditingController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimens.font_16sp,
                    fontWeight: FontWeight.w600),
                decoration: new InputDecoration(
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text("₹",
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
                    // width: 0.0 produces a thin "hairline" border
                    borderSide:
                        const BorderSide(color: Color(0xFFCDCBCB), width: 1.0),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: 'Loan amount',
                  labelStyle: TextStyle(color: Color(0xFF787878)),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
                inputFormatters: [CurrencyInputFormatter()],
                onChanged: (value) {
                  double newVal =
                      double.tryParse(value!.replaceAll(",", "").toString()) ??
                          0;
                  if (newVal >= loanController.minValue.value &&
                      newVal <= loanController.maxValue.value) {
                    loanController.sliderValue.value = newVal;
                  } else {
                    loanController.sliderValue.value =
                        loanController.minValue.value;
                  }
                },
                name: 'loan_amount',
              ),
            )),
        DividerIO(
          height: 28,
        ),
      ],
    );
  }

  //Personal info UI

  Widget personalInfoUi() {
    return ProfileStepper().personalDetails(
      context,
      personalForm,
      isFromLoan: true,
      loanType: LoanType.GoldLoan,
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
