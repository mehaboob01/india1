import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:india_one/screens/loyality_points/cashback_redeem/cashback_redo_controller.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';

import '../../connection_manager/ConnectionManagerController.dart';
import '../../constant/theme_manager.dart';
import '../../widgets/common_drop_down.dart';
import '../../widgets/common_search_dropdown.dart';
import '../loyality_points/cashback_redeem/cb_manager.dart';
import 'common/profile_stepper.dart';
import 'controller/add_account_manager.dart';
import 'controller/profile_controller.dart';

class AddBankAccountScreen extends StatefulWidget {
  AddBankAccountScreen({Key? key}) : super(key: key);

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  ProfileController profileController = Get.put(ProfileController());

  AddAccountManager accountManager = Get.put(AddAccountManager());

  CashBackManager cashBackManager = Get.put(CashBackManager());

  final redoCtrl = Get.put(CashBackRedoController());

  GlobalKey<FormState> bankAccountKey = GlobalKey<FormState>();

  // GlobalKey<FormState> bankAccountKeyForBankId = GlobalKey<FormState>();
  final bankAccountKeyForBankId = GlobalKey<FormBuilderState>();

  bool bankAccountDropDownTapped = false;
  bool showAccountNumber = false;
  bool showComfirmAccountNumber = false;
  @override
  void initState() {
    super.initState();
    cashBackManager.callBankListApi();
    redoCtrl.bankname.value = '';
    profileController.accountNumberController.value.text = '';
    profileController.comfirmAccountNumber.value.text = '';
    profileController.ifscController.value.text = '';
  }

  String? checkBankId(bankName) {
    for (var index in cashBackManager.bankListId) {
      if (index.name == bankName) {
        return index.id;
      }
    }
  }

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              SafeArea(
                child: CustomAppBar(
                  heading: 'Add Bank Account Details',
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Form(
                      key: bankAccountKey,
                      autovalidateMode:
                          profileController.autoValidation.value == true
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                      child: FormBuilder(
                        key: bankAccountKeyForBankId,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialValue: {},
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => SearchDropDown(
                                isforProfileScreen: true,
                                formkey: cashBackManager.bankNameFormKey,
                                searchIconColor: AppColors.primary,
                                selectedValue: redoCtrl.bankname.value,
                                // cashBackManager.dropDownBankName.value,
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
                                // isDropDownEnabled:
                                //     cashBackManager.selectedIndex.value != -1
                                //         ? false
                                //         : true,
                                searchHintText: 'Find your bank here',
                                labelName: "Select your bank here",
                                hintText: "Select your bank here",
                                itemList: cashBackManager.bankList.toList(),
                                validationText: '*Bank name is compulsory',
                              ),
                            ),

                            // Obx(
                            //   () => DropDown(
                            //     onTapped: () {
                            //       bankAccountDropDownTapped = true;
                            //     },
                            //     onChanged: (value) {
                            //       // return cashBackManager.bankAccontSelected!.value = value!;
                            //     },
                            //     formName: 'bankDropDown',
                            //     isDropDownEnabled:
                            //         accountManager.selectedIndex.value != -1
                            //             ? false
                            //             : true,
                            //     labelName: "Select your bank here",
                            //     hintText: "Select your bank here",
                            //     data: cashBackManager.bankList.toList(),
                            //     validationText: '*Bank name is compulsory',
                            //   ),
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            ProfileStepper().textField(
                              controller: profileController
                                  .accountNumberController.value,
                              label: 'Account number',
                              hint: 'Enter account number',
                              isObscure: showAccountNumber,
                              vaidation: (value) =>
                                  profileController.accountNumberValidation(
                                value: value,
                              ),
                              suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showAccountNumber = !showAccountNumber;
                                  });
                                },
                                child: showAccountNumber == false
                                    ? Icon(
                                        Icons.visibility_off_rounded,
                                        size: 25,
                                        color: AppColors.greyInlineText
                                            .withOpacity(0.6),
                                      )
                                    : Icon(
                                        Icons.visibility_rounded,
                                        size: 25,
                                        color: AppColors.greyInlineText
                                            .withOpacity(0.8),
                                      ),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(18),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ProfileStepper().textField(
                              controller:
                                  profileController.comfirmAccountNumber.value,
                              label: 'Confirm account number',
                              hint: 'Re-enter your account number here',
                              isObscure: showComfirmAccountNumber,
                              vaidation: (value) =>
                                  profileController.accountNumberValidation(
                                      value: value,
                                      onNullError:
                                          '*Confirming your account number is mandatory'),
                              keyboardType: TextInputType.number,
                              suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showComfirmAccountNumber =
                                        !showComfirmAccountNumber;
                                  });
                                },
                                child: showComfirmAccountNumber == false
                                    ? Icon(
                                        Icons.visibility_off_rounded,
                                        size: 25,
                                        color: AppColors.greyInlineText
                                            .withOpacity(0.6),
                                      )
                                    : Icon(
                                        Icons.visibility_rounded,
                                        size: 25,
                                        color: AppColors.greyInlineText
                                            .withOpacity(0.8),
                                      ),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(18),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ProfileStepper().textField(
                              controller:
                                  profileController.ifscController.value,
                              label: 'IFSC code',
                              hint: 'Enter IFSC code',
                              vaidation: (value) =>
                                  profileController.ifscValidation(
                                value,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ButtonTheme(
                              alignedDropdown: true,
                              child: ProfileStepper().commonDropDown(
                                item: <String>[
                                  'savings',
                                  'current'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  profileController.accountType.value = value;
                                },
                                label: 'Account type',
                                hint: 'Select account type',
                                // value: profileController.accountType.value.isEmpty
                                //     ? null
                                //     : profileController.accountType.value,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => profileController
                                      .getBankAccountLoading.value
                                  ? CircularProgressIndicator()
                                  : InkWell(
                                      onTap: () {
                                        profileController.autoValidation.value =
                                            true;

                                        if (!bankAccountKey.currentState!
                                            .validate()) {
                                          print("Not validate");
                                          Flushbar(
                                            title: "Alert!",
                                            message: "missing some values",
                                            duration: Duration(seconds: 3),
                                          )..show(context);
                                        } else if (profileController
                                                .accountType.value ==
                                            '') {
                                          Flushbar(
                                            title: "Alert!",
                                            message: "Select account type",
                                            duration: Duration(seconds: 3),
                                          )..show(context);
                                        } else if (profileController
                                                .accountNumberController
                                                .value
                                                .text !=
                                            profileController
                                                .comfirmAccountNumber
                                                .value
                                                .text) {
                                          Flushbar(
                                            title: "Alert!",
                                            message:
                                                "Account number mismatch!! please check",
                                            duration: Duration(seconds: 3),
                                          )..show(context);
                                        } else {
                                          bankAccountKeyForBankId.currentState!
                                              .save();

                                          //  print(
                                          //      "bank name===> ${bankAccountKeyForBankId.currentState!.value['bankDropDown']}");
                                          print(
                                              'before call ${redoCtrl.bankname.value}');
                                          String? bankId = checkBankId(
                                              redoCtrl.bankname.value);
                                          print("bank id ${bankId}");
                                          profileController
                                              .addBankAccountData(bankId)
                                              .then((value) {
                                            bankAccountKeyForBankId
                                                .currentState!.value
                                                .clear();
                                            profileController
                                                .ifscController.value
                                                .clear();
                                          });
                                        }
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 48,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Spacer(),
                                            Text(
                                              'Add Bank Details',
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                            Spacer(),
                                            if (1 == 1)
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
                                            colors: 1 == 1
                                                ? [
                                                    Colors.orange,
                                                    Colors.redAccent,
                                                  ]
                                                : [
                                                    AppColors.btnDisableColor,
                                                    AppColors.btnDisableColor,
                                                  ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white70
                                                  .withOpacity(0.8),
                                              offset: Offset(
                                                -6.0,
                                                -6.0,
                                              ),
                                              blurRadius: 16.0,
                                            ),
                                            BoxShadow(
                                              color: AppColors.darkerGrey
                                                  .withOpacity(0.4),
                                              offset: Offset(6.0, 6.0),
                                              blurRadius: 16.0,
                                            ),
                                          ],
                                          color: 1 == 1
                                              ? AppColors.btnColor
                                              : AppColors.btnDisableColor,
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
