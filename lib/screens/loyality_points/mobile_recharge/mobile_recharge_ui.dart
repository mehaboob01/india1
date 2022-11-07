import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:india_one/constant/extensions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../constant/theme_manager.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

import '../../../widgets/common_drop_down.dart';
import '../../../widgets/common_radio_card.dart';
import '../../onboarding_login/user_login/user_login_ui.dart';
import 'mr_manager.dart';

class MobileRechargeIO extends StatefulWidget {
  const MobileRechargeIO({Key? key}) : super(key: key);

  @override
  State<MobileRechargeIO> createState() => _MobileRechargeIOState();
}

class _MobileRechargeIOState extends State<MobileRechargeIO> {
  double widthIs = 0, heightIs = 0;

  bool? mobileNumberEnabled = false;
  bool? operatorEnabled = false;
  bool? circleEnabled = false;
  bool? planSelected = false;
  bool? cardSelectedIndex = false;

  int charLength = 0;
  List<Widget> plansList = [];
  MrManager _mrManager = Get.put(MrManager());
  List<Contact>? _contacts;
  bool _permissionDenied = false;
  final GlobalKey<FormBuilderState> _mobileRecharge =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _mobileRechargeKey =
      GlobalKey<FormBuilderState>();

  _onTextChanged(String? value) {
    setState(() {
      charLength = value!.length;
      print("char length");
      print(charLength);
      if (charLength == 12) {
        print("inside 12  : ");

        mobileNumberEnabled = true;
        _mobileRecharge.currentState!.save();
        if (circleEnabled == true &&
            operatorEnabled == true &&
            mobileNumberEnabled == true) {
          print("api called inside number : ");

          if (_mobileRecharge.currentState!.validate()) {
            var operatorId = checkOperatorId(
                _mobileRecharge.currentState!.value['operatorName']);
            var circleId = checkCircleId(
                _mobileRecharge.currentState!.value['circleName']);

            print("operator Id == >$operatorId");
            print("circle Id == >$circleId");

            if (_mobileRecharge.currentState!.validate()) {
              _mrManager.checkPlanesApi(
                  operatorId,
                  circleId,
                  _mobileRecharge.currentState!.value['mobileNumber']
                      .replaceAll(' ', ''));
            }
          }
        }
        // FocusScope.of(context).unfocus();
      } else {}
    });
  }

  @override
  void initState() {
    _fetchContacts();
    _mrManager.plansList.clear();

    super.initState();
  }

  _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
  }

  // List<bool> selectedUpiCard = List.generate(_mr,index) => false).obs;

  @override
  Widget build(BuildContext context) {
    // RxList selectedUpiCard =
    //     List.generate(_mrManager.plansList.length, (index) => false).obs;
    //
    // print(selectedUpiCard[0]);
    //
    List<bool> localSelectedList = [];
    void onCardTapped(int index) {
      print("card tapped");
      planSelected = true;
      _mrManager.selectedIndex.value = index;

      _mrManager.rechargeData.value = {
        'amount': _mrManager.plansList[index].amount,
        'planType': _mrManager.plansList[index].type
      };

      print(_mrManager.rechargeData.value);

      _mrManager.selectedplanList.value = localSelectedList;
    }

    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 36, 0),
              child: GestureDetector(
                  onTap: () {},
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
          title: Text(
            "Redeem points ",
            style: AppStyle.shortHeading.copyWith(
              fontSize: Dimens.font_14sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // user inputs
              FormBuilder(
                key: _mobileRechargeKey,
                initialValue: {
                  "mobileNumber": "",
                  "operatorName": "",
                  "circleName": ""
                },
                child: Container(
                  padding: EdgeInsets.all(9),
                  width: widthIs,
                  height: heightIs * 0.5,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 4.0, left: 8, right: 8, top: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter the following details to proceed",
                            style: AppStyle.shortHeading.copyWith(
                              fontSize: Dimens.font_16sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 34,
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                left: 4.0,
                                right: 4,
                              ),
                              child: FormBuilder(
                                key: _mobileRecharge,
                                initialValue: {
                                  "mobileNumber": "",
                                },
                                child: Column(
                                  children: [
                                    FormBuilderTextField(
                                      keyboardType: TextInputType.number,
                                      onChanged: _onTextChanged,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        new CustomInputFormatter(),
                                        LengthLimitingTextInputFormatter(12),
                                      ],
                                      style: AppStyle.shortHeading.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: Dimens.font_16sp),
                                      decoration: new InputDecoration(
                                        suffixIconConstraints: BoxConstraints(
                                            minHeight: 32, minWidth: 32),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        prefixIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, top: 4.0),
                                              child: Text(
                                                '+91 ',
                                                style: AppStyle.shortHeading
                                                    .copyWith(
                                                        color: AppColors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize:
                                                            Dimens.font_16sp),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        hintText: ' • • • •  • • •  • • •',
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.dotsColor,
                                            fontSize: Dimens.font_28sp),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFCDCBCB),
                                              width: 1.0),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderSide: const BorderSide(
                                              color: Color(0xFFCDCBCB),
                                              width: 1.0),
                                        ),
                                        labelText: 'Mobile Number',
                                        suffixIcon: GestureDetector(
                                            onTap: () async {
                                              _mrManager.contact.value =
                                                  (await FlutterContacts
                                                      .openExternalPick())!;

                                              print(
                                                  "Contact value${_mrManager.contact.value.phones}");
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: SvgPicture.asset(
                                                  AppImages.contactPickerSvg,
                                                  color: AppColors.primary),
                                            )),
                                        border: const OutlineInputBorder(),
                                        labelStyle: AppStyle.shortHeading
                                            .copyWith(
                                                color: AppColors.greyInlineText,
                                                fontWeight: FontWeight.w400,
                                                fontSize: Dimens.font_14sp),
                                      ),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                      ]),
                                      name: 'mobileNumber',
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),

                                    // Operator dropdown
                                    Obx(
                                      () => DropDown(
                                        onChanged: (value) {
                                          operatorEnabled = true;
                                          _mobileRecharge.currentState!.save();
                                          if (circleEnabled == true &&
                                              operatorEnabled == true &&
                                              mobileNumberEnabled == true) {
                                            if (_mobileRecharge.currentState!
                                                .validate()) {
                                              var operatorId = checkOperatorId(
                                                  _mobileRecharge.currentState!
                                                      .value['operatorName']);
                                              var circleId = checkCircleId(
                                                  _mobileRecharge.currentState!
                                                      .value['circleName']);

                                              print(
                                                  "operator Id == >$operatorId");
                                              print("circle Id == >$circleId");

                                              if (_mobileRecharge.currentState!
                                                  .validate()) {
                                                _mrManager.checkPlanesApi(
                                                    operatorId,
                                                    circleId,
                                                    _mobileRecharge
                                                        .currentState!
                                                        .value['mobileNumber']
                                                        .replaceAll(' ', ''));
                                              }
                                            }
                                          }
                                        },
                                        data: _mrManager.operatorListString
                                            .toList(),
                                        hintText: 'Choose the Operator',
                                        labelName: 'Operator',
                                        validationText:
                                            '*Operator is mandatory here ',
                                        formName: 'operatorName',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    // Circle dropdown
                                    Obx(
                                      () => DropDown(
                                        onChanged: (value) {
                                          circleEnabled = true;
                                          _mobileRecharge.currentState!.save();
                                          // _mobileRecharge.currentState!
                                          //     .validate();
                                          if (circleEnabled == true &&
                                              operatorEnabled == true &&
                                              mobileNumberEnabled == true) {
                                            print("circle api call");

                                            var operatorId = checkOperatorId(
                                                _mobileRecharge.currentState!
                                                    .value['operatorName']);
                                            var circleId = checkCircleId(
                                                _mobileRecharge.currentState!
                                                    .value['circleName']);

                                            print(
                                                "operator Id == >$operatorId");
                                            print("circle Id == >$circleId");

                                            if (_mobileRecharge.currentState!
                                                .validate()) {
                                              _mrManager.checkPlanesApi(
                                                  operatorId,
                                                  circleId,
                                                  _mobileRecharge.currentState!
                                                      .value['mobileNumber']
                                                      .replaceAll(' ', ''));
                                            }
                                          }
                                        },
                                        data: _mrManager.circleListString
                                            .toList(),
                                        hintText: 'Choose your state',
                                        labelName: 'Circle',
                                        validationText: '*DD error state here',
                                        formName: 'circleName',
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // my code list
              // recharge plans

              Obx(
                () => Visibility(
                  visible:
                      _mrManager.isPlansAvailable.value == true ? true : false,
                  child:

                  Obx(
                    () => _mrManager.isLoading.value == true
                        ? Container(
                            width: widthIs,
                            height: heightIs * 0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: LoadingAnimationWidget.inkDrop(
                                    size: 34,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text('Fetching plans ...',
                                    style: AppStyle.shortHeading.copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          )
                        : _mrManager.plansList.length == 0
                            ? Center(
                                child: Container(
                                    width: widthIs * 0.9,
                                    height: heightIs * 0.3,
                                    child: Center(child: Text("No Plans"))))
                            : Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Obx(
                                  () => Container(
                                      width: widthIs * 0.9,
                                      height: heightIs * 0.3,
                                      child: ListView.builder(
                                          itemCount:
                                              _mrManager.plansList.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Container(
                                                  child: GestureDetector(
                                                    onTap: () => {
                                                      if (_mrManager
                                                          .plansList.isNotEmpty)
                                                        {onCardTapped(index)}
                                                    },
                                                    child: Obx(
                                                      () => CommonRadioCard(
                                                        radioCardType:
                                                            RadioCardType
                                                                .rechargePlan,
                                                        rechargePlanAmount:
                                                            _mrManager
                                                                .plansList[
                                                                    index]
                                                                .amount
                                                                .toString(),
                                                        rechargePlanValidity:
                                                            _mrManager
                                                                .plansList[
                                                                    index]
                                                                .validity
                                                                .toString(),
                                                        rechargePlanData:
                                                            _mrManager
                                                                .plansList[
                                                                    index]
                                                                .description,
                                                        isSelected: index ==
                                                            _mrManager
                                                                .selectedIndex
                                                                .value,
                                                        cardWidth:
                                                            double.maxFinite,
                                                      ),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColors
                                                            .cardScreenBg),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1.0.wp),
                                                  )),
                                            );
                                          }),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.cardScreenBg),
                                        borderRadius:
                                            BorderRadius.circular(2.0.wp),
                                      )),
                                ),
                              ),
                  ),
                ),
              ),
              // chirag code

              SizedBox(
                height: 48,
              ),

              Align(
                child: Container(
                  child: rechargeButton(context),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 48,
                ),
                alignment: Alignment.bottomCenter,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget rechargeButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("onTap");

        _mobileRecharge.currentState!.save();
        _mobileRecharge.currentState!.validate();
        if (_mobileRecharge.currentState!.validate()) {
          var operatorId = checkOperatorId(
              _mobileRecharge.currentState!.value['operatorName']);
          var circleId =
              checkCircleId(_mobileRecharge.currentState!.value['circleName']);

          print(operatorId);
          print(circleId);
          print(_mobileRecharge.currentState!.value['mobileNumber']
              .replaceAll(' ', ''));
          print(_mrManager.rechargeData);

          _mrManager.mobileRechargeApi(
              int.parse(operatorId.toString()),
              int.parse(circleId.toString()),
              _mobileRecharge.currentState!.value['mobileNumber']
                  .replaceAll(' ', ''),
              _mrManager.rechargeData,
              context);
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
                  'Recharge Now',
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
          gradient: mobileNumberEnabled == true &&
                  circleEnabled == true &&
                  operatorEnabled == true &&
                  planSelected == true
              ? LinearGradient(
                  end: Alignment.topRight,
                  colors: [Colors.orange, Colors.redAccent],
                )
              : LinearGradient(
                  end: Alignment.topRight,
                  colors: [
                    AppColors.btnDisableColor,
                    AppColors.btnDisableColor
                  ],
                ),
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
  }

  String? checkOperatorId(operatorName) {
    for (var index in _mrManager.operatorList) {
      if (index.name == operatorName) {
        return index.id;
      }
    }
  }

  String? checkCircleId(circleName) {
    for (var index in _mrManager.circleList) {
      if (index.name == circleName) {
        return index.id;
      }
    }
  }
}
