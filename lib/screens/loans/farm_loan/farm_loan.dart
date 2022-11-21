import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/personal_loan_io/personal_loan.dart';
import 'package:india_one/screens/profile/common/profile_stepper.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';
import 'package:india_one/widgets/divider_io.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:india_one/widgets/my_stepper/another_stepper.dart';

class FarmLoan extends StatefulWidget {
  const FarmLoan({Key? key}) : super(key: key);

  @override
  State<FarmLoan> createState() => _FarmLoanState();
}

class _FarmLoanState extends State<FarmLoan> {
  LoanController _plManager = Get.put(LoanController());
  final GlobalKey<FormBuilderState> _loanAmountKey = GlobalKey<FormBuilderState>();

  double widthIs = 0, heightIs = 0;

  late TextEditingController loanAmountEditingController;
  ProfileController profileController = Get.put(ProfileController());
  LoanController loanController = Get.put(LoanController());

  LoanDetailsModel loanDetailsModel = LoanDetailsModel(loanRequirement: [
    LoanSubDetailsModel(name: 'Loan against tractor', subProduct: [
      'Baler',
      'Bowler',
      'Boom sprayer'
    ], implementBrand: [
      'ACE',
      'Agriona industries',
      'Amar',
    ]),
    LoanSubDetailsModel(name: 'Track based personal loan', subProduct: [
      'Baler',
      'Bowler',
      'Boom sprayer'
    ], implementBrand: [
      'ACE',
      'Agriona industries',
      'Amar',
    ]),
    LoanSubDetailsModel(name: 'Implement finance', subProduct: [
      'Baler',
      'Bowler',
      'Boom sprayer'
    ], implementBrand: [
      'ACE',
      'Agriona industries',
      'Amar',
    ]),
  ]);

  @override
  void initState() {
    loanAmountEditingController = TextEditingController();
    super.initState();

    _plManager.currentScreen.value = Steps.LOAN_AMOUNT.index;
    _plManager.sliderValue.value = _plManager.minValue.value;
    resetValues();
    loanController.createLoanApplication(loanType: LoanType.FarmLoan);
  }

  void resetValues() {
    profileController.loanRequirement.value = -1;
    profileController.subProduct.value = -1;
    profileController.brand.value = -1;
  }

  GlobalKey<FormState> personalForm = GlobalKey<FormState>();
  GlobalKey<FormState> residentialForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false, 
      body: SafeArea(
        child: SizedBox(
          width: widthIs,
          child: Obx(
            () => Column(
              children: [
                CustomAppBar(
                  heading: 'Farm loan',
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
                                    print("find me");
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
          ),
        ),
      ),
    );
  }

  // LOAN AMOUNT BUTTON
  Widget loanAmountButton() {
    return GestureDetector(
      onTap: () {
        String? msg;
        if (profileController.loanRequirement.value == -1) {
          msg = "Select loan requirement";
        } else if (profileController.subProduct.value == -1) {
          msg = "Select sub product";
        } else if (profileController.brand.value == -1) {
          msg = "Select brand";
        }

        if (msg != null) {
          Flushbar(
            title: "Alert!",
            message: msg,
            duration: Duration(seconds: 3),
          )..show(context);
        } else {
          _plManager.updateScreen(Steps.PERSONAL.index);
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
              }
              /*else if (profileController.gender.value == '') {
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
              }*/
              else {
                profileController.addPersonalDetails(
                    isFromLoan: true,
                    loanApplicationId: loanController.createLoanModel.value.loanApplicationId,
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
              loanApplicationId: loanController.createLoanModel.value.loanApplicationId,
              callBack: () {
                // Get.to(() => LendersList(
                //       title: 'Farm loan',
                //     ));

                LoanCommon().bottomSheet(
                  context,
                  lenderId: "lenders.id ?? ''",
                  callBack: () {
                    ///todo need to add API for apply loan and redirect to proper screen
                    Get.back();
                    Get.back();
                    // Get.off(() => LendersList(
                    //           title: 'Farm loan',
                    //         ));
                    // loanController.applyLoan(
                    //   providerId: '',
                    //   lenderId: lenders.id ?? '',
                    // );
                  },
                  providerId: '',
                );
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
                    color: _plManager.currentScreen.value == Steps.LOAN_AMOUNT.index ? Colors.black : AppColors.black26Color,
                    fontWeight: _plManager.currentScreen.value == Steps.LOAN_AMOUNT.index ? FontWeight.w600 : FontWeight.w400),
              ),
              DividerIO(
                height: 24,
              ),
              Text(
                'Choose the loan amount you want from slider or enter in the text field',
                style: AppStyle.shortHeading.copyWith(
                    fontSize: Dimens.font_14sp,
                    color: _plManager.currentScreen.value == Steps.LOAN_AMOUNT.index ? Colors.grey : AppColors.black26Color,
                    fontWeight: _plManager.currentScreen.value == Steps.LOAN_AMOUNT.index ? FontWeight.w600 : FontWeight.w400),
              ),
            ],
          ),
        ),
        // Container(
        //   margin: EdgeInsets.fromLTRB(0, 28, 0, 28),
        //   child: CustomSlider(
        //     sliderValue: _plManager.sliderValue,
        //     textEditingController: loanAmountEditingController,
        //     minValue: _plManager.minValue,
        //     maxValue: _plManager.maxValue,
        //   ),
        // ),
        // DividerIO(
        //   height: 18,
        // ),
        // Padding(
        //     padding: EdgeInsets.only(
        //       left: 4.0,
        //       right: 4,
        //     ),
        //     child: FormBuilder(
        //       key: _loanAmountKey,
        //       initialValue: {
        //         "loan_amount": "",
        //       },
        //       child: FormBuilderTextField(
        //         keyboardType: TextInputType.number,
        //         controller: loanAmountEditingController,
        //         autovalidateMode: AutovalidateMode.onUserInteraction,
        //         style: TextStyle(color: Colors.black,
        //             fontSize: Dimens.font_16sp,
        //             fontWeight: FontWeight.w600),
        //         decoration: new InputDecoration(
        //           prefixIcon: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Text("₹", style: TextStyle(color: Colors.black,
        //                   fontSize: Dimens.font_16sp,
        //                   fontWeight: FontWeight.w600)),
        //             ],
        //           ),
        //           focusedBorder: const OutlineInputBorder(
        //             borderSide: BorderSide(
        //                 color: Color(0xFFCDCBCB), width: 1.0),
        //           ),
        //           enabledBorder: const OutlineInputBorder(
        //             // width: 0.0 produces a thin "hairline" border
        //             borderSide: const BorderSide(
        //                 color: Color(0xFFCDCBCB), width: 1.0),
        //           ),
        //           border: const OutlineInputBorder(),
        //           labelText: 'Loan amount',
        //           labelStyle: new TextStyle(color: Color(0xFF787878)),
        //         ),
        //         validator: FormBuilderValidators.compose([
        //           FormBuilderValidators.required(context),
        //         ]),
        //         onChanged: (value) {
        //           double newVal = double.tryParse(value.toString()) ?? 0;
        //           if (newVal >= _plManager.minValue.value &&
        //               newVal <= _plManager.maxValue.value) {
        //             _plManager.sliderValue.value = newVal;
        //           } else {
        //             _plManager.sliderValue.value = _plManager.minValue.value;
        //           }
        //         },
        //         name: 'loan_amount',
        //       ),
        //     )),
        DividerIO(
          height: 28,
        ),
        ProfileStepper().commonDropDown(
          item: loanDetailsModel.loanRequirement.map<DropdownMenuItem<LoanSubDetailsModel>>((LoanSubDetailsModel value) {
            return DropdownMenuItem<LoanSubDetailsModel>(
              value: value,
              child: Text(value.name.toString()),
            );
          }).toList(),
          onChanged: (value) {
            // profileController.loanRequirement.value = value.name;
            profileController.loanRequirement.value = loanDetailsModel.loanRequirement.indexOf(value!);
          },
          label: 'Loan requirement',
          hint: 'Choose the option for loan',
          value: profileController.loanRequirement.value == -1 ? null : loanDetailsModel.loanRequirement[profileController.loanRequirement.value],
        ),
        DividerIO(
          height: 28,
        ),
        Obx(() {
          if (profileController.loanRequirement.value != -1) {
            return ProfileStepper().commonDropDown(
              item: loanDetailsModel.loanRequirement[profileController.loanRequirement.value].subProduct.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (value) {
                profileController.subProduct.value = loanDetailsModel.loanRequirement[profileController.loanRequirement.value].subProduct.indexOf(value!);
              },
              label: 'Sub product',
              hint: 'Select sub product',
              value: profileController.subProduct.value == -1 ? null : loanDetailsModel.loanRequirement[profileController.loanRequirement.value].subProduct[profileController.subProduct.value],
            );
          } else {
            return SizedBox();
          }
        }),
        DividerIO(
          height: 28,
        ),
        Obx(() {
          if (profileController.subProduct.value != -1) {
            return ProfileStepper().commonDropDown(
              item: loanDetailsModel.loanRequirement[profileController.loanRequirement.value].implementBrand.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (value) {
                profileController.brand.value = loanDetailsModel.loanRequirement[profileController.loanRequirement.value].implementBrand.indexOf(value!);
              },
              label: 'Implement brand',
              hint: 'Select brand',
              value: profileController.brand.value == -1 ? null : loanDetailsModel.loanRequirement[profileController.loanRequirement.value].implementBrand[profileController.brand.value],
            );
          } else {
            return SizedBox();
          }
        }),
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
      loanType: LoanType.FarmLoan,
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

class LoanDetailsModel {
  List<LoanSubDetailsModel> loanRequirement;

  LoanDetailsModel({
    required this.loanRequirement,
  });
}

class LoanSubDetailsModel {
  String name;
  List<String> subProduct, implementBrand;

  LoanSubDetailsModel({
    required this.name,
    required this.subProduct,
    required this.implementBrand,
  });
}
