import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';
import 'package:intl/intl.dart';

import '../../../constant/theme_manager.dart';

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
      initialDate: selectedDate ?? DateTime.now(),
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
              child: Text(
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
    );
  }

  Widget textField({
    required String label,
    String? prefix,
    required String hint,
    bool isDisable = false,
    Function? onTap,
    required TextEditingController controller,
    Widget? suffix,
    FormFieldValidator? vaidation,
    Function? onChanged,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters ?? [],
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
        fontFamily: 'Graphik',
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
      hint: Text(hint),
      icon: Icon(Icons.keyboard_arrow_down),
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
              Text(
                "Personal Details",
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
                label: 'First Name',
                hint: 'Enter your first name',
                vaidation: (value) {
                  if (isFromLoan == true ||
                      isFromInsurance == true ||
                      value.toString().trim().isNotEmpty) {
                    return profileController.nameValidation(
                        value, '*First Name is Mandatory');
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 20,
              ),
              textField(
                controller: profileController.lastNameController.value,
                label: 'Last Name',
                hint: 'Enter your last name',
                vaidation: (value) {
                  if (isFromLoan == true ||
                      isFromInsurance == true ||
                      value.toString().trim().isNotEmpty) {
                    return profileController.nameValidation(
                        value, '*Last Name is Mandatory');
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 20,
              ),
              textField(
                controller: profileController.mobileNumberController.value,
                label: 'Mobile number',
                hint: 'Enter mobile number',
                prefix: '+91',
                isDisable: true,
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
                  label: 'Alternate number',
                  hint: 'Enter alternate number',
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
                ),
              ],
              SizedBox(
                height: 20,
              ),
              textField(
                controller: profileController.emailController.value,
                label: 'Email ID',
                hint: 'Enter email ID here',
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
                  label: 'Date of birth (DD-MM-YYYY)',
                  hint: 'yyyy-MM-dd',
                  suffix: Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.greyText,
                  ),
                  onTap: () async {
                    selectedDate = await datePicker(context);
                    String date = DateFormat('yyyy-MM-dd')
                        .format(selectedDate ?? DateTime.now());
                    profileController.dobController.value.text = date;
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
                Text(
                  "Gender",
                  style: TextStyle(
                    color: AppColors.lightBlack,
                    fontSize: Dimens.font_14sp,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SingleChildScrollView(
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
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    profileController.maritalStatus.value = value;
                  },
                  label: 'Marital status',
                  hint: 'Select your marital status',
                  value: profileController.maritalStatus.value == ''
                      ? null
                      : profileController.maritalStatus.value,
                ),
              ],
              if (loanType == LoanType.BikeLoan ||
                  loanType == LoanType.CarLoan) ...[
                SizedBox(
                  height: 20,
                ),
                textField(
                  controller: profileController.panNumberController.value,
                  label: 'PAN number',
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
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Radio(
            activeColor: AppColors.homeGradient1Color,
            value: value,
            groupValue: groupValue,
            onChanged: (value) => callBack(value),
          ),
          Text(value),
          SizedBox(
            width: 16,
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
              Text(
                "Residential Address",
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
                hint: 'Enter Door # , Building name, Flat #',
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
                  hint: 'Enter area, landmark etc',
                  vaidation: (value) {
                    if (value.toString().trim().isNotEmpty) {
                      profileController.nullCheckValidation(
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
                    profileController.pinCodeValidation(
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
      child: Text(
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
              Text(
                "Occupation",
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
              ButtonTheme(
                alignedDropdown: true,
                child: commonDropDown(
                  item: <String>[
                    'Self Employed',
                    'Salaried',
                    'Business Owner',
                    'Other'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  value: profileController.employmentType.value == ''
                      ? null
                      : profileController.employmentType.value,
                  onChanged: (value) {
                    profileController.employmentType.value = value;
                  },
                  label: 'Choose your employment type',
                  hint: 'Choose your employment type',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // textField(
              //   controller: profileController.occupationController.value,
              //   label: 'Occupation',
              //   hint: 'Enter what you do here',
              //   vaidation: (value) {
              //     if (isFromLoan == true ||
              //         value.toString().trim().isNotEmpty) {
              //       profileController.nameValidation(
              //         value,
              //         'Enter Occupation of min 3 char',
              //       );
              //     }
              //     return null;
              //   },
              // ),

              if (!isFromInsurance!) ...[
                ButtonTheme(
                  alignedDropdown: true,
                  child: commonDropDown(
                    item: ['Cash', 'Cheque', 'BankTransfer', 'PayCards']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                    // value: profileController.accountType == ''
                    //     ? null
                    //     : profileController.accountType.value,
                    onChanged: (value) {
                      temp = value;
                    },
                    label: 'Salary Mode',
                    hint: 'Salary Mode',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],

              textField(
                controller: profileController.monthlyIncomeController.value,
                label: 'Monthly income',
                hint: 'Enter monthly income',
                prefix: '₹',
                vaidation: (value) {
                  if (isFromLoan == true ||
                      isFromInsurance == true ||
                      value.toString().trim().isNotEmpty) {
                   return  profileController.nullCheckValidation(
                      value,
                      'Enter valid amount',
                    );
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              textField(
                controller: profileController.panNumberController.value,
                label: 'PAN number',
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
              Text(
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
                  if (value.toString().trim().isNotEmpty) {
                    if (profileController.nullCheckValidation(
                          value,
                          'Enter name',
                        ) ??
                        false) {
                      return profileController.nameValidation(
                        value,
                        'Enter name of min 3 char',
                      );
                    }
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
                    child: Text(value.toString()),
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
              Text(
                "Proposed member's health",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
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
                  child: Text(
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
              Text(
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
                  child: Text(
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
}
