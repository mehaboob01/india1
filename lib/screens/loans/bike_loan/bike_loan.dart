import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/bike_loan/models_model.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/screens/loans/lenders_list_others.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/model/create_loan_model.dart';
import 'package:india_one/screens/loans/personal_loan_io/personal_loan.dart';
import 'package:india_one/screens/profile/common/profile_stepper.dart';
import 'package:india_one/utils/common_appbar_icons.dart';
import 'package:india_one/widgets/common_text_search.dart';
import 'package:india_one/widgets/divider_io.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:india_one/widgets/my_stepper/another_stepper.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../connection_manager/ConnectionManagerController.dart';
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
    loanController.fetch2WheelerProducts();
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
                          heading: '2 Wheeler loan',
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
                                              _plManager.bikeLoanTitleList
                                                  .map((e) => StepperData(
                                                        title: "$e".tr,
                                                      ))
                                                  .toList(),
                                          stepperDirection: Axis.horizontal,
                                          iconWidth: 25,
                                          iconHeight: 25,
                                          inverted: true,
                                          activeBarColor: AppColors.pointsColor,
                                          activeIndex:
                                              _plManager.currentScreen.value,
                                          callBack: (i) {
                                            _plManager.currentScreen.value = i;
                                          },
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
        if (profileController.twoWheelerMakeCtrl.text.isEmpty) {
          Fluttertoast.showToast(
            msg: "Please select product!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        } else if (profileController.twoWheelerModelCtrl.text.isEmpty) {
          Fluttertoast.showToast(
            msg: "Please select model!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        } else {
          loanController.updateLoanAmount(
              amount: loanAmountEditingController.text,
              type: LoanType.BikeLoan);
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
                      Get.to(() => LendersListOthers(
                            title: '2 Wheeler Loan',
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
    Future<void> getModelList() async {
      await loanController.fetch2WheelerModels();
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DividerIO(
            height: 28,
          ),
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
          Obx(() {
            return CommonSearchTextField(
                itemList: loanController.twoWheelerMakes.toSet().toList(),
                label: 'Product',
                hintText: 'Select a Product',
                searchCtrl: profileController.twoWheelerMakeCtrl,
                inputOnChanged: (value) {
                  // profileController.twoWheelermakes.value = value!;
                  profileController.twoWheelerModelCtrl.clear();

                  getModelList();
                },
                searchHintText: 'Select a product here...',
                itemListNullError: 'Invalid Product Name');
          }),
          SizedBox(
            height: 24,
          ),
          Obx(
            () => loanController.twoWheelerModelsmodel.value.models != null
                ? CommonSearchTextField(
                    itemList: loanController.twoWheelerModelsmodel.value.models!
                        .toSet()
                        .toList(),
                    label: 'Model',
                    hintText: 'Select a Model',
                    searchCtrl: profileController.twoWheelerModelCtrl,
                    searchHintText: 'Select a product here...',
                    itemListNullError: 'Invalid Product Name')
                : SizedBox.shrink(),
          ),
        ],
      ),
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
