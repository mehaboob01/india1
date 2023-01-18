import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';
import 'package:intl/intl.dart';

import '../../../constant/theme_manager.dart';
import '../../../utils/common_methods.dart';

class ProfileStepper {
  ProfileController profileController = Get.put(ProfileController());
  DateTime? selectedDate;
  DateTime? selectedNomineeDate;

  Widget divider() {
    return Container(
      height: 2,
      color: AppColors.lightGreyColor,
      margin: EdgeInsets.symmetric(horizontal: 10),
    );
  }

  Future<DateTime?> datePicker(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: profileController.dobController.value.text.isNotEmpty
          ? DateTime.parse(DateFormat('yyyy-MM-dd').format(
              DateFormat("dd-MM-yyyy")
                  .parse(profileController.dobController.value.text)))
          : DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );
  }

  InputDecoration inputDecoration({
    required String label,
    String? prefix,
    required String hint,
    Widget? suffix,
  }) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusColor: Colors.blue,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.dimLightGreyColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      labelText: '$label',
      errorStyle: GoogleFonts.roboto(
        fontSize: Dimens.font_14sp,
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: prefix == null || prefix == ''
          ? null
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: text(
                prefix,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightBlack,
                  fontSize: Dimens.font_16sp,
                ),
              ),
            ),
      suffixIcon: suffix,
      hintText: hint,
      hintStyle: TextStyle(
        color: AppColors.dotsColor,
        overflow: TextOverflow.ellipsis,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIconConstraints: BoxConstraints(),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.hintColor,
        fontSize: Dimens.font_16sp,
      ),
      counterText: '',
    );
  }

  Widget textField(
      {required String label,
      String? prefix,
      required String hint,
      bool isDisable = false,
      Function? onTap,
      required TextEditingController controller,
      Widget? suffix,
      FormFieldValidator? vaidation,
      Function? onChanged,
      TextInputType? keyboardType,
      bool? isObscure,
      List<TextInputFormatter>? inputFormatters,
      int? maxLength,
      bool textCap = false}) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      autofocus: false,
      controller: controller,
      obscureText: isObscure ?? false,
      textCapitalization:
          textCap ? TextCapitalization.characters : TextCapitalization.none,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters ?? [],
      maxLength: maxLength,
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      onChanged: (value) {
        if (onChanged != null) {
          return onChanged(value);
        }
      },
      validator: (text) {
        if (vaidation == null) {
          return null;
        } else {
          return vaidation(text);
        }
      },
      readOnly: isDisable,
      style: TextStyle(
        fontFamily: AppFonts.appFont,
        fontWeight: FontWeight.w600,
        color: AppColors.lightBlack,
        fontSize: Dimens.font_16sp,
      ),
      decoration: inputDecoration(
        label: label,
        hint: hint,
        prefix: prefix,
        suffix: suffix,
      ),
    );
  }

  Widget commonDropDown({
    required item,
    required onChanged,
    required hint,
    required label,
    value,
  }) {
    return DropdownButtonFormField(
      items: item,
      onChanged: onChanged,
      value: value,
      hint: text(hint),
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.greyInlineText,
        size: 34,
      ),
      isExpanded: true,
      decoration: inputDecoration(
        label: label,
        hint: hint,
      ),
    );
  }

  Widget personalDetails(
      BuildContext context, GlobalKey<FormState> personalForm,
      {bool? isFromLoan = false,
      bool? isFromInsurance = false,
      LoanType? loanType}) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Form(
          key: personalForm,
          autovalidateMode: profileController.autoValidation.value == true
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(
                "personal_details".tr,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightBlack,
                  fontSize: Dimens.font_18sp,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              textField(
                controller: profileController.firstNameController.value,
                label: 'first_name'.tr,
                hint: 'enter_first_name'.tr,
                vaidation: (value) {
                  if (isFromLoan == true ||
                      isFromInsurance == true ||
                      value.toString().trim().isNotEmpty) {
                    return profileController.nameValidation(
                        value, 'Enter first name min 3 character');
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              textField(
                controller: profileController.lastNameController.value,
                label: 'last_name'.tr,
                hint: 'enter_last_name'.tr,
                vaidation: (value) {
                  if (isFromLoan == true ||
                      isFromInsurance == true ||
                      value.toString().trim().isNotEmpty) {
                    return profileController.nameValidation(
                        value, 'Enter last name min 3 character');
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.name,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              textField(
                controller: profileController.mobileNumberController.value,
                label: 'mobile_num'.tr,
                hint: 'enter_mobile_num'.tr,
                prefix: '+91',
                isDisable: true,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
              ),
              if (loanType != LoanType.FarmLoan &&
                  loanType != LoanType.GoldLoan &&
                  loanType != LoanType.BikeLoan &&
                  loanType != LoanType.CarLoan) ...[
                SizedBox(
                  height: 20,
                ),
                textField(
                  controller: profileController.alternateNumberController.value,
                  label: 'alt_num'.tr,
                  hint: 'enter_alt_num'.tr,
                  prefix: '+91',
                  vaidation: (value) {
                    if (value.toString().trim().isNotEmpty) {
                      return profileController.mobileValidation(value);
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  maxLength: 10,
                ),
              ],
              SizedBox(
                height: 20,
              ),
              textField(
                controller: profileController.emailController.value,
                label: 'email_id'.tr,
                hint: 'enter_email_id'.tr,
                vaidation: (value) {
                  if (isFromLoan == true ||
                      isFromInsurance == true ||
                      value.toString().trim().isNotEmpty) {
                    return profileController.emailValidation(value);
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
              ),
              if (loanType != LoanType.FarmLoan &&
                  loanType != LoanType.GoldLoan &&
                  loanType != LoanType.BikeLoan &&
                  loanType != LoanType.CarLoan) ...[
                SizedBox(
                  height: 20,
                ),
                textField(
                  controller: profileController.dobController.value,
                  label: 'date_of_birth'.tr,
                  hint: 'DD-MM-YYYY',
                  suffix: Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.greyText,
                  ),
                  onTap: () async {
                    selectedDate = await datePicker(context);
                    if (selectedDate != null) {
                      String date =
                          DateFormat('dd-MM-yyyy').format(selectedDate!);
                      profileController.dobController.value.text = date;
                    }
                  },
                  isDisable: true,
                  vaidation: (value) {
                    if (isFromLoan == true ||
                        isFromInsurance == true ||
                        value.toString().trim().isNotEmpty) {
                      return profileController.nullCheckValidation(
                        value,
                        'Enter DOB',
                      );
                    } else {
                      return null;
                    }
                  },
                ),
              ],
              SizedBox(
                height: 20,
              ),
              if (loanType != LoanType.FarmLoan) ...[
                text(
                  "gender".tr,
                  style: TextStyle(
                    color: AppColors.lightBlack,
                    fontSize: Dimens.font_14sp,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                    () => Row(
                      children: [
                        radioButton(
                          value: 'Male',
                          callBack: (value) {
                            profileController.gender.value = value.toString();
                          },
                          groupValue: profileController.gender.value,
                        ),
                        radioButton(
                          value: 'Female',
                          callBack: (value) {
                            profileController.gender.value = value.toString();
                          },
                          groupValue: profileController.gender.value,
                        ),
                        radioButton(
                          value: 'Others',
                          callBack: (value) {
                            profileController.gender.value = value.toString();
                          },
                          groupValue: profileController.gender.value,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (loanType != LoanType.FarmLoan &&
                  loanType != LoanType.GoldLoan &&
                  loanType != LoanType.BikeLoan &&
                  loanType != LoanType.CarLoan) ...[
                SizedBox(
                  height: 20,
                ),
                commonDropDown(
                  item: <String>['Single', 'Married', 'Widowed', 'Divorced']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: text(value.tr.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    profileController.maritalStatus.value = value;
                  },
                  label: 'maritial_status'.tr,
                  hint: 'select_maritial_status'.tr,
                  value: profileController.maritalStatus.value == ''
                      ? null
                      : profileController.maritalStatus.value,
                ),
              ],
              if (loanType == LoanType.BikeLoan ||
                  loanType == LoanType.CarLoan ||
                  isFromInsurance == true) ...[
                SizedBox(
                  height: 20,
                ),
                textField(
                  controller: profileController.panNumberController.value,
                  label: 'PAN number',
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    UpperCaseTextFormatter()
                  ],
                  hint: 'Enter your PAN number here',
                  vaidation: (value) {
                    if (isFromLoan == true ||
                        isFromInsurance == true ||
                        value.toString().trim().isNotEmpty) {
                      return profileController.panValidation(
                        value,
                      );
                    }
                    return null;
                  },
                ),
              ],
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget radioButton({
    required String value,
    required String groupValue,
    required Function callBack,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: (value.toLowerCase() == profileController.gender.value)
              ? AppColors.homeGradient1Color
              : AppColors.greySecond,
          width: 2,
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Radio(
            activeColor: AppColors.homeGradient1Color,
            value: value,
            groupValue: groupValue,
            onChanged: (value) => callBack(value),
          ),
          text(value.tr),
          SizedBox(
            width: 6,
          )
        ],
      ),
    );
  }

  Widget residentialDetails(GlobalKey<FormState> residentialForm,
      {bool? isFromLoan = false,
      bool? isFromInsurance = false,
      LoanType? loanType}) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Form(
          key: residentialForm,
          autovalidateMode: profileController.autoValidation.value == true
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(
                "residential_details".tr,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightBlack,
                  fontSize: Dimens.font_18sp,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              textField(
                controller: profileController.addressLine1Controller.value,
                label: 'Address Line 1',
                hint: 'Enter door no, cross, etc',
                vaidation: (value) {
                  if (isFromLoan == true ||
                      isFromInsurance == true ||
                      value.toString().trim().isNotEmpty) {
                    return profileController.nullCheckValidation(
                      value,
                      'Enter address line 1',
                    );
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              textField(
                  controller: profileController.addressLine2Controller.value,
                  label: 'Address Line 2',
                  hint: 'Enter area, road, landmark, etc',
                  vaidation: (value) {
                    if (value.toString().trim().isNotEmpty) {
                      return profileController.nullCheckValidation(
                        value,
                        'Enter address line 2',
                      );
                    }
                    return null;
                  }),
              SizedBox(
                height: 20,
              ),
              textField(
                controller: profileController.pincodeController.value,
                label: 'Pincode',
                hint: 'Enter pincode here',
                vaidation: (value) {
                  if (isFromLoan == true ||
                      isFromInsurance == true ||
                      value.toString().trim().isNotEmpty) {
                    return profileController.pinCodeValidation(
                      value,
                    );
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.toString().trim().length == 6) {
                    profileController.city.value = '';
                    profileController.state.value = '';
                    profileController.getCityState(value);
                  } else {
                    profileController.city.value = '';
                    profileController.state.value = '';
                  }
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() => fixedContainer(
                    title: 'City : Enter Pincode to view city',
                    value: profileController.city.value,
                  )),
              SizedBox(
                height: 20,
              ),
              if (loanType == LoanType.FarmLoan) ...[
                Obx(() => fixedContainer(
                      title: 'District : Enter Pincode to view district',
                      value: profileController.city.value,
                    )),
                SizedBox(
                  height: 20,
                ),
              ],
              Obx(() => fixedContainer(
                    title: 'State : Enter Pincode to view state',
                    value: profileController.state.value,
                  )),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container fixedContainer({required String title, required String? value}) {
    return Container(
      height: 60,
      width: Get.width,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 16, right: 8),
      child: text(
        value == null || value == '' ? title : value,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: value == null || value == ''
              ? AppColors.hintColor
              : AppColors.lightBlack,
          fontSize: Dimens.font_18sp,
        ),
      ),
      decoration: BoxDecoration(
        color: AppColors.dimLightGreyColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget occupationDetails(GlobalKey<FormState> occupationForm,
      {bool? isFromLoan = false, bool? isFromInsurance = false}) {
    var temp;
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Form(
          key: occupationForm,
          autovalidateMode: profileController.autoValidation.value == true
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(
                "occupation_details".tr,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightBlack,
                  fontSize: Dimens.font_18sp,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              commonDropDown(
                item: [
                  {"name": "Self Employed", "value": "SelfEmployed"},
                  {"name": "Salaried", "value": "Salaried"},
                  {"name": "Business Owner", "value": "BusinessOwner"},
                  {"name": "Other", "value": "Other"},
                ].map((value) {
                  return DropdownMenuItem(
                    value: value['value'],
                    child: text(value['name'].toString()),
                  );
                }).toList(),
                value: profileController.employmentType.value.isEmpty ||
                        profileController.employmentType.value.contains("null")
                    ? null
                    : profileController.employmentType.value,
                onChanged: (value) {
                  profileController.employmentType.value = value;
                },
                label: isFromInsurance == true
                    ? 'Occupation type'
                    : 'Employment type',
                hint: isFromInsurance == true
                    ? 'Select an option'
                    : 'Choose your employment type',
              ),
              SizedBox(
                height: 20,
              ),
              if (!isFromInsurance!) ...[
                textField(
                  controller: profileController.occupationController.value,
                  label: 'Occupation',
                  hint: 'Enter what you do here',
                  vaidation: (value) {
                    if (isFromLoan == true ||
                        value.toString().trim().isNotEmpty) {
                      return profileController.nameValidation(
                        value,
                        'Enter Occupation of min 3 char',
                      );
                    }
                    return null;
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                ),
                if (isFromLoan == true || isFromInsurance == true) ...[
                  SizedBox(
                    height: 20,
                  ),

                  commonDropDown(
                    item: [
                      {"name": "Cash", "value": "Cash"},
                      {"name": "Cheque", "value": "Cheque"},
                      {"name": "BankTransfer", "value": "BankTransfer"},
                      {"name": "PayCards", "value": "PayCards"},
                    ].map((value) {
                      return DropdownMenuItem(
                        value: value['value'],
                        child: text(value['name'].toString()),
                      );
                    }).toList(),
                    value: profileController.accountType.value.isEmpty ||
                            profileController.accountType.value.contains("null")
                        ? null
                        : profileController.accountType.value,
                    onChanged: (value) {
                      profileController.accountType.value = value;
                    },
                    label: 'Salary Mode',
                    hint: 'Salary Mode',
                  ),

                  // ButtonTheme(
                  //   alignedDropdown: true,
                  //   child: commonDropDown(
                  //     item: ['Cash', 'Cheque', 'BankTransfer', 'PayCards']
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: text(value.toString()),
                  //       );
                  //     }).toList(),
                  //     value: profileController.accountType.value.isEmpty
                  //         ? null
                  //         : profileController.accountType.value,
                  //     onChanged: (value) {
                  //       if (isFromLoan == true) {
                  //         profileController.accountType!.value = value;
                  //       }
                  //       temp = value;
                  //     },
                  //     label: 'Salary Mode',
                  //     hint: 'Salary Mode',
                  //   ),
                  // ),
                ],
                SizedBox(
                  height: 20,
                ),
              ],
              textField(
                controller: profileController.monthlyIncomeController.value,
                label: 'Monthly income',
                hint: 'Enter monthly income',
                prefix: '₹',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  CurrencyInputFormatter(),
                ],
                vaidation: (value) {
                  if (isFromLoan == true ||
                      isFromInsurance == true ||
                      value.toString().trim().isNotEmpty) {
                    return profileController.nullCheckValidation(
                      value,
                      'Enter valid amount',
                    );
                  }
                  return null;
                },
                onChanged: (val) {
                  // profileController.monthlyIncomeController.value.text =
                  //     (int.parse((val).replaceAll(",", "").replaceAll(".", ""))
                  //             .priceString())
                  //         .toString();
                  // profileController.monthlyIncomeController.value.selection =
                  //     TextSelection.collapsed(
                  //         offset: profileController
                  //             .monthlyIncomeController.value.text.length);
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              isFromInsurance == true
                  ? SizedBox.shrink()
                  : textField(
                      controller: profileController.panNumberController.value,
                      label: 'PAN number',
                      hint: 'Enter your PAN number here',
                      textCap: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z0-9]")),
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(10)
                      ],
                      onChanged: (value) {},
                      vaidation: (value) {
                        if (isFromLoan == true ||
                            isFromInsurance == true ||
                            value.toString().trim().isNotEmpty) {
                          return profileController.panValidation(
                            value,
                          );
                        }
                        return null;
                      },
                    ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nomineeDetails(BuildContext context, GlobalKey<FormState> nomineeForm,
      {bool? isFromLoan = false, bool? isFromInsurance = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Form(
          key: nomineeForm,
          autovalidateMode: profileController.autoValidation.value == true
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(
                "Nominee",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightBlack,
                  fontSize: Dimens.font_18sp,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              textField(
                controller: profileController.nomineeNameController.value,
                label: 'Nominee name',
                hint: 'Mention nominee name',
                vaidation: (value) {
                  if (isFromInsurance == true ||
                      value.toString().trim().isNotEmpty) {
                    return profileController.nameValidation(
                      value,
                      'Enter name of min 3 char',
                    );
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              commonDropDown(
                item: <String>['Father', 'Mother', 'Spouse', 'Son', 'Daughter']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: text(value.toString()),
                  );
                }).toList(),
                value: profileController.nomineeRelationship.value == ''
                    ? null
                    : profileController.nomineeRelationship.value,
                onChanged: (value) {
                  profileController.nomineeRelationship.value = value;
                },
                label: 'Relationship',
                hint: 'Relationship with you',
              ),
              SizedBox(
                height: 20,
              ),
              textField(
                controller: profileController.nomineeDobController.value,
                label: 'Date of birth (DD-MM-YYYY)',
                hint: 'DD-MM-YYYY',
                suffix: Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.greyText,
                ),
                onTap: () async {
                  selectedNomineeDate = await datePicker(context);
                  String date = DateFormat('yyyy-MM-dd')
                      .format(selectedNomineeDate ?? DateTime.now());
                  profileController.nomineeDobController.value.text = date;
                },
                isDisable: true,
                vaidation: (value) {
                  if (value.toString().trim().isNotEmpty) {
                    return profileController.nullCheckValidation(
                      value,
                      'Enter DOB',
                    );
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget healthStepper(
      GlobalKey<FormState>
          nomineeForm /* GlobalKey<FormState> nomineeForm,
      {bool? isFromLoan = false}*/
      ) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Form(
          key: nomineeForm,
          autovalidateMode: profileController.autoValidation.value == true
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(
                "Proposed member's health",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              text(
                "Do the proposed member to be insured suffer from below listed issues?",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Container(
                decoration: BoxDecoration(
                    // color:
                    color: Colors.grey.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8)),
                width: double.maxFinite,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
                  child: text(
                    """
Diabetes, Hypertension, Thyroid Disorder, Nervous 
disorder, fits, mental condition, heart & circulatory disorder, Respiratory disorder, Disorders of stomach including intestine, Kidney stones, Prostrate disorder, Disorder of spine and joints, Tumours or cancer, Ever reported positive for hepatitis B, HIV / AIDS or other sexually transmitted disease or is pregnant at the time of application
data""",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              /* Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pickBox("Yes"),
                  pickBox("No"),
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),*/
              text(
                "Do any of the proposed members to be insured suffer from any  pre-existing diseases?",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.11),
                    borderRadius: BorderRadius.circular(8)),
                width: double.maxFinite,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
                  child: text(
                    """
Please choose “Yes” in case any of the proposed person to be insured has been / are under any continuous medication for treatment for any illness (Excluding vitamins, supplements) or under treatment for any illness.""",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     pickBox("Yes"),
              //     pickBox("No"),
              //   ],
              // ),
              // SizedBox(
              //   height: Get.height * 0.01,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  pickBox(String? text) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          height: Get.height * 0.055,
          width: Get.width * 0.43,
          child: radioButton(
              value: text.toString(),
              groupValue: "groupValue",
              callBack: () {})),
    );
  }

  Widget additionalDetails(GlobalKey<FormState> additionalForm,
      {bool? isFromLoan}) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Form(
          key: additionalForm,
          // autovalidateMode: profileController.autoValidation.value == true
          //     ? AutovalidateMode.always
          //     : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(
                "additional_information".tr,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightBlack,
                  fontSize: Dimens.font_18sp,
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              textField(
                controller: profileController.noOfMonthsResiding.value,
                label: 'No. of months residing at',
                hint: 'Enter the no. of months residing at',
                vaidation: (value) {
                  if (value.toString().trim().isEmpty) {
                    return "Number of months is mandatory";
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              commonDropDown(
                item: [
                  {"name": "Engineer", "value": "Engineer"},
                  {"name": "Graduate", "value": "Graduate"},
                  {"name": "Masters", "value": "Masters"},
                  {"name": "NonGraduate", "value": "NonGraduate"},
                  {"name": "MBA", "value": "MBA"},
                ].map((value) {
                  return DropdownMenuItem(
                    value: value['value'],
                    child: text(value['name'].toString()),
                  );
                }).toList(),
                value: profileController
                            .highestQualification.value.text.isEmpty ||
                        profileController.highestQualification.value.text
                            .contains("null")
                    ? null
                    : profileController.highestQualification.value.text.trim(),
                onChanged: (highestQualification) {
                  profileController.highestQualification.value.text =
                      highestQualification;
                  //   print("highest qualification ${profileController.highestQualification.value.text.toString()}");
                },
                label: 'Highest Qualification',
                hint: 'Choose your Highest qualification',
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              textField(
                controller: profileController.companyName.value,
                label: 'Company name',
                hint: 'Enter the company name',
                vaidation: (value) {
                  if (value.toString().trim().isEmpty) {
                    return "Company name is mandatory";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              textField(
                controller: profileController.designation.value,
                label: 'Designation',
                hint: 'Enter the Designation',
                vaidation: (value) {
                  if (value.toString().trim().isEmpty) {
                    return "Designation is mandatory";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              textField(
                controller: profileController.workExp.value,
                label: 'Work Experience in months',
                hint: 'Enter the Work experience',
                vaidation: (value) {
                  if (value.toString().trim().isEmpty) {
                    return "Work experience is mandatory";
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              textField(
                controller:
                    profileController.officeAddressLine1Controller.value,
                label: 'Office address line 1',
                hint: 'Enter the Office address line 1',
                vaidation: (value) {
                  if (value.toString().trim().isEmpty) {
                    return "Office address is mandatory";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              textField(
                controller:
                    profileController.officeAddressLine2Controller.value,
                label: 'Office address line 2',
                hint: 'Enter the Office address line 2',
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.1,
                  ),
                  text(
                    "Do you use Netbanking?",
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: Dimens.font_14sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => Row(
                    children: [
                      radioButton(
                        value: 'Yes  ',
                        callBack: (value) {
                          profileController.netbanking.value = value.toString();
                        },
                        groupValue: profileController.netbanking.value,
                      ),
                      radioButton(
                        value: 'No   ',
                        callBack: (value) {
                          profileController.netbanking.value = value.toString();
                        },
                        groupValue: profileController.netbanking.value,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.1,
                  ),
                  text(
                    "Do you have any existing loan?",
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: Dimens.font_14sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => Row(
                    children: [
                      radioButton(
                        value: 'Yes  ',
                        callBack: (value) {
                          profileController.existingLoan.value =
                              value.toString();
                        },
                        groupValue: profileController.existingLoan.value,
                      ),
                      radioButton(
                        value: 'No   ',
                        callBack: (value) {
                          profileController.existingLoan.value =
                              value.toString();
                        },
                        groupValue: profileController.existingLoan.value,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              if (profileController.existingLoan
                      .toLowerCase()
                      .replaceAll(' ', '') ==
                  'yes')
                textField(
                    keyboardType: TextInputType.number,
                    controller: profileController.activeOrExistingLoans.value,
                    label: 'No. of active / existing loans',
                    hint: 'Enter the no. of active / existing loans',
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                    onChanged: (value) {
                      // profileController.activeOrExistingLoans.value.text =
                      //     value;
                    }),
            ],
          ),
        ),
      ),
    );
  }
}
