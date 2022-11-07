import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/personal_loan_io/pl_manager.dart';
import 'package:india_one/widgets/divider_io.dart';

import 'package:india_one/widgets/text_io.dart';

import '../../../widgets/custom_slider.dart';
import '../../../widgets/radio_dash_io.dart';

enum ButtonState { inActive, active }

class ChooseAmountIO extends StatefulWidget {
  @override
  State<ChooseAmountIO> createState() => _ChooseAmountIOState();
}

class _ChooseAmountIOState extends State<ChooseAmountIO> {
  PlManager _plManager = Get.put(PlManager());
  final GlobalKey<FormBuilderState> _loanAmountKey =
      GlobalKey<FormBuilderState>();

  double widthIs = 0, heightIs = 0;
  Rx<double> sliderValue = 100000.0.obs;
  Rx<double> minValue = 100000.0.obs;
  Rx<double> maxValue = 2000000.0.obs;

  late TextEditingController loanAmountEditingController;

  @override
  void initState() {
    loanAmountEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.white,
          actions: [
            Icon(Icons.info_outline),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 36, 0),
              child: GestureDetector(
                  onTap: () {
                    Get.offAllNamed(MRouter.homeScreen);
                  },
                  child: SvgPicture.asset(
                    "assets/images/homeInactive.svg",
                    color: AppColors.primary,
                  )),
            ),
          ],
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.chevron_left,
                color: AppColors.black,
              )),
          title: TextIO(
            'Personal loan',
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          )),
      body: SafeArea(
        child: SizedBox(
          width: widthIs,
          child: Obx(
            () => Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DividerIO(
                            height: 21,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // loan widget
                                _plManager.currentScreen ==
                                        Steps.LOAN_AMOUNT.index
                                    ? Icon(Icons.radio_button_checked,
                                        color:
                                            Color.fromRGBO(242, 100, 44, 1.0))
                                    : _plManager.currentScreen ==
                                            Steps.PERSONAL.index
                                        ? Stack(children: [
                                            Icon(Icons.circle,
                                                size: 24,
                                                color: Color.fromRGBO(
                                                    242, 100, 44, 1.0)),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8.0, top: 2),
                                              child: Text(
                                                "1",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            )
                                          ])
                                        : _plManager.currentScreen ==
                                                Steps.RESIDENTIAL.index
                                            ? Stack(children: [
                                                Icon(Icons.circle,
                                                    size: 24,
                                                    color: Color.fromRGBO(
                                                        242, 100, 44, 1.0)),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0, top: 2),
                                                  child: Text(
                                                    "1",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                )
                                              ])
                                            : Stack(children: [
                                                Icon(Icons.circle,
                                                    size: 24,
                                                    color: Color.fromRGBO(
                                                        242, 100, 44, 1.0)),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0, top: 2),
                                                  child: Text(
                                                    "1",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                )
                                              ]),
                                RadioDashIO(),

                                // personal widget
                                _plManager.currentScreen ==
                                        Steps.LOAN_AMOUNT.index
                                    ? Icon(Icons.radio_button_off,
                                        color:
                                            Color.fromRGBO(153, 153, 153, 1.0))
                                    : _plManager.currentScreen ==
                                            Steps.PERSONAL.index
                                        ? Icon(Icons.radio_button_checked,
                                            color: Color.fromRGBO(
                                                242, 100, 44, 1.0))
                                        : _plManager.currentScreen ==
                                                Steps.RESIDENTIAL.index
                                            ? Stack(children: [
                                                Icon(Icons.circle,
                                                    size: 24,
                                                    color: Color.fromRGBO(
                                                        242, 100, 44, 1.0)),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0, top: 2),
                                                  child: Text(
                                                    "2",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                )
                                              ])
                                            : Stack(children: [
                                                Icon(Icons.circle,
                                                    size: 24,
                                                    color: Color.fromRGBO(
                                                        242, 100, 44, 1.0)),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0, top: 2),
                                                  child: Text(
                                                    "2",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                )
                                              ]),
                                RadioDashIO(),

                                // residential widget
                                _plManager.currentScreen ==
                                        Steps.LOAN_AMOUNT.index
                                    ? Icon(Icons.radio_button_off,
                                        color:
                                            Color.fromRGBO(153, 153, 153, 1.0))
                                    : _plManager.currentScreen ==
                                            Steps.PERSONAL.index
                                        ? Icon(Icons.radio_button_off,
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1.0))
                                        : _plManager.currentScreen ==
                                                Steps.RESIDENTIAL.index
                                            ? Icon(Icons.radio_button_checked,
                                                color: Color.fromRGBO(
                                                    242, 100, 44, 1.0))
                                            : Stack(children: [
                                                Icon(Icons.circle,
                                                    size: 24,
                                                    color: Color.fromRGBO(
                                                        242, 100, 44, 1.0)),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0, top: 2),
                                                  child: Text(
                                                    "3",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                )
                                              ]),
                                RadioDashIO(),

                                // occupation widget
                                _plManager.currentScreen ==
                                        Steps.LOAN_AMOUNT.index
                                    ? Icon(Icons.radio_button_off,
                                        color:
                                            Color.fromRGBO(153, 153, 153, 1.0))
                                    : _plManager.currentScreen ==
                                            Steps.PERSONAL.index
                                        ? Icon(Icons.radio_button_off,
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1.0))
                                        : _plManager.currentScreen ==
                                                Steps.RESIDENTIAL.index
                                            ? Icon(Icons.radio_button_off,
                                                color: Color.fromRGBO(
                                                    153, 153, 153, 1.0))
                                            : Icon(Icons.radio_button_checked,
                                                color: Color.fromRGBO(
                                                    242, 100, 44, 1.0))
                              ],
                            ),
                          ),
                          DividerIO(),
                          Align(
                            alignment: Alignment.center,
                            child: DefaultTextStyle(
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(45, 45, 45, 1.0),
                                  fontWeight: FontWeight.bold),
                              child: Obx(
                                () => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Loan Amount',
                                      style: AppStyle.shortHeading.copyWith(
                                          fontSize: Dimens.font_12sp,
                                          color: _plManager.currentScreen ==
                                                  Steps.LOAN_AMOUNT.index
                                              ? Colors.black
                                              : AppColors.black26Color,
                                          fontWeight:
                                              _plManager.currentScreen ==
                                                      Steps.LOAN_AMOUNT.index
                                                  ? FontWeight.w600
                                                  : FontWeight.w400),
                                    ),
                                    Container(
                                      width: 14,
                                    ),
                                    Text(
                                      'Personal',
                                      style: AppStyle.shortHeading.copyWith(
                                          fontSize: Dimens.font_12sp,
                                          color: _plManager.currentScreen ==
                                                  Steps.PERSONAL.index
                                              ? Colors.black
                                              : AppColors.black26Color,
                                          fontWeight:
                                              _plManager.currentScreen ==
                                                      Steps.PERSONAL.index
                                                  ? FontWeight.w600
                                                  : FontWeight.w400),
                                    ),
                                    Container(
                                      width: 18,
                                    ),
                                    Text(
                                      'Residential',
                                      style: AppStyle.shortHeading.copyWith(
                                          fontSize: Dimens.font_12sp,
                                          color: _plManager.currentScreen ==
                                                  Steps.RESIDENTIAL.index
                                              ? Colors.black
                                              : AppColors.black26Color,
                                          fontWeight:
                                              _plManager.currentScreen ==
                                                      Steps.RESIDENTIAL.index
                                                  ? FontWeight.w600
                                                  : FontWeight.w400),
                                    ),
                                    Container(
                                      width: 12,
                                    ),
                                    Text(
                                      'Occupation',
                                      style: AppStyle.shortHeading.copyWith(
                                          fontSize: Dimens.font_12sp,
                                          color: _plManager.currentScreen ==
                                                  Steps.OCCUPATION.index
                                              ? Colors.black
                                              : AppColors.black26Color,
                                          fontWeight:
                                              _plManager.currentScreen ==
                                                      Steps.OCCUPATION.index
                                                  ? FontWeight.w600
                                                  : FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // update this ui when clicks on next button
                          _plManager.currentScreen == Steps.LOAN_AMOUNT.index
                              ? loanAmountUi()
                              : _plManager.currentScreen == Steps.PERSONAL.index
                                  ? personalInfoUi()
                                  : _plManager.currentScreen ==
                                          Steps.RESIDENTIAL.index
                                      ? residentialInfoUi()
                                      : occupationInfoUi()
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                          // go to next screen
                          onTap: () => {
                                _plManager.currentScreen ==
                                        Steps.LOAN_AMOUNT.index
                                    ? _plManager
                                        .updateScreen(Steps.PERSONAL.index)
                                    : _plManager.currentScreen ==
                                            Steps.PERSONAL.index
                                        ? _plManager.updateScreen(
                                            Steps.RESIDENTIAL.index)
                                        : _plManager.updateScreen(
                                            Steps.OCCUPATION.index)
                              },
                          child: _plManager.currentScreen ==
                                  Steps.LOAN_AMOUNT.index
                              ? loanAmountButton()
                              : _plManager.currentScreen == Steps.PERSONAL.index
                                  ? personalInfoButton()
                                  : _plManager.currentScreen ==
                                          Steps.RESIDENTIAL.index
                                      ? residentialInfoButton()
                                      : occupationButton()),
                    ))
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
        if (_loanAmountKey.currentState!.validate()) {}
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
            onTap: () => _plManager.updateScreen(Steps.RESIDENTIAL.index),
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
          child: Container(
            width: MediaQuery.of(context).size.height * 0.9,
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SUBMIT',
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
                    color: _plManager.currentScreen == Steps.LOAN_AMOUNT.index
                        ? Colors.black
                        : AppColors.black26Color,
                    fontWeight:
                        _plManager.currentScreen == Steps.LOAN_AMOUNT.index
                            ? FontWeight.w600
                            : FontWeight.w400),
              ),
              DividerIO(
                height: 24,
              ),
              Text(
                'Choose the loan amount you want from slider or enter in the text field',
                style: AppStyle.shortHeading.copyWith(
                    fontSize: Dimens.font_14sp,
                    color: _plManager.currentScreen == Steps.LOAN_AMOUNT.index
                        ? Colors.grey
                        : AppColors.black26Color,
                    fontWeight:
                        _plManager.currentScreen == Steps.LOAN_AMOUNT.index
                            ? FontWeight.w600
                            : FontWeight.w400),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 28, 0, 28),
          child: CustomSlider(
              sliderValue: sliderValue,
              textEditingController: loanAmountEditingController,
              minValue: minValue,
              maxValue: maxValue),
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
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimens.font_16sp,
                    fontWeight: FontWeight.w600),
                decoration: new InputDecoration(
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
                    borderSide:
                        BorderSide(color: Color(0xFFCDCBCB), width: 1.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderSide:
                        const BorderSide(color: Color(0xFFCDCBCB), width: 1.0),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: 'Loan amount',
                  labelStyle: new TextStyle(color: Color(0xFF787878)),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Text("Personal info"),
        ))
      ],
    );
  }

  //Residential info

  Widget residentialInfoUi() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Text("Residential info"),
        ))
      ],
    );
  }
  // Occupation info

  Widget occupationInfoUi() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Text("Occupation info"),
        ))
      ],
    );
  }
}

enum Steps { LOAN_AMOUNT, PERSONAL, RESIDENTIAL, OCCUPATION }
