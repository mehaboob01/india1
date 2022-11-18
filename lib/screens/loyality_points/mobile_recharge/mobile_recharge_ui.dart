import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:india_one/constant/routes.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../constant/theme_manager.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import '../../../widgets/common_drop_down.dart';
import '../../../widgets/common_radio_card.dart';
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

  var mobileNumberController = TextEditingController();

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
        planSelected = false;
        FocusScope.of(context).unfocus();
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



            if (_mobileRecharge.currentState!.validate()) {


              _mrManager.checkPlanesApi(
                  operatorId,
                  circleId,
                  _mobileRecharge.currentState!.value['mobileNumber']
                      .replaceAll(' ', ''));
            }
          }
        }
      } else {
        mobileNumberEnabled = false;

      }
    });
  }

  @override
  void initState() {
   // _fetchContacts();

    _mrManager.plansList.clear();
    _mrManager.selectedIndex.value = (-1);

    super.initState();
  }

  fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
      // final contacts = await FlutterContacts.getContacts();
      // setState(() => _contacts = contacts);
    } else if (!await FlutterContacts.requestPermission(readonly: false)) {
      setState(() => _permissionDenied = false);
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    List<bool> localSelectedList = [];
    void onCardTapped(int index) {
      planSelected = true;
      setState(() {});
      _mrManager.selectedIndex.value = index;
      _mrManager.rechargeData.value = {
        'amount': _mrManager.plansList[index].amount,
        'planType': _mrManager.plansList[index].type
      };

      _mrManager.selectedplanList.value = localSelectedList;
    }

    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
            elevation: 2,
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(MRouter.homeScreen, (Route route) => false);
                    },
                    child: Container(
                      child: SvgPicture.asset(
                        "assets/images/homeInactive.svg",
                        color: AppColors.primary,
                      ),
                    )),
              ),
            ],
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.chevron_left,
                  color: AppColors.black,
                )),
            title: Text(
              "Redeem points ",
              style: AppStyle.shortHeading.copyWith(
                fontSize: Dimens.font_16sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            )),
        body:
            _mrManager.isMobileRechargeLoading == true ||
                    _mrManager.isLoading == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: LoadingAnimationWidget.inkDrop(
                          size: 36,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text('Loading ...',
                          style: AppStyle.shortHeading.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400))
                    ],
                  )
                : Stack(children: [
                    Container(
                      height: heightIs,
                      width: widthIs,
                      child: SafeArea(
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
                                child: SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.all(9),
                                    width: widthIs,
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 4.0,
                                            left: 8,
                                            right: 8,
                                            top: 24),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Enter the following details to proceed",
                                              style: AppStyle.shortHeading
                                                  .copyWith(
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
                                                        controller:
                                                            mobileNumberController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged:
                                                            _onTextChanged,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                          new CustomInputFormatter(),
                                                          LengthLimitingTextInputFormatter(
                                                              12),
                                                        ],
                                                        style: AppStyle.shortHeading
                                                            .copyWith(
                                                                color: AppColors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: Dimens
                                                                    .font_16sp),
                                                        decoration:
                                                            new InputDecoration(
                                                          labelStyle: AppStyle
                                                              .shortHeading
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .greyText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      12.0.sp),
                                                          suffixIconConstraints:
                                                              BoxConstraints(
                                                                  minHeight: 32,
                                                                  minWidth: 32),
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .always,
                                                          prefixIcon: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            8.0,
                                                                        top:
                                                                            4.0),
                                                                child: Text(
                                                                  '+91 ',
                                                                  style: AppStyle.shortHeading.copyWith(
                                                                      color: AppColors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          Dimens
                                                                              .font_16sp),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          hintText:
                                                              ' • • • •  • • •  • • •',
                                                          hintStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColors
                                                                  .dotsColor,
                                                              fontSize: Dimens
                                                                  .font_28sp),
                                                          focusedBorder:
                                                              const OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: AppColors
                                                                    .primary,
                                                                width: 1.0),
                                                          ),
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            // width: 0.0 produces a thin "hairline" border
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Color(
                                                                        0xFFCDCBCB),
                                                                    width: 1.0),
                                                          ),
                                                          labelText:
                                                              'Mobile Number',
                                                          suffixIcon:
                                                              GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                        await fetchContacts();
                                                                    if (!_permissionDenied) {


                                                                      _mrManager
                                                                              .contact
                                                                              .value =
                                                                          (await FlutterContacts
                                                                              .openExternalPick())!;

                                                                      var data = _mrManager
                                                                          .contact
                                                                          .value
                                                                          .phones
                                                                          .first
                                                                          .number
                                                                          .replaceAll(
                                                                              ' ',
                                                                              '')
                                                                          .replaceAll(
                                                                              '-',
                                                                              '')
                                                                          .replaceAll(
                                                                              '(',
                                                                              '')
                                                                          .replaceAll(
                                                                              ')',
                                                                              '');
                                                                      String?
                                                                          mobileno =
                                                                          '';
                                                                      var buffer =
                                                                          new StringBuffer();
                                                                      if (data
                                                                          .isNotEmpty) {
                                                                        print(
                                                                            "phone number length${data.length}");
                                                                        if (data.length ==
                                                                            13) {
                                                                          mobileno =
                                                                              data.substring(3);
                                                                        } else {
                                                                          mobileno =
                                                                              data;
                                                                        }

                                                                        for (int i =
                                                                                0;
                                                                            i < mobileno!.length;
                                                                            i++) {
                                                                          buffer
                                                                              .write(mobileno![i]);
                                                                          var nonZeroIndex =
                                                                              i + 1;
                                                                          if (nonZeroIndex % 4 == 0 &&
                                                                              nonZeroIndex != mobileno!.length) {
                                                                            buffer.write(' ');
                                                                          }
                                                                        }
                                                                        var autoSelectNumber =
                                                                            buffer.toString();
                                                                        mobileno =
                                                                            autoSelectNumber;
                                                                        mobileno =
                                                                            mobileno.toString() +
                                                                                ' ';
                                                                        mobileNumberController.text =
                                                                            mobileno.trim();
                                                                        print(
                                                                            "Size==> ${mobileNumberController.text.length}");
                                                                      }

                                                                     // fetchContacts();
                                                                    } else {
                                                                      setState(() {
                                                                        _permissionDenied= false;
                                                                      });
                                                                     // fetchContacts();

                                                                      // Flushbar(
                                                                      //  onTap: fetchContacts(),
                                                                      //   mainButton: ButtonBar(
                                                                      //
                                                                      //     children: [
                                                                      //       Text(
                                                                      //         "Retry",
                                                                      //         style: TextStyle(color: Colors.white),
                                                                      //       )
                                                                      //     ],
                                                                      //   ),
                                                                      //   backgroundColor: Colors.black,
                                                                      //   title: "Alert!",
                                                                      //   message: "Contact permssion required..",
                                                                      //   messageSize: 17,
                                                                      //   //duration: Duration(seconds: 4),
                                                                      // )..show(context);
                                                                    }
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            8.0),
                                                                    child: SvgPicture.asset(
                                                                        AppImages
                                                                            .contactPickerSvg,
                                                                        color: AppColors
                                                                            .primary),
                                                                  )),
                                                          border:
                                                              const OutlineInputBorder(),
                                                        ),
                                                        validator:
                                                            FormBuilderValidators
                                                                .compose([
                                                          FormBuilderValidators
                                                              .required(
                                                                  context),
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
                                                            planSelected = false;

                                                            operatorEnabled =
                                                                true;
                                                            _mobileRecharge
                                                                .currentState!
                                                                .save();
                                                            if (circleEnabled == true &&
                                                                operatorEnabled ==
                                                                    true &&
                                                                mobileNumberEnabled ==
                                                                    true) {
                                                              if (_mobileRecharge
                                                                  .currentState!
                                                                  .validate()) {
                                                                var operatorId =
                                                                    checkOperatorId(_mobileRecharge
                                                                        .currentState!
                                                                        .value['operatorName']);
                                                                var circleId = checkCircleId(
                                                                    _mobileRecharge
                                                                        .currentState!
                                                                        .value['circleName']);

                                                                print(
                                                                    "operator Id == >$operatorId");
                                                                print(
                                                                    "circle Id == >$circleId");

                                                                if (_mobileRecharge
                                                                    .currentState!
                                                                    .validate()) {
                                                                  _mrManager.checkPlanesApi(
                                                                      operatorId,
                                                                      circleId,
                                                                      _mobileRecharge
                                                                          .currentState!
                                                                          .value[
                                                                              'mobileNumber']
                                                                          .replaceAll(
                                                                              ' ',
                                                                              ''));
                                                                }
                                                              }
                                                            }
                                                          },
                                                          data: _mrManager
                                                              .operatorListString
                                                              .toList(),
                                                          hintText:
                                                              'Choose the Operator',
                                                          labelName: 'Operator',
                                                          validationText:
                                                              '*Operator is mandatory here ',
                                                          formName:
                                                              'operatorName',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 24,
                                                      ),
                                                      // Circle dropdown
                                                      Obx(
                                                        () => DropDown(
                                                          onChanged: (value) {
                                                            planSelected = false;


                                                            circleEnabled =
                                                                true;
                                                            _mobileRecharge
                                                                .currentState!
                                                                .save();
                                                            // _mobileRecharge.currentState!
                                                            //     .validate();
                                                            if (circleEnabled == true &&
                                                                operatorEnabled ==
                                                                    true &&
                                                                mobileNumberEnabled ==
                                                                    true) {
                                                              print(
                                                                  "circle api call");

                                                              var operatorId = checkOperatorId(
                                                                  _mobileRecharge
                                                                          .currentState!
                                                                          .value[
                                                                      'operatorName']);
                                                              var circleId = checkCircleId(
                                                                  _mobileRecharge
                                                                          .currentState!
                                                                          .value[
                                                                      'circleName']);

                                                              if (_mobileRecharge
                                                                  .currentState!
                                                                  .validate()) {
                                                                _mrManager.checkPlanesApi(
                                                                    operatorId,
                                                                    circleId,
                                                                    _mobileRecharge
                                                                        .currentState!
                                                                        .value[
                                                                            'mobileNumber']
                                                                        .replaceAll(
                                                                            ' ',
                                                                            ''));
                                                              }
                                                            }
                                                          },
                                                          data: _mrManager
                                                              .circleListString
                                                              .toList(),
                                                          hintText:
                                                              'Choose your state',
                                                          labelName: 'Circle',
                                                          validationText:
                                                              '*DD error state here',
                                                          formName:
                                                              'circleName',
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
                              ),

                              SizedBox(
                                height: 12,
                              ),

                              Obx(
                                () => Visibility(
                                  visible:
                                      _mrManager.isPlansAvailable.value == true
                                          ? true
                                          : true,
                                  child: Obx(
                                    () => _mrManager.isFetchPlanLoading.value ==
                                            true
                                        ? Container(
                                            width: widthIs,
                                            height: heightIs * 0.3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: LoadingAnimationWidget
                                                      .inkDrop(
                                                    size: 34,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text('Fetching plans ...',
                                                    style: AppStyle.shortHeading
                                                        .copyWith(
                                                            color:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))
                                              ],
                                            ),
                                          )
                                        : _mrManager.plansList.length == 0
                                            ? Center(
                                                child: Container(
                                                    width: widthIs * 0.9,
                                                    height: heightIs * 0.3,
                                                    child: Center(
                                                        child: Text(""))))
                                            : Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.0, right: 8.0),
                                                child: Obx(
                                                  () => Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 20.0,
                                                                right: 20.0),
                                                        child: Divider(
                                                            thickness: 1),
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .centerStart,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 22.0),
                                                          child: Text(
                                                            "Plans under ₹ 52",
                                                            style: AppStyle
                                                                .shortHeading
                                                                .copyWith(
                                                              fontSize: Dimens
                                                                  .font_16sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      Container(
                                                          width: widthIs * 0.9,
                                                          height:
                                                              heightIs * 0.4,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount:
                                                                      _mrManager
                                                                          .plansList
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              4.0),
                                                                      child: Container(
                                                                          child: GestureDetector(
                                                                            onTap: () =>
                                                                                {
                                                                              if (_mrManager.plansList.isNotEmpty)
                                                                                {
                                                                                  onCardTapped(index)
                                                                                }
                                                                            },
                                                                            child:
                                                                                Obx(
                                                                              () => CommonRadioCard(
                                                                                radioCardType: RadioCardType.rechargePlan,
                                                                                rechargePlanAmount: _mrManager.plansList[index].amount.toString(),
                                                                                rechargePlanValidity: _mrManager.plansList[index].validity.toString(),
                                                                                rechargePlanData: _mrManager.plansList[index].description,
                                                                                isSelected: index == _mrManager.selectedIndex.value,
                                                                                cardWidth: double.maxFinite,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          decoration: BoxDecoration(
                                                                            border:
                                                                                Border.all(color: AppColors.cardScreenBg),
                                                                            borderRadius:
                                                                                BorderRadius.circular(1.0.wp),
                                                                          )),
                                                                    );
                                                                  }),
                                                          decoration:
                                                              BoxDecoration(
                                                            // border: Border.all(
                                                            //     color: AppColors.cardScreenBg),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2.0.wp),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                  ),
                                ),
                              ),
                              // chirag code
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: widthIs * 0.9,
                        margin: const EdgeInsets.all(5),
                        child: rechargeButton(context),
                      ),
                    )

                    // Align(
                    //   child: Container(
                    //     child: rechargeButton(context),
                    //     width: MediaQuery.of(context).size.width * 0.9,
                    //     height: 48,
                    //   ),
                    //   alignment: Alignment.bottomCenter,
                    // ),
                    ,
                    SizedBox(
                      height: 16,
                    ),
                  ]),
      ),
    );
  }

  Widget rechargeButton(BuildContext context) {
    return GestureDetector(
      onTap: () {



        if(mobileNumberEnabled == true &&
            circleEnabled == true &&
            operatorEnabled == true &&
            planSelected == true)

          {
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

              if (_mobileRecharge.currentState!.value != {}) {


                _mrManager.mobileRechargeApi(
                    int.parse(operatorId.toString()),
                    int.parse(circleId.toString()),
                    _mobileRecharge.currentState!.value['mobileNumber']
                        .replaceAll(' ', ''),
                    _mrManager.rechargeData,
                    context);
                circleEnabled = false;
                planSelected = false;
                operatorEnabled = false;
                _mrManager.selectedIndex.value = (-1);

                return;
              }
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

  int? checkOperatorId(operatorName) {
    for (var index in _mrManager.operatorList) {
      if (index.name == operatorName) {
        return int.parse(index.id.toString());
      }
    }
  }

  int? checkCircleId(circleName) {
    for (var index in _mrManager.circleList) {
      if (index.name == circleName) {
        return int.parse(index.id.toString());
      }
    }
  }
}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
