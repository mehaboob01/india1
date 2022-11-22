import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:india_one/screens/loyality_points/cashback_redeem/cb_manager.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/button_with_flower.dart';
import '../../widgets/common_drop_down.dart';
import '../../widgets/loyalty_common_header.dart';
import 'controller/update_bank_account_manager.dart';
import 'delete_bottom_sheet.dart';

class EditAccountsCard extends StatelessWidget {
  List<String> bankList;
  List<String> bankAcntList = ['current', 'savings'];
  String? bankName;
  String? accountNumber;
  String? ifscCode;
  String? accountType;
  String? id;

  EditAccountsCard(this.bankList, this.bankName, this.accountNumber,
      this.ifscCode, this.accountType, this.id);
  double widthIs = 0, heightIs = 0;

  CashBackManager cashBackManager = Get.put(CashBackManager());

  final GlobalKey<FormBuilderState> _updateBankAccount =
      GlobalKey<FormBuilderState>();
  UpdateBankAccount updateBankAccount = Get.put(UpdateBankAccount());

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            Align(
              alignment: Alignment.topCenter,
              child: CustomAppBar(
                heading: 'Manage accounts',
                customActionIconsList: [
                  CustomActionIcons(
                    onHeaderIconPressed: () => CommonDeleteBottomSheet()
                        .deleteBottomSheet2(onDelete: () {}),
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
            Container(
              height: heightIs * 0.7,
              width: widthIs,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // user inputs
                      FormBuilder(
                        key: _updateBankAccount,
                        initialValue: {
                          "bankName": "",
                          "accountNumber": accountNumber,
                          "ifscCode": ifscCode,
                          "accountType": "",
                          "id": id,
                        },
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(9),
                            width: widthIs,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: 4.0, left: 8, right: 8, top: 24),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Your accounts",
                                      style: AppStyle.shortHeading.copyWith(
                                        fontSize: Dimens.font_16sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 34,
                                    ),
                                    // bank name
                                    DropDown(
                                      onChanged: (value) {},
                                      formName: 'bankDropDown',
                                      labelName: 'Bank name',
                                      hintText: bankName.toString(),
                                      data: cashBackManager.bankList,
                                      validationText: ' name is compulsory',
                                    ),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    // account number
                                    FormBuilderTextField(
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Dimens.font_16sp),
                                      decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 4.5.wp,
                                              horizontal: 4.0.wp),
                                          //'Slide the amount above or enter', // dynamic
                                          hintStyle: AppStyle.shortHeading.copyWith(
                                              color: AppColors.greyInlineText,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11.0.sp),
                                          label: Text(
                                            "Account Number", //'Points for cashback', // dynamic
                                          ),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          errorStyle: AppStyle.shortHeading.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11.0.sp,
                                              color: Colors.red),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.0.wp),
                                              borderSide: const BorderSide(
                                                  width: 1.0,
                                                  color: AppColors
                                                      .greyInlineTextborder)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.0.wp),
                                              borderSide: const BorderSide(
                                                  width: 1.0,
                                                  color: AppColors
                                                      .greyInlineTextborder)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(2.0.wp),
                                              borderSide: const BorderSide(width: 1.0, color: AppColors.greyInlineTextborder))),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                      ]),
                                      name: 'accountNumber',
                                    ),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    // ifsc code
                                    FormBuilderTextField(
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Dimens.font_16sp),
                                      decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 4.5.wp,
                                              horizontal: 4.0.wp),
                                          //'Slide the amount above or enter', // dynamic
                                          hintStyle: AppStyle.shortHeading.copyWith(
                                              color: AppColors.greyInlineText,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11.0.sp),
                                          label: Text(
                                            "IFSC Code", //'Points for cashback', // dynamic
                                          ),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          errorStyle: AppStyle.shortHeading.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11.0.sp,
                                              color: Colors.red),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.0.wp),
                                              borderSide: const BorderSide(
                                                  width: 1.0,
                                                  color: AppColors
                                                      .greyInlineTextborder)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.0.wp),
                                              borderSide: const BorderSide(
                                                  width: 1.0,
                                                  color: AppColors
                                                      .greyInlineTextborder)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(2.0.wp),
                                              borderSide: const BorderSide(width: 1.0, color: AppColors.greyInlineTextborder))),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                      ]),
                                      name: 'ifscCode',
                                    ),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    // account type
                                    FormBuilderDropdown(
                                      iconEnabledColor: AppColors.primary,
                                      iconDisabledColor: Colors.grey,
                                      name: '',
                                      enabled: true,
                                      decoration: InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText: "Account type",
                                          hintText: "",
                                          hintStyle: AppStyle.shortHeading.copyWith(
                                              color: AppColors.greyInlineText,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.0.sp),
                                          labelStyle: AppStyle.shortHeading.copyWith(
                                              color: AppColors.greyText,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.0.sp),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 4.0.wp,
                                              horizontal: 4.0.wp),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.0.wp),
                                              borderSide: BorderSide(
                                                  width: 1.0,
                                                  color: AppColors
                                                      .greyInlineTextborder)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2.0.wp),
                                              borderSide:
                                                  BorderSide(width: 1.0, color: AppColors.greyInlineTextborder)),
                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0.wp), borderSide: BorderSide(width: 1.0, color: AppColors.primary))),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        // color: AppColors.greyInlineText,
                                      ),
                                      iconSize: 30,
                                      isExpanded: true,
                                      elevation: 5,
                                      initialValue: accountType,
                                      items: bankAcntList.map((country) {
                                        return DropdownMenuItem(
                                          child: Text(country),
                                          value: country,
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {},
                                    )
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

                      // chirag code
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 4.0.wp, vertical: 4.0.hp),
                    child: ButtonWithFlower(
                      label: updateBankAccount.isLoading == true
                          ? 'Saving..'
                          : 'Save Changes',
                      onPressed: () {
                        // method for checkBankID

                        String? checkBankId(bankName) {
                          for (var index in cashBackManager.bankListId) {
                            if (index.name == bankName) {
                              return index.id;
                            }
                          }
                        }
                        // above method is for check id

                        _updateBankAccount.currentState!.save();
                        _updateBankAccount.currentState!.validate();
                        print(_updateBankAccount.currentState!.value);

                        print("bankId for updtae bank account${bankName}");
                        print(
                            "json value update bank ${_updateBankAccount.currentState!.value}");

                        var bankId = checkBankId(bankName);
                        print("BAnk IDddd==>${bankId}");
                        updateBankAccount.callUpdateBankAccount(
                            _updateBankAccount.currentState!.value, bankId, id);
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
                  )),
            )
          ]),
        )));
  }
}
