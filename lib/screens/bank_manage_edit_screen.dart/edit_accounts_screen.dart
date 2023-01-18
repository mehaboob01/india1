import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:india_one/screens/loyality_points/cashback_redeem/cb_manager.dart';
import 'package:india_one/widgets/circular_progressbar.dart';
import 'package:india_one/widgets/common_text_search.dart';

import '../../connection_manager/ConnectionManagerController.dart';
import '../../constant/routes.dart';
import '../../constant/theme_manager.dart';
import '../../widgets/button_with_flower.dart';
import '../../widgets/common_drop_down.dart';
import '../../widgets/loyalty_common_header.dart';
import 'controller/update_bank_account_manager.dart';
import 'delete_bottom_sheet.dart';

class EditAccountsCard extends StatelessWidget {
  List<String>? bankList;
  List<String> bankAcntList = ['current', 'savings'];
  String? bankName;
  String? accountNumber;
  String? ifscCode;
  String? accountType;
  String? id;
  int? index;

  EditAccountsCard(
      {this.bankList,
      this.bankName,
      this.accountNumber,
      this.ifscCode,
      this.accountType,
      this.index,
      this.id});
  double widthIs = 0, heightIs = 0;

  CashBackManager cashBackManager = Get.put(CashBackManager());

  final GlobalKey<FormBuilderState> _updateBankAccount =
      GlobalKey<FormBuilderState>();
  UpdateBankAccount updateBankAccount = Get.put(UpdateBankAccount());

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;

    // print("bankName==>  ${bankName}");
    // print("account number==>  ${accountNumber}");
    // print("ac type==>  ${accountType}");
    // print("bank id==>  ${id}");
    // print("ifsc code==>  ${ifscCode}");
    // print("act type==>  ${accountType}");
    final ConnectionManagerController _controller =
        Get.find<ConnectionManagerController>();
    final bankNameCtrl = TextEditingController(text: bankName);

    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Obx(
              () =>
              Stack(
                children:
                  [
                    SafeArea(
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: CustomAppBar(
                                heading: 'Manage accounts',
                                customActionIconsList: [
                                  CustomActionIcons(
                                      image: AppImages.bottomNavHomeSvg,
                                      onHeaderIconPressed: () async {
                                        Get.offNamedUntil(MRouter.homeScreen,
                                                (route) => route.isFirst);
                                      })
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
                                          "bankName": bankName.toString(),
                                          "accountNumber": accountNumber,
                                          "ifscCode": ifscCode,
                                          "accountType": accountType,
                                          "id": id,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        text(
                                                          "Your account",
                                                          style: AppStyle
                                                              .shortHeading
                                                              .copyWith(
                                                            fontSize:
                                                            Dimens.font_16sp,
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            CommonDeleteBottomSheet()
                                                                .deleteBottomSheet(
                                                                index: index!,
                                                                onDelete: () {
                                                                  print(
                                                                      'Deleted ${cashBackManager.customerBankList[index!].id} successfully');

                                                                  cashBackManager.delBankAccount(
                                                                      cashBackManager
                                                                          .customerBankList[
                                                                      index!]
                                                                          .id);

                                                                  Future.delayed(
                                                                      const Duration(
                                                                          milliseconds:
                                                                          500),
                                                                          () async {
                                                                        Get.back();
                                                                        // Here you can write your code
                                                                        await cashBackManager
                                                                            .fetchCustomerBankAccounts();
                                                                        await cashBackManager
                                                                            .fetchCustomerUpiAccounts();
                                                                      });
                                                                  //  cashBackManager.fetchCustomerBankAccounts();
                                                                });
                                                          },
                                                          child: text(
                                                            "Delete account",
                                                            style: AppStyle
                                                                .shortHeading
                                                                .copyWith(
                                                              fontSize:
                                                              Dimens.font_16sp,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 34,
                                                    ),
                                                    // bank name
                                                    CommonSearchTextField(
                                                        itemList: cashBackManager
                                                            .bankList,
                                                        label: 'Bank name',
                                                        hintText:
                                                        'Select your bank here',
                                                        searchCtrl: bankNameCtrl,
                                                        searchHintText:
                                                        'Select your Bank here...',
                                                        itemListNullError:
                                                        'Invalid Bank Name'),

                                                    // DropDown(
                                                    //   onChanged: (value) {
                                                    //     return bankName = value;
                                                    //   },
                                                    //   formName: 'bankName',
                                                    //   initialValue: bankName,
                                                    //   labelName: 'Bank name',
                                                    //   hintText:
                                                    //       'Select your bank here',
                                                    //   data:
                                                    //       cashBackManager.bankList,
                                                    //   validationText:
                                                    //       ' name is compulsory',
                                                    // ),
                                                    SizedBox(
                                                      height: 18,
                                                    ),
                                                    // account number
                                                    FormBuilderTextField(
                                                      keyboardType: TextInputType
                                                          .emailAddress,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize:
                                                          Dimens.font_16sp),
                                                      decoration: InputDecoration(
                                                          isDense: true,
                                                          contentPadding: EdgeInsets.symmetric(
                                                              vertical: 4.5.wp,
                                                              horizontal: 4.0.wp),
                                                          //'Slide the amount above or enter', // dynamic
                                                          hintStyle: AppStyle.shortHeading.copyWith(
                                                              color: AppColors
                                                                  .greyInlineText,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              fontSize: 11.0.sp),
                                                          label: text(
                                                            "Account Number", //'Points for cashback', // dynamic
                                                          ),
                                                          floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .always,
                                                          errorStyle: AppStyle.shortHeading.copyWith(
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              fontSize: 11.0.sp,
                                                              color: Colors.red),
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  2.0.wp),
                                                              borderSide:
                                                              const BorderSide(
                                                                  width: 1.0,
                                                                  color: AppColors.greyInlineTextborder)),
                                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0.wp), borderSide: const BorderSide(width: 1.0, color: AppColors.greyInlineTextborder)),
                                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0.wp), borderSide: const BorderSide(width: 1.0, color: Colors.blue))),
                                                      validator:
                                                      FormBuilderValidators
                                                          .compose([
                                                        FormBuilderValidators
                                                            .required(context),
                                                      ]),
                                                      name: 'accountNumber',
                                                    ),
                                                    SizedBox(
                                                      height: 18,
                                                    ),
                                                    // ifsc code
                                                    FormBuilderTextField(
                                                      keyboardType: TextInputType
                                                          .emailAddress,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize:
                                                          Dimens.font_16sp),
                                                      decoration: InputDecoration(
                                                          isDense: true,
                                                          contentPadding: EdgeInsets.symmetric(
                                                              vertical: 4.5.wp,
                                                              horizontal: 4.0.wp),
                                                          //'Slide the amount above or enter', // dynamic
                                                          hintStyle: AppStyle.shortHeading.copyWith(
                                                              color: AppColors
                                                                  .greyInlineText,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              fontSize: 11.0.sp),
                                                          label: text(
                                                            "IFSC Code", //'Points for cashback', // dynamic
                                                          ),
                                                          floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .always,
                                                          errorStyle: AppStyle.shortHeading.copyWith(
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              fontSize: 11.0.sp,
                                                              color: Colors.red),
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  2.0.wp),
                                                              borderSide:
                                                              const BorderSide(
                                                                  width: 1.0,
                                                                  color: AppColors.greyInlineTextborder)),
                                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0.wp), borderSide: const BorderSide(width: 1.0, color: AppColors.greyInlineTextborder)),
                                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0.wp), borderSide: const BorderSide(width: 1.0, color: Colors.blue))),
                                                      validator:
                                                      FormBuilderValidators
                                                          .compose([
                                                        FormBuilderValidators
                                                            .required(context),
                                                      ]),
                                                      name: 'ifscCode',
                                                    ),
                                                    SizedBox(
                                                      height: 18,
                                                    ),
                                                    // account type
                                                    FormBuilderDropdown(
                                                      iconEnabledColor:
                                                      AppColors.primary,
                                                      iconDisabledColor:
                                                      Colors.grey,
                                                      name: 'accountType',
                                                      enabled: true,
                                                      decoration: InputDecoration(
                                                          floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .always,
                                                          labelText: "Account type",
                                                          hintText: "",
                                                          hintStyle: AppStyle.shortHeading.copyWith(
                                                              color: AppColors
                                                                  .greyInlineText,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              fontSize: 12.0.sp),
                                                          labelStyle: AppStyle.shortHeading.copyWith(
                                                              color: AppColors
                                                                  .greyText,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                              fontSize: 12.0.sp),
                                                          contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 4.0.wp,
                                                              horizontal:
                                                              4.0.wp),
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(2.0.wp),
                                                              borderSide: BorderSide(width: 1.0, color: AppColors.greyInlineTextborder)),
                                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0.wp), borderSide: BorderSide(width: 1.0, color: AppColors.greyInlineTextborder)),
                                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0.wp), borderSide: BorderSide(width: 1.0, color: AppColors.primary))),
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down_rounded,
                                                        // color: AppColors.greyInlineText,
                                                      ),
                                                      iconSize: 30,
                                                      isExpanded: true,
                                                      elevation: 5,
                                                      initialValue: accountType,
                                                      items: bankAcntList
                                                          .map((country) {
                                                        return DropdownMenuItem(
                                                          child: text(country),
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
                                      label:
                                      updateBankAccount.isLoading.value == true
                                          ? 'Saving..'
                                          : 'Save Changes',
                                      onPressed: () async {
                                        // method for checkBankID

                                        checkBankId(bankName) {
                                          for (var index
                                          in cashBackManager.bankListId) {
                                            if (index.name == bankName) {
                                              return index.id;
                                            }
                                          }
                                        }
                                        // above method is for check id

                                        _updateBankAccount.currentState!.save();
                                        _updateBankAccount.currentState!.validate();
                                        print(
                                            _updateBankAccount.currentState!.value);
                                        var bankId =
                                        checkBankId(bankNameCtrl.value.text);

                                        print(
                                            "bankId for updtae bank account${bankId} and ${bankNameCtrl.value.text}");
                                        print(
                                            "json value update bank ${_updateBankAccount.currentState!.value}");

                                        updateBankAccount.callUpdateBankAccount(
                                            _updateBankAccount.currentState!.value,
                                            bankId,
                                            id);

                                        Future.delayed(
                                            const Duration(milliseconds: 500),
                                                () async {
                                              // Here you can write your code
                                              await cashBackManager
                                                  .fetchCustomerBankAccounts();
                                              await cashBackManager
                                                  .fetchCustomerUpiAccounts();
                                            });
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
                        )),
                    updateBankAccount.isLoading == true? CircularProgressbar() : SizedBox()

                  ]

              ),
            )),
      ),
    );
  }
}
