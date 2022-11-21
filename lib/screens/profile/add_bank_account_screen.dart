import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';

import '../../constant/theme_manager.dart';
import 'common/profile_stepper.dart';
import 'controller/profile_controller.dart';

class AddBankAccountScreen extends StatelessWidget {
  AddBankAccountScreen({Key? key}) : super(key: key);

  ProfileController profileController = Get.put(ProfileController());

  GlobalKey<FormState> bankAccountKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  autovalidateMode: profileController.autoValidation.value == true ? AutovalidateMode.always : AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ProfileStepper().textField(
                        controller: profileController.bankNameController.value,
                        label: 'Bank name',
                        hint: 'Enter bank name',
                        vaidation: (value) => profileController.nameValidation(
                          value,
                          'Enter valid bank name',
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ProfileStepper().textField(
                        controller: profileController.accountNumberController.value,
                        label: 'Account number',
                        hint: 'Enter account number',
                        vaidation: (value) => profileController.accountNumberValidation(
                          value,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ProfileStepper().textField(
                        controller: profileController.ifscController.value,
                        label: 'IFSC code',
                        hint: 'Enter IFSC code',
                        vaidation: (value) => profileController.ifscValidation(
                          value,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ProfileStepper().commonDropDown(
                        item: <String>['savings'].map<DropdownMenuItem<String>>((String value) {
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
                        value: profileController.accountType.value == '' ? null : profileController.accountType.value,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => profileController.getBankAccountLoading.value
                            ? CircularProgressIndicator()
                            : InkWell(
                                onTap: () {
                                  profileController.autoValidation.value = true;
                                  if (!bankAccountKey.currentState!.validate()) {
                                    print("Not validate");
                                    Flushbar(
                                      title: "Alert!",
                                      message: "missing some values",
                                      duration: Duration(seconds: 3),
                                    )..show(context);
                                  } else if (profileController.accountType.value == '') {
                                    Flushbar(
                                      title: "Alert!",
                                      message: "Select account type",
                                      duration: Duration(seconds: 3),
                                    )..show(context);
                                  } else {
                                    profileController.addBankAccountData();
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 48,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Spacer(),
                                      Text(
                                        'Save Bank Details',
                                        maxLines: 2,
                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
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
                                        color: Colors.white70.withOpacity(0.8),
                                        offset: Offset(
                                          -6.0,
                                          -6.0,
                                        ),
                                        blurRadius: 16.0,
                                      ),
                                      BoxShadow(
                                        color: AppColors.darkerGrey.withOpacity(0.4),
                                        offset: Offset(6.0, 6.0),
                                        blurRadius: 16.0,
                                      ),
                                    ],
                                    color: 1 == 1 ? AppColors.btnColor : AppColors.btnDisableColor,
                                    borderRadius: BorderRadius.circular(6.0),
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
        ],
      ),
    );
  }
}
