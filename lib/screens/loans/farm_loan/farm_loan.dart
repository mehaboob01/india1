import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/model/farm_loan_product_model.dart';
import 'package:india_one/screens/loans/model/farm_loan_requirment_model.dart';
import 'package:india_one/screens/loans/personal_loan_io/personal_loan.dart';
import 'package:india_one/screens/profile/common/profile_stepper.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';
import 'package:india_one/utils/common_appbar_icons.dart';
import 'package:india_one/widgets/common_text_search.dart';
import 'package:india_one/widgets/divider_io.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:india_one/widgets/my_stepper/another_stepper.dart';

import '../../../connection_manager/ConnectionManagerController.dart';

class FarmLoan extends StatefulWidget {
  const FarmLoan({Key? key}) : super(key: key);

  @override
  State<FarmLoan> createState() => _FarmLoanState();
}

class _FarmLoanState extends State<FarmLoan> {
  // final GlobalKey<FormBuilderState> _loanAmountKey =
  //     GlobalKey<FormBuilderState>();

  double widthIs = 0, heightIs = 0;

  late TextEditingController loanAmountEditingController;
  ProfileController profileController = Get.put(ProfileController());
  LoanController loanController = Get.put(LoanController());

  /*LoanDetailsModel loanDetailsModel = LoanDetailsModel(loanRequirement: [
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
*/

  @override
  void initState() {
    loanAmountEditingController = TextEditingController();
    super.initState();

    loanController.currentScreen.value = Steps.LOAN_AMOUNT.index;
    loanController.sliderValue.value = loanController.minValue.value;
    resetValues();
    profileController.setData();
    loanController.createLoanApplication(loanType: LoanType.FarmLoan);
  }

  void resetValues() {
    profileController.farmLoanReqCtrl.clear();
    profileController.loanRequirement.value = -1;
    profileController.farmSubproductCtrl.clear();
    profileController.subProduct.value = -1;
    profileController.farmBrand.clear();
    profileController.brand.value = -1;
    loanController.farmLoanProductModel.value = FarmLoanProductModel();
  }

  GlobalKey<FormState> personalForm = GlobalKey<FormState>();
  GlobalKey<FormState> residentialForm = GlobalKey<FormState>();

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
                () => Column(
                  children: [
                    CustomAppBar(
                        heading: 'Farm loan',
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
                                      stepperList:
                                          loanController.farmLoanTitleList
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
                                        print("find me");
                                        if (i <=
                                            loanController
                                                .farmCompletedIndex.value) {
                                          loanController.currentScreen.value =
                                              i;
                                        }
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
      onTap: () async {
        String? msg;
        if (profileController.farmLoanReqCtrl.value.text.isEmpty) {
          msg = "Select loan requirement";
        } else if (profileController.farmSubproductCtrl.value.text.isEmpty &&
            loanController.farmLoanProductModel.value.subProducts != null) {
          msg = "Select sub product";
        } else if (profileController.farmBrand.value.text.isEmpty &&
            loanController.farmLoanProductModel.value.brands != null) {
          msg = "Select brand";
        }

        if (msg != null) {
          // Flushbar(
          //   title: "Alert!",
          //   message: msg,
          //   duration: Duration(seconds: 3),
          // )..show(context);
          Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        } else {
          if (await loanController.updateFarmLoanDetails()) {
            if (loanController.farmCompletedIndex.value <
                Steps.PERSONAL.index) {
              loanController.farmCompletedIndex.value = Steps.PERSONAL.index;
            }

            loanController.updateScreen(Steps.PERSONAL.index);
          } else {
            Flushbar(
              title: "Alert!",
              message: "Something went wrong!",
              duration: Duration(seconds: 3),
            )..show(context);
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
                text(
                  'NEXT',
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
    );
  }

  // PERSONAL INFO BUTTON
  Widget personalInfoButton() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => loanController.updateScreen(Steps.LOAN_AMOUNT.index),
            child: Container(
              width: MediaQuery.of(context).size.height * 0.9,
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text(
                    'BACK',
                    style: AppTextThemes.button,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.topRight,
                  colors: [Color(0xFF357CBE), Color(0xFF004280)],
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
                // Flushbar(
                //   title: "Alert!",
                //   message: "missing some values",
                //   duration: Duration(seconds: 3),
                // )..show(context);
                Fluttertoast.showToast(
                  msg: "missing some values",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  fontSize: 16.0,
                );
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
                    loanApplicationId:
                        loanController.createLoanModel.value.loanApplicationId,
                    callBack: () {
                      if (loanController.farmCompletedIndex.value <
                          Steps.RESIDENTIAL.index) {
                        loanController.farmCompletedIndex.value =
                            Steps.RESIDENTIAL.index;
                      }
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
                  text(
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

  // Widget residentialInfoButton() {
  //   return InkWell(
  //     onTap: () {
  //       profileController.autoValidation.value = true;
  //       if (!residentialForm.currentState!.validate()) {
  //         Flushbar(
  //           title: "Alert!",
  //           message: "missing some values",
  //           duration: Duration(seconds: 3),
  //         )..show(context);
  //       } else if (profileController.city.value == '') {
  //         Flushbar(
  //           title: "Alert!",
  //           message: "Enter valid pincode for city",
  //           duration: Duration(seconds: 3),
  //         )..show(context);
  //       } else if (profileController.state.value == '') {
  //         Flushbar(
  //           title: "Alert!",
  //           message: "Enter valid pincode for state",
  //           duration: Duration(seconds: 3),
  //         )..show(context);
  //       } else {
  //         profileController.addResidentialDetails(
  //             isFromLoan: true,
  //             loanApplicationId:
  //                 loanController.createLoanModel.value.loanApplicationId,
  //             callBack: () {
  //               // Get.to(() => LendersList(
  //               //       title: 'Farm loan',
  //               //     ));
  //
  //               LoanCommon().bottomSheet(
  //                 context,
  //                 lenderId: "lenders.id ?? ''",
  //                 callBack: () {
  //                   // Get.off(() => LendersList(
  //                   //           title: 'Farm loan',
  //                   //         ));
  //                   loanController.applyLoan(
  //                     providerId: '',
  //                     lenderId: '',
  //                   );
  //                 },
  //                 providerId: '',
  //               );
  //             });
  //       }
  //     },
  //     child: Container(
  //       width: MediaQuery.of(context).size.height * 0.9,
  //       height: 48,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Spacer(),
  //           Row(
  //             children: [
  //               text(
  //                 'NEXT',
  //                 style: AppTextThemes.button,
  //               ),
  //               SizedBox(
  //                 width: 6,
  //               ),
  //             ],
  //           ),
  //           Spacer(),
  //           // SizedBox(
  //           //   height: 48,
  //           //   child: Image.asset(
  //           //     "assets/images/btn_img.png",
  //           //     fit: BoxFit.fill,
  //           //   ),
  //           // ),
  //         ],
  //       ),
  //       decoration: BoxDecoration(
  //         gradient: new LinearGradient(
  //           end: Alignment.topRight,
  //           colors: [Colors.orange, Colors.redAccent],
  //         ),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.white.withOpacity(0.8),
  //             offset: Offset(
  //               -6.0,
  //               -6.0,
  //             ),
  //             blurRadius: 16.0,
  //           ),
  //           BoxShadow(
  //             color: AppColors.darkerGrey.withOpacity(0.4),
  //             offset: Offset(6.0, 6.0),
  //             blurRadius: 16.0,
  //           ),
  //         ],
  //         // color: termConditionChecked == true
  //         //     ? AppColors.btnColor
  //         //     : AppColors.btnDisableColor,
  //         borderRadius: BorderRadius.circular(6.0),
  //       ),
  //     ),
  //   );
  // }

  Widget residentialInfoButton() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () =>
                loanController.updateScreen(Steps.LOAN_AMOUNT.index + 1),
            child: Container(
              width: MediaQuery.of(context).size.height * 0.9,
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text(
                    'BACK',
                    style: AppTextThemes.button,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.topRight,
                  colors: [Color(0xFF357CBE), Color(0xFF004280)],
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
                      // Get.to(() => LendersList(
                      //       title: 'Farm loan',
                      //     ));

                      LoanCommon().bottomSheet(
                        context,
                        lenderId: "lenders.id ?? ''",
                        callBack: () {
                          // Get.off(() => LendersList(
                          //           title: 'Farm loan',
                          //         ));
                          loanController.applyLoan(
                            providerId: '',
                            lenderId: '',
                          );
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
                  Spacer(),
                  Row(
                    children: [
                      text(
                        'NEXT',
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
  }

  // SCREENS UI FOR DIFFERENT STEPS

  Widget loanAmountUi() {
    return Obx(() {
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
                  'Loan details',
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
                  'Choose the product against which you want the loan',
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
          // Container(
          //   margin: EdgeInsets.fromLTRB(0, 28, 0, 28),
          //   child: CustomSlider(
          //     sliderValue: loanController.sliderValue,
          //     textEditingController: loanAmountEditingController,
          //     minValue: loanController.minValue,
          //     maxValue: loanController.maxValue,
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
          //               text("₹", style: TextStyle(color: Colors.black,
          //                   fontSize: Dimens.font_16sp,
          //                   fontWeight: FontWeight.w600)),
          //             ],
          //           ),
          //           focusedBorder: const OutlineInputBorder(
          //             borderSide: BorderSide(
          //                 color: Colors.blue, width: 1.0),
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
          //           if (newVal >= loanController.minValue.value &&
          //               newVal <= loanController.maxValue.value) {
          //             loanController.sliderValue.value = newVal;
          //           } else {
          //             loanController.sliderValue.value = loanController.minValue.value;
          //           }
          //         },
          //         name: 'loan_amount',
          //       ),
          //     )),
          DividerIO(
            height: 28,
          ),
          CommonSearchTextField(
              itemList:
                  loanController.loanRequirements.map((e) => e.name).toList(),
              label: 'Loan requirement',
              hintText: 'Choose the option for loan',
              searchCtrl: profileController.farmLoanReqCtrl,
              inputOnChanged: (value) {
                FarmLoanRequirementModel model = loanController.loanRequirements
                    .firstWhere((element) =>
                        element.name ==
                        profileController.farmLoanReqCtrl.value.text);

                int index = loanController.loanRequirements.indexOf(model);
                loanController.fetchFarmLoanProducts(
                    requirementId: loanController.loanRequirements[index].key);
                // if (value == "Implement finance") {

                // }
              },
              searchHintText: 'Search your Loan Requirment',
              itemListNullError: 'Invalid Loan Requirment Value'),
          DividerIO(
            height: 28,
          ),
          // ProfileStepper().commonDropDown(
          //   item: loanController.loanRequirements
          //       .map<DropdownMenuItem<FarmLoanRequirementModel>>(
          //           (FarmLoanRequirementModel value) {
          //     return DropdownMenuItem<FarmLoanRequirementModel>(
          //       value: value,
          //       child: text(value.name.toString()),
          //     );
          //   }).toList(),
          //   onChanged: (value) {
          //     // profileController.loanRequirement.value = value.name;
          //     // profileController.loanRequirement.value =
          //     //     loanController.loanRequirements.indexOf(value!);
          //     // loanController.fetchFarmLoanProducts(
          //     //     requirementId: loanController
          //     //         .loanRequirements[profileController.loanRequirement.value]
          //     //         .key);
          //   },
          //   label: 'Loan requirement',
          //   hint: 'Choose the option for loan',
          //   value: profileController.loanRequirement.value == -1
          //       ? null
          //       : loanController
          //           .loanRequirements[profileController.loanRequirement.value],
          // ),
          // DividerIO(
          //   height: 28,
          // ),

          loanController.farmLoanProductModel.value.subProducts == null &&
                  profileController.farmLoanReqCtrl.value.text !=
                      'Implement finance'
              ? SizedBox.shrink()
              : CommonSearchTextField(
                  itemList:
                      loanController.farmLoanProductModel.value.subProducts!,
                  label: 'Sub Product',
                  hintText: 'Select a Sub Product',
                  searchCtrl: profileController.farmBrand,
                  searchHintText: 'Search Sub Product ...',
                  itemListNullError: 'Invalid Sub Product',
                ),
          // Obx(
          //   () {
          //     if (
          //         // profileController.loanRequirement.value != -1 &&
          //         loanController.farmLoanProductModel.value.subProducts != null) {
          //       return ProfileStepper().commonDropDown(
          //         item: loanController.farmLoanProductModel.value.subProducts!
          //             .map<DropdownMenuItem<String>>((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: text(value.toString()),
          //           );
          //         }).toList(),
          //         onChanged: (value) {
          //           profileController.subProduct.value = loanController
          //               .farmLoanProductModel.value.subProducts!
          //               .indexOf(value!);
          //         },
          //         label: 'Sub product',
          //         hint: 'Select sub product',
          //         value: profileController.subProduct.value == -1
          //             ? null
          //             : loanController.farmLoanProductModel.value
          //                 .subProducts![profileController.subProduct.value],
          //       );
          //     } else {
          //       return SizedBox();
          //     }
          //   },
          // ),
          DividerIO(
            height: 28,
          ),
          loanController.farmLoanProductModel.value.brands == null &&
                  profileController.farmLoanReqCtrl.value.text !=
                      'Implement finance'
              ? SizedBox.shrink()
              : CommonSearchTextField(
                  itemList: loanController.farmLoanProductModel.value.brands!,
                  label: 'Implement Brand',
                  hintText: 'Select a Brand',
                  searchCtrl: profileController.farmSubproductCtrl,
                  searchHintText: 'Search Sub Product ...',
                  itemListNullError: 'Invalid Sub Product',
                ),
          // Obx(() {
          //   if (loanController.farmLoanProductModel.value.brands != null) {
          //     return ProfileStepper().commonDropDown(
          //       item: loanController.farmLoanProductModel.value.brands!
          //           .map<DropdownMenuItem<String>>((String value) {
          //         return DropdownMenuItem<String>(
          //           value: value,
          //           child: text(value.toString()),
          //         );
          //       }).toList(),
          //       onChanged: (value) {
          //         profileController.brand.value = loanController
          //             .farmLoanProductModel.value.brands!
          //             .indexOf(value!);
          //       },
          //       label: 'Implement brand',
          //       hint: 'Select brand',
          //       value: profileController.brand.value == -1
          //           ? null
          //           : loanController.farmLoanProductModel.value
          //               .brands![profileController.brand.value],
          //     );
          //   } else {
          //     return SizedBox();
          //   }
          // }),
          SizedBox(
            height: 54,
          )
        ],
      );
    });
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
      loanType: LoanType.FarmLoan,
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
