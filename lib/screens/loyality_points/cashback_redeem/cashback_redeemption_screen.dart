import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:india_one/screens/loyality_points/cashback_redeem/your_accounts_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../constant/theme_manager.dart';
import '../../../utils/comman_validaters.dart';
import '../../../widgets/button_with_flower.dart';
import '../../../widgets/common_divider.dart';
import '../../../widgets/common_drop_down.dart';
import '../../../widgets/common_radio_card.dart';
import '../../../widgets/common_redeem_card.dart';
import '../../../widgets/common_textfield.dart';
import '../../../widgets/common_toggle_card.dart';
import '../../../widgets/custom_slider.dart';
import '../../../widgets/loyalty_common_header.dart';
import '../../bank_manage_edit_screen.dart/manage_accounts_screen.dart';
import '../loyality_manager.dart';
import '../redeem_points/rp_manager.dart';
import 'cb_manager.dart';

class CashBackRedeemPage extends StatefulWidget {
  @override
  State<CashBackRedeemPage> createState() => _CashBackRedeemPageState();
}

class _CashBackRedeemPageState extends State<CashBackRedeemPage> {
  static bool cardTapped = false;
  final cashbackCtrl = Get.put(CashBackController());

  final List<bool> isSelectedRedeemMode = [true, false].obs;

  final Rx<double> loyaltyBankSliderValue = 0.0.obs;

  final Rx<double> loyaltyBankMinValue = 0.0.obs;

  Rx<double> loyaltyBankMaxValue = 0.0.obs;

  final Rx<double> loyaltyUpiVpaSliderValue = 0.0.obs;

  final Rx<double> loyaltyUpiVpaMinValue = 0.0.obs;

  final Rx<double> loyaltyUpiVpaMaxValue = 0.0.obs;

  CashBackManager cashBackManager = Get.put(CashBackManager());
  LoyaltyManager _loyaltyManager = Get.put(LoyaltyManager());

  String? checkBankId(bankName) {
    for (var index in cashBackManager.bankListId) {
      if (index.name == bankName) {
        return index.id;
      }
    }
  }

  // check bank id for customer banks lists

  String? checkBankAccountIdFromCustomerList(bankName) {
    for (var index in cashBackManager.customerBankList) {
      if (index.name == bankName) {
        return index.id;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    cashbackCtrl.onInit();
    cashBackManager.fetchCustomerBankAccounts();
    loyaltyBankMaxValue.value = cashbackCtrl.sliderMaxValueDouble.toDouble();
    loyaltyUpiVpaMaxValue.value = cashbackCtrl.sliderMaxValueDouble.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: cashBackManager.isLoading == true
            ? CircularProgressIndicator()
            : SafeArea(
                child: Column(children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: CustomAppBar(
                      heading: 'Redeeem points',
                      customActionIconsList: [
                        // CustomActionIcons(
                        //   image: AppImages.bottomNavHome,
                        //   //  customGradientColors: [Color(0xff95DFFF), Color(0xff014280)],
                        // ),
                      ]),
                ),
                Expanded(
                  child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.0.wp, vertical: 2.0.wp),
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0.wp, horizontal: 2.0.wp),
                          child: Text(
                            'Enter the following details to proceed',
                            style: AppStyle.shortHeading.copyWith(
                                color: AppColors.black,
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 2.0.wp,
                              bottom: 4.0.wp,
                              left: 2.0.wp,
                              right: 2.0.wp),
                          child: Text(
                            'Redemption mode',
                            style: AppStyle.shortHeading.copyWith(
                                fontSize: 11.0.sp,
                                height: 1.2.sp,
                                color: AppColors.greyTextColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Obx(() {
                          return Center(
                            child: CommonToggleCard(
                              getController: cashbackCtrl,
                              isSelectedlist: isSelectedRedeemMode,
                              redeemCardList: [
                                RedeemCard(
                                  imageSvg: AppImages.bankImageSvg,
                                  label: 'Bank account',
                                  isSelected: isSelectedRedeemMode[0],
                                ),
                                RedeemCard(
                                  imageSvg: AppImages.upiVpaSvg,
                                  label: 'UPI/VPA',
                                  isSelected: isSelectedRedeemMode[1],
                                )
                              ],
                            ),
                          );
                        }),
                        SizedBox(height: 4.0.wp),
                        // cash back through bank account ----------------------------------------
                        Obx(() {
                          return isSelectedRedeemMode[0] == true
                              ? LoyaltyBankAccount(

                                  //  key: bankAccountKey,

                                  sliderValue: loyaltyBankSliderValue,
                                  cashbackCtrl: cashbackCtrl,
                                  textEditCtrl: cashbackCtrl
                                      .redeemPointBankSliderTextEditingCtrl
                                      .value,
                                  minValue: loyaltyBankMinValue,
                                  maxValue: loyaltyBankMaxValue)
                              : LoyaltyUpiVpa(
                                  sliderValue: loyaltyUpiVpaSliderValue,
                                  cashbackCtrl: cashbackCtrl,
                                  textEditCtrl: cashbackCtrl
                                      .redeemPointUpiVpaSliderTextEditingCtrl
                                      .value,
                                  minValue: loyaltyUpiVpaMinValue,
                                  maxValue: loyaltyUpiVpaMaxValue);
                        }),
                      ]),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Obx(() {
                    return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.0.wp, vertical: 2.0.wp),
                        child: isSelectedRedeemMode[0] == true
                            ? cashBackManager.isLoading == true
                                ? CircularProgressIndicator()
                                : LoyaltySubmitButton(
                                    buttonEnabled: cashbackCtrl.bankAccountSubmitEnable,
                                    onPressed: () {
                                      if (cashBackManager.cardTapped.value ==
                                          true) {
                                        // call api when click on banks list

                                        if (cashBackManager
                                                    .selectedIndex.value !=
                                                -1 &&
                                            cashbackCtrl
                                                    .redeemPointBankSliderTextEditingCtrl
                                                    .value !=
                                                0) {
                                          print("list api call");

                                          print(cashBackManager
                                              .customerBankList[cashBackManager
                                                  .selectedIndex.value]
                                              .id);
                                          print(cashbackCtrl
                                              .redeemPointBankSliderTextEditingCtrl
                                              .value
                                              .text);

                                          cashBackManager.cashBackToBankApi(
                                              true,
                                              cashBackManager
                                                  .customerBankList[
                                                      cashBackManager
                                                          .selectedIndex.value]
                                                  .id,
                                              {},
                                              cashbackCtrl
                                                  .redeemPointBankSliderTextEditingCtrl
                                                  .value
                                                  .text,
                                              context);
                                        }
                                        return;
                                      }

                                      // below code will run we don't tap on bank list

                                      // add custom bank
                                      if (cashbackCtrl
                                              .bankAccountSubmitEnable.value ==
                                          true) {
                                        cashbackCtrl
                                            .bankAccountKey.currentState!
                                            .save();

                                        var bankId = checkBankId(cashbackCtrl
                                            .bankAccountKey!
                                            .currentState!
                                            .value['bankDropDown']);
                                        print("api for card tapped");

                                        cashBackManager.cashBackToBankApi(
                                            false,
                                            bankId,
                                            cashbackCtrl.bankAccountKey!
                                                .currentState!.value,
                                            "0",
                                            context);
                                      } else {
                                        // i have to put this code in if part
                                        null;
                                      }
                                      // cashbackCtrl.bankAccountformKey.currentState!
                                      //     .validate();
                                    })
                            : LoyaltySubmitButton(
                                buttonEnabled: cashbackCtrl.upiSubmitEnable,
                                onPressed: () {
                                  cashbackCtrl.bankAccountSubmitEnable.value = true;
                                  print("upi redeem now");

                                  print(cashbackCtrl
                                      .loyaltyUpiTextEditingCtrl.value.text);
                                  print(cashbackCtrl
                                      .redeemPointUpiVpaSliderTextEditingCtrl
                                      .value
                                      .text);
                                  cashBackManager.cashBackToUpiApi(
                                      cashbackCtrl
                                          .loyaltyUpiTextEditingCtrl.value.text,
                                      cashbackCtrl
                                          .redeemPointUpiVpaSliderTextEditingCtrl
                                          .value
                                          .text);
                                },
                                // onPressed: () => print(
                                //cashbackCtrl.loyaltyUpiTextEditingCtrl.value.text)),
                              ));
                  }),
                ),
              ])));
  }
}

// Loyalty bank Account tab
class LoyaltyBankAccount extends StatefulWidget {
  LoyaltyBankAccount(
      {Key? key,
      required this.sliderValue,
      required this.textEditCtrl,
      required this.minValue,
      required this.maxValue,
      required this.cashbackCtrl,
      this.initialValue})
      : super(key: key);

  final Rx<double> sliderValue;
  final TextEditingController textEditCtrl;
  final CashBackController cashbackCtrl;
  final Rx<double> minValue;
  final Rx<double> maxValue;
  final RxString? initialValue;

  @override
  State<LoyaltyBankAccount> createState() => _LoyaltyBankAccountState();
}

class _LoyaltyBankAccountState extends State<LoyaltyBankAccount> {
  final sizedbox = SizedBox(height: 4.0.wp);

  final String? bankAccontDropDownHint = 'Select your Bank Account';

  final enableButton = List.generate(4, (index) => false).obs;

  final RxList<String> data = <String>[].obs;

  final cashBackManager = Get.find<CashBackManager>();
  double widthIs = 0, heightIs = 0;

  final List<String> bankName = [
    'Axis Bank Ltd.',
    'Bandhan Bank Ltd.',
    'CSB Bank Limited',
    'City Union Bank Ltd.',
    'DCB Bank Ltd.',
  ];

  final List<String> bankAccountType = [
    'Saving account',
    'Current account',
  ];

  bool toEnableButton() {
    if (widget.cashbackCtrl.redeemPointBankSliderTextEditingCtrl.value.text
            .isNotEmpty &&
        widget.cashbackCtrl.loyaltyBankAccountTextEditingCtrl.value.text
            .isNotEmpty &&
        widget.cashbackCtrl.loyaltyBankAccountreEnteredTextEditingCtrl.value
            .text.isNotEmpty &&
        widget.cashbackCtrl.loyaltyBankAccountIFSCTextEditingCtrl.value.text
            .isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cashBackManager.selectedIndex.value = (-1);
    // cashBackManager.onInit();
    cashBackManager.customerBankList.clear();
  }

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;

    List<bool> localSelectedList = []; // for bank

    void onCardTapped(int index) {
      cashBackManager.cardTapped.value = true;
      print(cashBackManager.cardTapped.value);
      print("card tapped");
      cashBackManager.selectedIndex.value = index;

      cashBackManager.addBankData.value = {
        'bankAccountId': cashBackManager.customerBankList[index].id,
        'accountNumber':
            cashBackManager.customerBankList[index].maskAccountNumber,
        'ifscCode': cashBackManager.customerBankList[index].ifscCode,
        'accountType': cashBackManager.customerBankList[index].accountType,
      };

      print(cashBackManager.addBankData.value);

      cashBackManager.selectedplanList.value = localSelectedList;
    }

    return SingleChildScrollView(child: Obx(() {
      return FormBuilder(
        key: widget.cashbackCtrl.bankAccountKey,
        onChanged: () {
          widget.cashbackCtrl.bankAccountSubmitEnable.value =
              toEnableButton() || cashBackManager.selectedIndex != -1
                  ? true
                  : false;
        },
        initialValue: {
          "bankId": "",
          "pointsToRedeem": 0,
          "accountNumber": "",
          "bankAccountId": "",
          "ifscCode": "",
          "accountType": "",
          "customerId": "",
          "saveBankDetails": true,
          "bankDropDown": null,
          "accountType": null
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(
                top: 2.0.wp, bottom: 4.0.wp, left: 2.0.wp, right: 2.0.wp),
            child: Text(
              'Choose your points for redemption',
              style: AppStyle.shortHeading.copyWith(
                  fontSize: 11.0.sp,
                  height: 1.2.sp,
                  color: AppColors.greyTextColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
          // bank account redemption container

          CustomSlider(
              sliderValue: widget.sliderValue,
              textEditingController: widget.textEditCtrl,
              minValue: widget.minValue,
              maxValue: widget.maxValue),
          // text form field ------------------------
          sizedbox,

          //slider text ---------------------------------------------------------------
          CommonTextField(
            formName: 'pointsToRedeem',
            inputController: widget.textEditCtrl,
            hintText: 'Slide the amount above or enter',
            labelText: 'Points for cashback',
            keyboardType: TextInputType.number,
            inputValidator: (value) {
              if (widget.cashbackCtrl.validateValue(value!)) {
                return '*Invalid redeem code';
              } else {
                return null;
              }
            },
            inputOnChanged: (inputValue) {
              if (inputValue.isNotEmpty) {
                double data = double.parse(inputValue).toDouble();
                if (data <= widget.maxValue.value &&
                    data > widget.minValue.value) {
                  widget.sliderValue.value = double.parse(inputValue);
                } else {
                  data;
                }
              }
            },
            inputOnSubmitted: (value) {},
          ),

          ///  put user account page here ---------------------------------------------------

          SizedBox(
            height: 6.0.wp,
          ),

          cashBackManager.customerBankList.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0.wp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RowHeadingWithunderLineSubHeading(
                        heading: 'Your accounts',
                        subHeading: 'Manage',
                        onPressedSubHeading: () {
                          cashBackManager.fetchCustomerBankAccounts();
                          cashBackManager.fetchCustomerUpiAccounts();

                          Get.to(() => ManageAccountsCard());


                        }
                            ,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => cashBackManager.isLoading.value == true
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
                                    Text('Fetching accounts ...',
                                        style: AppStyle.shortHeading.copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w400))
                                  ],
                                ),
                              )
                            : cashBackManager.customerBankList.length == 0
                                ? Center(
                                    child: Container(
                                        width: widthIs * 0.9,
                                        height: heightIs * 0.3,
                                        child: Center(child: Text("No Plans"))))
                                : Padding(
                                    padding:
                                        EdgeInsets.only(left: 8.0, right: 8.0),
                                    child: Obx(
                                      () => Container(
                                          width: widthIs * 0.9,
                                          height: heightIs * 0.3,
                                          child: ListView.builder(
                                              itemCount: cashBackManager
                                                  .customerBankList.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Container(
                                                      child: GestureDetector(
                                                        onTap: () => {
                                                          // if (_mrManager
                                                          //     .plansList.isNotEmpty)
                                                          //   {onCardTapped(index)}
                                                        },
                                                        child: Obx(
                                                          () => GestureDetector(
                                                            onTap: () => {
                                                              if (cashBackManager
                                                                  .customerBankList
                                                                  .isNotEmpty)
                                                                {
                                                                  onCardTapped(
                                                                      index)
                                                                }
                                                            },
                                                            child:
                                                                CommonRadioCard(
                                                              radioCardType:
                                                                  RadioCardType
                                                                      .bankAccount,
                                                              bankAccountIFSC:
                                                                  cashBackManager
                                                                      .customerBankList[
                                                                          index]
                                                                      .ifscCode,
                                                              bankAccountName:
                                                                  cashBackManager
                                                                      .customerBankList[
                                                                          index]
                                                                      .name,
                                                              bankAccountNumber:
                                                                  cashBackManager
                                                                      .customerBankList[
                                                                          index]
                                                                      .maskAccountNumber,
                                                              bankAccountType:
                                                                  cashBackManager
                                                                      .customerBankList[
                                                                          index]
                                                                      .accountType,
                                                              cardWidth: double
                                                                  .maxFinite,
                                                              isSelected: index ==
                                                                  cashBackManager
                                                                      .selectedIndex
                                                                      .value,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
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
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CommonDivider(
                              isvertical: false,
                              horizontalPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0.wp),
                            ),
                          ),
                          Text(
                            'or',
                            style: AppStyle.shortHeading.copyWith(
                                color: const Color(0xff2d2d2d),
                                fontWeight: FontWeight.w600),
                          ),
                          Expanded(
                            child: CommonDivider(
                              isvertical: false,
                              horizontalPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0.wp),
                            ),
                          ),
                        ],
                      ),
                      sizedbox,
                      Text(
                        'Add account details',
                        style: AppStyle.shortHeading.copyWith(
                            color: const Color(0xff2d2d2d),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),

          // disable ui from here
          Obx(
            () => DropDown(
              onChanged: (value) {
                // return cashBackManager.bankAccontSelected!.value = value!;
              },
              formName: 'bankDropDown',
              labelName: 'Bank name',
              hintText: bankAccontDropDownHint!,
              data: cashBackManager.bankList.toList(),
              validationText: '*Bank name is compulsory',
            ),
          ),

          sizedbox,
          // enter your account number ------------------------------------------------------------
          CommonTextField(
            formName: 'accountNumber',
            inputController:
                widget.cashbackCtrl.loyaltyBankAccountTextEditingCtrl.value,
            hintText: 'Enter your account number here',
            labelText: 'Account number',
            keyboardType: TextInputType.number,
            inputValidator: (value) => CommonValidations().numberValidation(
                value, '*Account number is mandatory', 'It only takes numbers'),
            inputOnChanged: (inputValue) {},
            inputOnSubmitted: (value) {},
          ),
          sizedbox,
          // comfirm account number -----------------------------------------------
          CommonTextField(
            formName: 're-account',
            inputController: widget
                .cashbackCtrl.loyaltyBankAccountreEnteredTextEditingCtrl.value,
            hintText: 'Re-enter your account number here',
            labelText: 'Confirm account number',
            keyboardType: TextInputType.number,
            inputValidator: (value) {
              if (widget.cashbackCtrl.validateValue(value!)) {
                return '*Confirming your account number is compulsory';
              } else if (widget.cashbackCtrl
                      .loyaltyBankAccountreEnteredTextEditingCtrl.value.text !=
                  widget.cashbackCtrl.loyaltyBankAccountTextEditingCtrl.value
                      .text) {
                return 'Accont number mismatch!! please check';
              } else {
                return null;
              }
            },
            inputOnChanged: (inputValue) {},
            inputOnSubmitted: (value) {},
          ),

          sizedbox,
          // IFSC CODE -----------------------------------------------------------------------

          CommonTextField(
            formName: 'ifscCode',
            inputController:
                widget.cashbackCtrl.loyaltyBankAccountIFSCTextEditingCtrl.value,
            hintText: 'Enter your IFSC code here',
            labelText: 'IFSC code',
            keyboardType: TextInputType.text,
            inputValidator: (value) => CommonValidations().textValidation(
                value, '*IFSC code is mandatory', 'It only takes alphabets'),
            inputOnChanged: (inputValue) {},
            inputOnSubmitted: (value) {},
          ),
          sizedbox,
          // bank account type ---------------------------------------------------------
          DropDown(
            onChanged: (value) {},
            formName: 'accountType',
            labelName: 'Account type',
            data: bankAccountType,
            hintText: 'Select account type',
            validationText: '*Bank name is compulsory',
          ),
          sizedbox,
        ]),
      );
    }));
  }
}

// loyalty upi and vpa tab
class LoyaltyUpiVpa extends StatelessWidget {
  LoyaltyUpiVpa(
      {Key? key,
      required this.sliderValue,
      required this.textEditCtrl,
      required this.minValue,
      required this.maxValue,
      required this.cashbackCtrl})
      : super(key: key);

  final sizedbox = SizedBox(height: 4.0.wp);
  final Rx<double> sliderValue;
  final TextEditingController textEditCtrl;
  final CashBackController cashbackCtrl;
  final Rx<double> minValue;
  final Rx<double> maxValue;

  double widthIs = 0, heightIs = 0;
  List<bool> localSelectedUpiList = []; // for api

  CashBackManager cashBackManager = Get.put(CashBackManager());
  final GlobalKey<FormBuilderState> _upiAddKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    // TODO: implement initState

    cashBackManager.selectedUpiIndex.value = (-1);
    cashBackManager.customerUPIList.clear();
  }

  // upi card tapped

  void onUpiCardTapped(int index) {
    cashBackManager.cardUpiTapped.value = true;
    print("upi card tapped");
    print(cashBackManager.cardUpiTapped.value);

    cashBackManager.selectedUpiIndex.value = index;

    cashBackManager.addUpiData.value = {
      'upiId': cashBackManager.customerUPIList[index].upiId,
    };

    print(cashBackManager.addUpiData.value);

    cashBackManager.selectedplanUpiList.value = localSelectedUpiList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        return FormBuilder(
            key: cashbackCtrl.upiFormKey,
            onChanged: () {
              cashbackCtrl.upiSubmitEnable.value =
                  cashbackCtrl.loyaltyUpiTextEditingCtrl.value.text.isNotEmpty
                      ? true
                      : false;
            },
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 2.0.wp, bottom: 4.0.wp, left: 2.0.wp, right: 2.0.wp),
                child: Text(
                  'Choose your points for redemption',
                  style: AppStyle.shortHeading.copyWith(
                      fontSize: 11.0.sp,
                      height: 1.2.sp,
                      color: AppColors.greyTextColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              // bank account redemption container

              CustomSlider(
                  sliderValue: sliderValue,
                  textEditingController: textEditCtrl,
                  minValue: minValue,
                  maxValue: maxValue),
              // text form field ------------------------
              sizedbox,
              CommonTextField(
                formName: 'upiSlider',
                inputController:
                    cashbackCtrl.redeemPointUpiVpaSliderTextEditingCtrl.value,
                hintText: 'Slide the amount above or enter',
                labelText: 'Points for cashback',
                keyboardType: TextInputType.number,
                inputValidator: (value) {
                  if (cashbackCtrl.validateValue(value!)) {
                    return 'Invalid redeem code';
                  } else {
                    return null;
                  }
                },
                inputOnChanged: (inputValue) {
                  if (inputValue.isNotEmpty) {
                    double data = double.parse(inputValue).toDouble();
                    if (data <= maxValue.value && data > minValue.value) {
                      sliderValue.value = double.parse(inputValue);
                    } else {
                      data;
                    }
                  }
                },
                inputOnSubmitted: (value) {
                  if (cashbackCtrl.upiFormKey.currentState!.validate()) {
                    Get.snackbar('Hippi', 'form validated and $value');
                  } else {
                    Get.snackbar('Oops!!', 'form validated and $value');
                  }
                },
              ),
              sizedbox,

              cashBackManager.customerUPIList.isNotEmpty?
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0.wp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowHeadingWithunderLineSubHeading(
                      heading: 'Your UPI or VPA’s',
                      subHeading: 'Manage',
                      onPressedSubHeading: () async {
                        Get.to(() => ManageAccountsCard());
                      await  Future.delayed(Duration(seconds: 2), () {
                          // 5s over, navigate to a new page
                        cashBackManager.fetchCustomerUpiAccounts();

                        });

                      },
                    ),

                    SizedBox(
                      height: 16,
                    ),

                    // list of upi's list

                    Container(
                        height: 234,
                        child: ListView.builder(
                            itemCount: cashBackManager.customerUPIList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Container(
                                    child: GestureDetector(
                                      onTap: () => {
                                        if (cashBackManager
                                            .customerUPIList.isNotEmpty)
                                          {onUpiCardTapped(index)}
                                      },
                                      child: Obx(
                                        () => CommonRadioCard(
                                          radioCardType: RadioCardType.upi,
                                          upiId: cashBackManager
                                              .customerUPIList[index].upiId,
                                          cardWidth: double.maxFinite,
                                          isSelected: index ==
                                              cashBackManager
                                                  .selectedUpiIndex.value,
                                        ),
                                      ),
                                    ),
                                    //
                                    // decoration: BoxDecoration(
                                    //
                                    //   borderRadius:
                                    //   BorderRadius
                                    //       .circular(
                                    //       1.0.wp),
                                    // ),
                                  ));
                            }),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.cardScreenBg),
                          borderRadius: BorderRadius.circular(2.0.wp),
                        )),

                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CommonDivider(
                            isvertical: false,
                            horizontalPadding:
                                EdgeInsets.symmetric(horizontal: 2.0.wp),
                          ),
                        ),
                        Text(
                          'or',
                          style: AppStyle.shortHeading.copyWith(
                              color: const Color(0xff2d2d2d),
                              fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          child: CommonDivider(
                            isvertical: false,
                            horizontalPadding:
                                EdgeInsets.symmetric(horizontal: 2.0.wp),
                          ),
                        ),
                      ],
                    ),
                    sizedbox,
                    Text(
                      'Add UPI details',
                      style: AppStyle.shortHeading.copyWith(
                          color: const Color(0xff2d2d2d),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ):
              sizedbox,
              Row(
                children: [
                  //  VERIFY UPI ID
                  Flexible(
                    flex: 4,
                    child: FormBuilder(
                      initialValue: {
                        "upiId": "",
                      },
                      key: _upiAddKey,
                      child: CommonTextField(
                        formName: 'upiId',
                        hintText: 'Your UPI ID or VPA number',
                        labelText: 'UPI / VPA',
                        keyboardType: TextInputType.text,
                        inputValidator: (value) {
                          if (cashbackCtrl.validateValue(value!)) {
                            return '*UPI / VPA is compulsory to proceed';
                          } else {
                            return null;
                          }
                        },
                        inputOnChanged: (inputValue) {
                          if (inputValue.toString().length >= 14) {
                            cashbackCtrl.upiAddEnable.value = true;
                            return;
                          }
                          cashbackCtrl.upiAddEnable.value = false;
                        },
                        inputOnSubmitted: (value) {},
                      ),
                    ),
                  ),

                  Flexible(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 2.0.wp),
                        child: ButtonWithFlower(
                            buttonColor: cashbackCtrl
                                    .upiAddEnable.value //_buttonEnabled.value
                                ? null
                                : const Color(0xffc1c1c1),
                            buttonGradient: cashbackCtrl
                                    .upiAddEnable.value //_buttonEnabled.value
                                ? const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                        AppColors.backGroundgradient1,
                                        AppColors.backGroundgradient2
                                      ])
                                : null,
                            buttonHeight: 12.0.wp,
                            label: 'Add',
                            buttonWidth: double.maxFinite,
                            iconToRight: false,
                            labelSize: 14.0.sp,
                            labelColor: Colors.white,
                            labelWeight: FontWeight.bold,
                            onPressed: () {
                              if (cashbackCtrl.upiAddEnable == true) {
                                print("Verify onclick");
                                _upiAddKey.currentState!.save();
                                print(_upiAddKey.currentState!.value);
                                // ADD UPI DATA API HIT
                                cashBackManager.addUpiyApi(_upiAddKey
                                    .currentState!.value['upiId']
                                    .toString());
                                cashbackCtrl.upiAddEnable.value = false;
                                _upiAddKey.currentState!.reset();


                              }
                            }),
                        // child: Container(
                        //   height: 12.0.wp,
                        //   decoration:

                        //       BoxDecoration(
                        //         color: Color,
                        //         borderRadius: BorderRadius.circular(2.0.wp)),
                        // ),
                      ))
                ],
              ),
            ]));
        // redeem now button
      }),
    );
  }
}

class LoyaltySubmitButton extends StatelessWidget {

  final cashbackCtrl = Get.put(CashBackController());
  LoyaltySubmitButton({
    Key? key,
    required RxBool buttonEnabled,
    required this.onPressed,
  })  : _buttonEnabled = buttonEnabled,
        super(key: key);

  final RxBool _buttonEnabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
          padding: EdgeInsets.only(
            top: 2.0.wp,
            bottom: 4.0.wp,
          ),
          child: ButtonWithFlower(
            onPressed: onPressed,
            label: 'Redeem Now',
            buttonWidth: double.maxFinite,
            buttonHeight: 12.0.wp,
            labelSize: 14.0.sp,
            labelColor: Colors.white,
            labelWeight: FontWeight.bold,
            iconToRight: _buttonEnabled.value ? true : false,
            iconColor: Colors.white,
            buttonColor: _buttonEnabled.value ? null : const Color(0xffc1c1c1),
            buttonGradient: _buttonEnabled.value
                ? const LinearGradient(
                    begin: Alignment(-2, 0),
                    end: Alignment.centerRight,
                    colors: [
                        AppColors.orangeGradient1,
                        AppColors.orangeGradient2,
                      ])
                : null,
          ));
    });
  }
}

enum RedeemMode { isBankAccount, isUPI }
