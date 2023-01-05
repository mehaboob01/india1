import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loyality_points/cashback_redeem/cb_manager.dart';
import 'package:india_one/screens/loyality_points/cashback_redeem/your_accounts_page.dart';
import 'package:india_one/screens/loyality_points/loyality_manager.dart';
import 'package:india_one/screens/loyality_points/redeem_points/rp_manager.dart';
import 'package:india_one/widgets/button_with_flower.dart';
import 'package:india_one/widgets/common_redeem_card.dart';

import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../constant/routes.dart';
import '../../../utils/comman_validaters.dart';
import '../../../widgets/common_divider.dart';

import '../../../widgets/common_drop_down.dart';
import '../../../widgets/common_radio_card.dart';
import '../../../widgets/common_search_dropdown.dart';
import '../../../widgets/common_textfield.dart';
import '../../../widgets/common_toggle_card.dart';
import '../../../widgets/custom_slider.dart';

import '../../bank_manage_edit_screen.dart/manage_accounts_screen.dart';
import 'cashback_redo_controller.dart';

class CashBackRedeemPage extends StatefulWidget {
  CashBackRedeemPage({super.key});

  @override
  State<CashBackRedeemPage> createState() => _CashBackRedeemPageState();
}

class _CashBackRedeemPageState extends State<CashBackRedeemPage> {
  @override
  void initState() {
    redoCtrl.sliderTextEditingCtrl.clear();
    redoCtrl.redeemPointsSliderValue.value =
        redoCtrl.redeemPointsMinValue.value;
    super.initState();
  }

  final cashbackCtrl = Get.put(CashBackController());

  final redoCtrl = Get.put(CashBackRedoController());

  final cashbackManager = Get.find<CashBackManager>();

  final _loyaltyManager = Get.find<LoyaltyManager>();

  String? checkBankId(bankName) {
    for (var index in cashbackManager.bankListId) {
      if (index.name == bankName) {
        return index.id;
      }
    }
  }

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => IgnorePointer(
          ignoring: _controller.ignorePointer.value,
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: CustomAppBar(
                    heading: 'Redeem Points',
                    customActionIconsList: [
                      CustomActionIcons(
                          image: AppImages.bottomNavHomeSvg,
                          onHeaderIconPressed: () async {
                            Get.offNamedUntil(
                                MRouter.homeScreen, (route) => route.isFirst);
                          })
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0.hp),
                            child: Text(
                              'Enter the following details to proceed',
                              style: AppStyle.shortHeading.copyWith(
                                  color: AppColors.black,
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.0.hp),
                            child: Text(
                              'Redemption mode',
                              style: AppStyle.shortHeading.copyWith(
                                  fontSize: 11.0.sp,
                                  height: 1.2.sp,
                                  color: AppColors.greyTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Center(
                            child: CommonToggleCard(
                              isSelectedlist: redoCtrl.isSelectedBoolList,
                              redeemCardList: [
                                RedeemCard(
                                  imageSvg: AppImages.bankImageSvg,
                                  label: 'Bank account',
                                  isSelected: redoCtrl.isSelectedBoolList[0],
                                ),
                                RedeemCard(
                                  imageSvg: AppImages.upiVpaSvg,
                                  label: 'UPI/VPA',
                                  isSelected: redoCtrl.isSelectedBoolList[1],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 2.0.hp,
                              bottom: 2.0.hp,
                            ),
                            child: Text(
                              'Choose your points for redemption',
                              style: AppStyle.shortHeading.copyWith(
                                  fontSize: 11.0.sp,
                                  height: 1.2.sp,
                                  color: AppColors.greyTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 4.0),
                            child: CustomSlider(
                                sliderValue: redoCtrl.redeemPointsSliderValue,
                                textEditingController:
                                    redoCtrl.sliderTextEditingCtrl,
                                minValue: redoCtrl.redeemPointsMinValue,
                                maxValue: _loyaltyManager.redeemablePoints
                                    .toDouble()
                                    .obs),
                          ),
                          SizedBox(height: 10),
                          CommonTextField(
                            formName: 'pointsToRedeem',
                            inputController: redoCtrl.sliderTextEditingCtrl,
                            hintText: 'Slide the amount above or enter',
                            labelText: 'Points for cashback',
                            keyboardType: TextInputType.number,
                            inputValidator: (value) {
                              if (cashbackCtrl.validateValue(value!)) {
                                return '*Invalid redeem code';
                              } else {
                                return null;
                              }
                            },
                            inputOnChanged: (inputValue) {
                              if (inputValue!.isNotEmpty) {
                                double data =
                                    double.parse(inputValue).toDouble();
                                if (data <=
                                        _loyaltyManager
                                            .redeemablePoints.value &&
                                    data >
                                        redoCtrl.redeemPointsMinValue.value) {
                                  redoCtrl.redeemPointsSliderValue.value =
                                      double.parse(inputValue);
                                } else {}
                              }
                            },
                          ),
                          SizedBox(
                            height: 6.0.wp,
                          ),
                          redoCtrl.isSelectedBoolList[0]
                              ? BankAccoutCard(formkey: redoCtrl.accountFormKey)
                              : UpiVpaCard(),
                        ],
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 1.0.hp, horizontal: 4.0.wp),
                  child: Obx(() {
                    return Align(
                        alignment: Alignment.bottomCenter,
                        child: redoCtrl.isSelectedBoolList[0]
                            ? LoyaltySubmitButton(
                                buttonEnabled: (redoCtrl
                                                .accountButtonEnabled.value &&
                                            redoCtrl.bankname.value != '' &&
                                            redoCtrl.redeemPointsSliderValue
                                                    .value !=
                                                0.0) ||
                                        (cashbackManager.selectedIndex.value !=
                                                -1 &&
                                            redoCtrl.redeemPointsSliderValue
                                                    .value !=
                                                0.0)
                                    ? true.obs
                                    : false.obs,
                                onPressed: () {
                                  if (cashbackManager.selectedIndex.value !=
                                      -1) {
                                    print("card api");

                                    // api call from bank list to bank transfer
                                    debugPrint(redoCtrl
                                        .redeemPointsSliderValue.value
                                        .toString());
                                    cashbackManager.cashBackToBankApi(
                                        true,
                                        cashbackManager
                                            .customerBankList[cashbackManager
                                                .selectedIndex.value]
                                            .id,
                                        {},
                                        redoCtrl.redeemPointsSliderValue.value
                                            .round()
                                            .toString(),
                                        context);
                                  } else {
                                    redoCtrl.accountFormKey.currentState!
                                        .save();

                                    // custom data to bank transfer
                                    print(
                                        "bank name===> ${redoCtrl.accountFormKey!.currentState!.value['bankDropDown']}");

                                    var bankId =
                                        checkBankId(redoCtrl.bankname.value);
                                    print("bank id${bankId}");

                                    if (redoCtrl.accountFormKey.currentState!
                                            .validate() ==
                                        true) {
                                      // on click on redeem now bank
                                      redoCtrl.accountFormKey.currentState!
                                          .save();

                                      print("redeem");
                                      print(redoCtrl
                                          .accountFormKey.currentState!.value);
                                      cashbackManager.cashBackToBankApi(
                                          false,
                                          bankId,
                                          redoCtrl.accountFormKey.currentState!
                                              .value,
                                          redoCtrl.redeemPointsSliderValue.value
                                              .round()
                                              .toString(),
                                          context);
                                    } else {
                                      redoCtrl.accountFormKey.currentState!
                                          .validate();
                                    }
                                  }
                                })
                            : LoyaltySubmitButton(
                                buttonEnabled:
                                    cashbackManager.selectedUpiIndex.value !=
                                                -1 &&
                                            redoCtrl.redeemPointsSliderValue
                                                    .value !=
                                                0.0
                                        ? true.obs
                                        : false.obs,
                                onPressed: () {
                                  // todo api call for banktoapi

                                  print(
                                      "upi data${cashbackManager.addUpiData.value['upiId']}");
                                  cashbackManager.cashBackToUpiApi(
                                      cashbackManager.addUpiData.value['upiId'],
                                      redoCtrl.redeemPointsSliderValue.value
                                          .round()
                                          .toString(),
                                      context);
                                  debugPrint('Upi Vpa Clicked');
                                }));
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------------------- Bank Account Card ----------------------------------------------

class BankAccoutCard extends StatefulWidget {
  BankAccoutCard({super.key, required this.formkey});
  final Key formkey;

  @override
  State<BankAccoutCard> createState() => _BankAccoutCardState();
}

class _BankAccoutCardState extends State<BankAccoutCard> {
  FocusNode bankNameFocus = FocusNode();
  final List<String> bankAccountType = [
    'Saving account',
    'Current account',
  ];

  final sizedbox = SizedBox(height: 2.0.hp);

  final cashbackCtrl = Get.find<CashBackController>();

  bool bankAccountDropDownTapped = false;

  bool bankTypeDropDownTapped = false;
  final String? bankAccontDropDownHint = 'Bank name';

  final redoCtrl = Get.put(CashBackRedoController());
  final cashBackManager = Get.put(CashBackManager());
  double widthIs = 0, heightIs = 0;
  bool accountNumberValidate = false;

  @override
  void initState() {
    super.initState();
    cashBackManager.fetchCustomerBankAccounts();

    // cashBackManager.fetchCustomerUpiAccounts();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      redoCtrl.accountButtonEnabled.value = false;
      cashBackManager.selectedIndex.value = -1;

      redoCtrl.bankname.value = '';
      cashbackCtrl.loyaltyBankAccountTextEditingCtrl.value.text = '';
      cashbackCtrl.loyaltyBankAccountreEnteredTextEditingCtrl.value.text = '';
      cashbackCtrl.loyaltyBankAccountIFSCTextEditingCtrl.value.text = '';
    });
  }

  void onCardTapped(int index) {
    clearData();

    if (cashBackManager.selectedIndex.value == index) {
      cashBackManager.selectedIndex.value = -1;
    } else {
      cashBackManager.selectedIndex.value = index;
    }

    cashBackManager.addBankData.value = {
      'bankAccountId': cashBackManager.customerBankList[index].id,
      'accountNumber':
          cashBackManager.customerBankList[index].maskAccountNumber,
      'ifscCode': cashBackManager.customerBankList[index].ifscCode,
      'accountType': cashBackManager.customerBankList[index].accountType,
    };
  }

  bool toEnableButton() {
    if (bankTypeDropDownTapped == true &&
        redoCtrl.bankname.value != '' &&
        cashbackCtrl.loyaltyBankAccountTextEditingCtrl.value.text.isNotEmpty &&
        cashbackCtrl
            .loyaltyBankAccountreEnteredTextEditingCtrl.value.text.isNotEmpty &&
        cashbackCtrl
            .loyaltyBankAccountIFSCTextEditingCtrl.value.text.isNotEmpty) {
      print('button enabled is true dummy');

      return true;
    } else {
      print('button enabled is false');
      print('bank tapped $bankAccountDropDownTapped ');
      print('type tapped $bankTypeDropDownTapped');
      return false;
    }
  }

  void clearData() {
    bankAccountDropDownTapped = false;
    bankTypeDropDownTapped = false;
    redoCtrl.bankname.value = '';
    redoCtrl.accountFormKey.currentState!.reset();

    cashbackCtrl.loyaltyBankAccountTextEditingCtrl.value.text = '';
    cashbackCtrl.loyaltyBankAccountreEnteredTextEditingCtrl.value.text = '';
    cashbackCtrl.loyaltyBankAccountIFSCTextEditingCtrl.value.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          cashBackManager.customerBankList.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0.hp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RowHeadingWithunderLineSubHeading(
                        heading: 'Your Accounts',
                        subHeading: 'Manage',
                        onPressedSubHeading: () =>
                            Get.to(() => ManageAccountsCard()),
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
                                        width: Get.size.width * 0.9,
                                        height: Get.size.height * 0.3,
                                        child: Center(child: Text("No Plans"))))
                                : Container(
                                    width: Get.size.width * 0.9,
                                    height: Get.size.height * 0.3,
                                    child: ListView.builder(
                                        itemCount: cashBackManager
                                            .customerBankList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Container(
                                                child: Obx(
                                                  () => GestureDetector(
                                                    onTap: () => {
                                                      if (cashBackManager
                                                          .customerBankList
                                                          .isNotEmpty)
                                                        {
                                                          onCardTapped(index),
                                                        }
                                                    },
                                                    child: CommonRadioCard(
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
                                                      cardWidth:
                                                          double.maxFinite,
                                                      isSelected: index ==
                                                          cashBackManager
                                                              .selectedIndex
                                                              .value,
                                                    ),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
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
                      Container(
                        height: 20,
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
          Container(
            child: Obx(() {
              return FormBuilder(
                  onChanged: () {
                    redoCtrl.accountButtonEnabled.value =
                        toEnableButton() ? true : false;
                    print('this is from formbuilder');
                  },
                  initialValue: {
                    "bankDropDown": null,
                    'accountNumber': '',
                    're-account': '',
                    'ifscCode': '',
                    'accountType': null,
                  },
                  key: widget.formkey,
                  child: Column(
                    children: [
                      // Obx(
                      //  ()=> DropDown(
                      //
                      //     onChanged: (value) {
                      //        return '';
                      //     },
                      //     formName: 'bankDropDown',
                      //     isDropDownEnabled:
                      //     cashBackManager.selectedIndex.value != -1
                      //         ? false
                      //         : true,
                      //     labelName: 'Bank name',
                      //    hintText: bankAccontDropDownHint!,
                      //     data: cashBackManager.bankList.toList(),
                      //     validationText: '*Bank name is compulsory',
                      //   ),
                      // ),
                      Obx(
                        () => SearchDropDown(
                          formkey: cashBackManager.bankNameFormKey,
                          searchIconColor: AppColors.primary,
                          selectedValue: cashBackManager.dropDownBankName.value,
                          onChanged: (value) {
                            redoCtrl.bankname.value = value!;
                            print(redoCtrl.bankname.value);
                          },
                          // onChanged: (value) {
                          //   // return cashBackManager.bankAccontSelected!.value = value!;
                          // },
                          // onTapped: () {
                          // //  return bankAccountDropDownTapped = true;

                          // },
                          isDropDownEnabled:
                              cashBackManager.selectedIndex.value != -1
                                  ? false
                                  : true,
                          searchHintText: 'Find your bank here',
                          labelName: bankAccontDropDownHint!,
                          hintText: "Select your bank here",
                          itemList: cashBackManager.bankList.toList(),
                          validationText: '*Bank name is compulsory',
                        ),
                      ),

                      sizedbox,
                      // enter your account number ------------------------------------------------------------
                      CommonTextField(
                        formName: 'accountNumber',
                        isObscure: cashBackManager.accountTextObscure.value,
                        isAutoValidate: accountNumberValidate,
                        isfieldEnabled:
                            cashBackManager.selectedIndex.value != (-1)
                                ? false
                                : true,
                        inputController: cashbackCtrl
                            .loyaltyBankAccountTextEditingCtrl.value,
                        hintText: 'Enter your account number here',
                        labelText: 'Account number',
                        keyboardType: TextInputType.number,
                        inputFormat: [
                          LengthLimitingTextInputFormatter(18),
                        ],
                        suffixIcon: GestureDetector(
                          onTap: () {
                            cashBackManager.accountTextObscure.value =
                                !cashBackManager.accountTextObscure.value;
                          },
                          child: cashBackManager.accountTextObscure.value ==
                                  false
                              ? Icon(
                                  Icons.visibility_off_rounded,
                                  size: 25,
                                  color:
                                      AppColors.greyInlineText.withOpacity(0.6),
                                )
                              : Icon(
                                  Icons.visibility_rounded,
                                  size: 25,
                                  color:
                                      AppColors.greyInlineText.withOpacity(0.8),
                                ),
                        ),
                        inputValidator: (value) {
                          if (value != null) {
                            return CommonValidations().numberValidation(
                                value: value,
                                nullError: '*Account number is mandatory',
                                invalidInputError: 'It only takes numbers',
                                minValue: 9);
                          } else {
                            return '';
                          }
                        },
                        inputOnChanged: (inputValuee) {
                          setState(() {
                            accountNumberValidate = true;
                          });

                          //  redoCtrl.accountFormKey.currentState!.save();
                          //  redoCtrl.accountFormKey.currentState.validate();
                          //
                          // print( redoCtrl.accountFormKey.currentState!.value['accountNumber']) ;
                          //
                          //
                          //
                          //  if(inputValue!.length<7)
                          //    {
                          //
                          //
                          //
                          //
                          //
                          //
                          //
                          //      return "error";
                          //
                          //    }
                          //
                        },
                        inputOnSubmitted: (value) {},
                      ),
                      sizedbox,
                      // comfirm account number -----------------------------------------------
                      CommonTextField(
                        formName: 're-account',
                        isfieldEnabled:
                            cashBackManager.selectedIndex.value != (-1)
                                ? false
                                : true,
                        inputController: cashbackCtrl
                            .loyaltyBankAccountreEnteredTextEditingCtrl.value,
                        isObscure: cashBackManager.comfirmAccountObscure.value
                            ? true
                            : false,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            cashBackManager.comfirmAccountObscure.value =
                                !cashBackManager.comfirmAccountObscure.value;
                          },
                          child: cashBackManager.comfirmAccountObscure.value ==
                                  false
                              ? Icon(
                                  Icons.visibility_off_rounded,
                                  size: 25,
                                  color:
                                      AppColors.greyInlineText.withOpacity(0.6),
                                )
                              : Icon(
                                  Icons.visibility_rounded,
                                  size: 25,
                                  color:
                                      AppColors.greyInlineText.withOpacity(0.8),
                                ),
                        ),
                        hintText: 'Re-enter your account number here',
                        labelText: 'Confirm account number',
                        keyboardType: TextInputType.number,
                        inputValidator: (value) {
                          if (cashbackCtrl.validateValue(value!)) {
                            return '*Confirming your account number is compulsory';
                          } else if (cashbackCtrl
                                  .loyaltyBankAccountreEnteredTextEditingCtrl
                                  .value
                                  .text !=
                              cashbackCtrl.loyaltyBankAccountTextEditingCtrl
                                  .value.text) {
                            return 'Accont number mismatch!! please check';
                          } else {
                            return null;
                          }
                        },
                        inputFormat: [
                          LengthLimitingTextInputFormatter(18),
                        ],
                        // inputOnChanged: (inputValue) {},
                        // inputOnSubmitted: (value) {},
                      ),

                      sizedbox,
                      // IFSC CODE -----------------------------------------------------------------------

                      CommonTextField(
                        isUpperCase: true,
                        formName: 'ifscCode',
                        isfieldEnabled:
                            cashBackManager.selectedIndex.value != (-1)
                                ? false
                                : true,
                        inputController: cashbackCtrl
                            .loyaltyBankAccountIFSCTextEditingCtrl.value,
                        hintText: 'Enter your IFSC code here',
                        labelText: 'IFSC code',
                        keyboardType: TextInputType.text,
                        inputFormat: [
                          LengthLimitingTextInputFormatter(11),
                        ],
                        inputValidator: (value) => CommonValidations()
                            .textValidation(
                                value: value,
                                nullError: '*IFSC code is mandatory',
                                invalidInputError:
                                    'Please enter valid IFSC code',
                                isIfsc: true),
                        inputOnChanged: (inputValue) {},
                        inputOnSubmitted: (value) {},
                      ),
                      sizedbox,
                      // bank account type ---------------------------------------------------------
                      DropDown(
                        onTapped: () => bankTypeDropDownTapped = true,
                        onChanged: (value) {
                          return '';
                        },
                        formName: 'accountType',
                        isDropDownEnabled:
                            cashBackManager.selectedIndex.value != (-1)
                                ? false
                                : true,
                        labelName: 'Account type',
                        data: bankAccountType, //bankAccountType,
                        hintText: 'Select account type',
                        validationText: '*Bank name is compulsory',
                      ),
                      sizedbox,
                    ],
                  ));
            }),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------ Upi Vpa Card --------------------------------------------

class UpiVpaCard extends StatefulWidget {
  UpiVpaCard({super.key});

  @override
  State<UpiVpaCard> createState() => _UpiVpaCardState();
}

class _UpiVpaCardState extends State<UpiVpaCard> {
  final cashbackCtrl = Get.find<CashBackController>();
  final cashBackManager = Get.find<CashBackManager>();
  final sizedbox = SizedBox(height: 2.0.hp);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cashBackManager.selectedUpiIndex.value = -1;
      print('hello cashback ${cashBackManager.cardUpiTapped.value}');
    });
  }

  void onUpiCardTapped(int index) {
    print("upi card tapped");
    print(cashBackManager.cardUpiTapped.value);

    if (cashBackManager.selectedUpiIndex.value == index) {
      cashBackManager.selectedUpiIndex.value = -1;
    } else {
      cashBackManager.selectedUpiIndex.value = index;
    }

    cashBackManager.addUpiData.value = {
      'upiId': cashBackManager.customerUPIList[index].upiId,
    };

    // cashBackManager.selectedplanUpiList.value = localSelectedUpiList;
  }

  @override
  Widget build(BuildContext context) {
    FocusNode upifocus = FocusNode();
    return Obx(
      () => Column(
        children: [
          cashBackManager.customerUPIList.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0.wp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RowHeadingWithunderLineSubHeading(
                        heading: 'Your UPI or VPA’s',
                        subHeading: 'Manage',
                        onPressedSubHeading: () {
                          Get.to(() => ManageAccountsCard());
                        },
                      ),

                      SizedBox(
                        height: 16,
                      ),

                      // list of upi's list

                      Container(
                          width: Get.size.width * 0.9,
                          height: Get.size.height * 0.3,
                          child: Obx(
                            () => ListView.builder(
                                itemCount:
                                    cashBackManager.customerUPIList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Obx(() {
                                        return Container(
                                          child: GestureDetector(
                                            onTap: () => onUpiCardTapped(index),
                                            child: CommonRadioCard(
                                              radioCardType: RadioCardType.upi,
                                              upiId: cashBackManager
                                                  .customerUPIList[index].upiId,
                                              cardWidth: double.maxFinite,
                                              isSelected: index ==
                                                  cashBackManager
                                                      .selectedUpiIndex.value,
                                            ),
                                          ),
                                        );
                                      }));
                                }),
                          ),
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
                )
              : SizedBox.shrink(),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Obx(() {
              return Row(
                children: [
                  //  VERIFY UPI ID
                  Flexible(
                    flex: 4,
                    child: FormBuilder(
                      initialValue: {
                        "upiId": "",
                      },
                      key: cashbackCtrl.upiFormKey,
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
                        focus: upifocus,
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
                                        AppColors.blueColor,
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
                              if (cashbackCtrl.upiAddEnable.value == true) {
                                print("Verify onclick");
                                cashbackCtrl.upiFormKey.currentState!.save();
                                print(cashbackCtrl
                                    .upiFormKey.currentState!.value);
                                // ADD UPI DATA API HIT
                                cashBackManager.addUpiyApi(cashbackCtrl
                                    .upiFormKey.currentState!.value['upiId']
                                    .toString());
                                cashbackCtrl.upiAddEnable.value = false;
                                cashbackCtrl.upiFormKey.currentState!.reset();
                              }
                              upifocus.unfocus();
                            }),
                      ))
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------   submit button ------------------------------------------

class LoyaltySubmitButton extends StatelessWidget {
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
            onPressed: _buttonEnabled.value ? onPressed : () => null,
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
