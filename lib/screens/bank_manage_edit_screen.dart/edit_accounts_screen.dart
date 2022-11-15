import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';
import 'package:india_one/screens/loyality_points/cashback_redeem/cb_manager.dart';

import '../../constant/theme_manager.dart';
import '../../utils/comman_validaters.dart';
import '../../widgets/button_with_flower.dart';
import '../../widgets/common_drop_down.dart';
import '../../widgets/common_textfield.dart';
import '../../widgets/loyalty_common_header.dart';
import '../loyality_points/cashback_redeem/cashback_redeemption_screen.dart';
import '../loyality_points/redeem_points/rp_manager.dart';
import 'delete_bottom_sheet.dart';

class EditAccountsCard extends StatelessWidget {
  EditAccountsCard({super.key});
  final _data = Get.arguments[0];
  final RedeemMode _redeemMode = Get.arguments[1];
  final cashBackManager = Get.find<CashBackManager>();
  final cashBackCtrl = Get.find<CashBackController>();
  RxString accountName = ''.obs;

  final List<String> bankAccounts = [
    'SBI',
    'ICICI',
    'Axis bank',
    'Kotak Mahindra Bank',
    'Canara bank'
  ];
  final List<String> bankAccountType = [
    'Savings account',
    'Current account',
    'Fixed Deposit',
    'Joint account',
  ];

  @override
  Widget build(BuildContext context) {
    List<String> getBankName = List.generate(
        cashBackManager.customerBankList.length,
        (index) => cashBackManager.customerBankList[index].name!);

    final Map<String, dynamic> getformName =
        _redeemMode == RedeemMode.isBankAccount
            ? {
                'name': _data.name,
                'account': _data.maskAccountNumber,
                'ifsc': _data.ifscCode,
                'type': _data.accountType
              }
            : {'upi': _data.upiId};
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(children: [
          Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(
              heading: 'Manage accounts',
              customActionIconsList: [
                CustomActionIcons(
                  onHeaderIconPressed: () => CommonDeleteBottomSheet()
                      .deleteBottomSheet2(onDelete: () {
                    if (_redeemMode == RedeemMode.isBankAccount) {
                      print(
                          '${cashBackManager.editaccountformKey.currentState!.initialValue} ,,  ${_data.name}');
                    } else {
                      print(
                          '${cashBackManager.editUpformKey.currentState!.initialValue} ,,  ${_data.upiId}');
                    }
                  }),
                  image: AppImages.deleteIconSvg,
                  isSvg: true,
                  customGradientColors: const [
                    Color(0xff95DFFF),
                    Color(0xff014280)
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                      horizontal: 4.0.wp, vertical: 4.0.hp),
                  children: [
                Text(
                  _redeemMode == RedeemMode.isBankAccount
                      ? 'Your accounts'
                      : 'Your UPI or VPA’s',
                  style: AppStyle.shortHeading.copyWith(
                      color: const Color(0xff2d2d2d),
                      fontWeight: FontWeight.w600),
                ),
                _redeemMode == RedeemMode.isBankAccount
                    ? FormBuilder(
                        key: cashBackManager.editaccountformKey,
                        initialValue: getformName,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.0.wp),
                          child: Obx(() {
                            return Column(
                              children: [
                                DropDown(
                                  data: getBankName,
                                  validationText: 'invalid input',
                                  formName: 'name',
                                  labelName: 'Bank Name',
                                  onChanged: (value) => accountName.value,
                                  hintText: 'Select Bank Name',
                                  initialValue: accountName.value.isEmpty
                                      ? _data.name
                                      : null,
                                ),
                                SizedBox(height: 4.0.hp),
                                CommonTextField(
                                    inputController: cashBackCtrl
                                        .loyaltyBankAccountTextEditingCtrl
                                        .value,
                                    labelText: 'Account Number',
                                    initialValue:
                                        _data.maskAccountNumber.toString(),
                                    inputValidator: (value) =>
                                        CommonValidations().numberValidation(
                                            value,
                                            'value is null',
                                            'Invalid Value'),
                                    formName: 'account'),
                                SizedBox(height: 4.0.hp),
                                CommonTextField(
                                    inputController: cashBackCtrl
                                        .loyaltyBankAccountTextEditingCtrl
                                        .value,
                                    labelText: 'IFSC Code',
                                    initialValue: _data.ifscCode,
                                    inputValidator: (value) =>
                                        CommonValidations().numberValidation(
                                            value,
                                            'value is null',
                                            'Invalid Value'),
                                    formName: 'ifsc'),
                                SizedBox(height: 4.0.hp),
                                DropDown(
                                  data: bankAccountType,
                                  validationText: 'invalid input',
                                  formName: 'type',
                                  labelName: 'Account Type',
                                  onChanged: (value) => value,
                                  hintText: 'Select Account Type',
                                  initialValue: _data.accountType,
                                ),
                              ],
                            );
                          }),
                        ),
                      )
                    : FormBuilder(
                        key: cashBackManager.editUpformKey,
                        initialValue: {'upi': _data.upiId},
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.0.wp),
                            child: Obx(() {
                              return Column(children: [
                                CommonTextField(
                                    inputController: cashBackCtrl
                                        .loyaltyUpiTextEditingCtrl.value,
                                    labelText: 'UPI / VPA',
                                    initialValue: _data.upiId,
                                    inputValidator: (value) =>
                                        CommonValidations().textValidation(
                                            value,
                                            'value is null',
                                            'Invalid Value'),
                                    formName: 'upi'),
                              ]);
                            })))
              ])),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 4.0.hp),
                child: ButtonWithFlower(
                  label: 'Save Changes',
                  onPressed: () {
                    cashBackManager.editUpformKey.currentState!.save();
                    print(cashBackManager.editUpformKey.currentState!.value);
                  },
                  buttonWidth: double.maxFinite,
                  buttonHeight: 12.0.wp,
                  labelSize: 14.0.sp,
                  labelColor: Colors.white,
                  labelWeight: FontWeight.w600,
                  iconToRight: true,
                  iconColor: Colors.white,
                  buttonGradient: const LinearGradient(
                      begin: Alignment(-2, 0),
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.orangeGradient1,
                        AppColors.orangeGradient2,
                      ]),
                ),
              ))
        ])));
  }
}
