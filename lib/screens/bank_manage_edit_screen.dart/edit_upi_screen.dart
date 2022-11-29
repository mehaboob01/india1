import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/button_with_flower.dart';
import '../../widgets/loyalty_common_header.dart';
import '../loyality_points/cashback_redeem/cb_manager.dart';
import 'controller/update_bank_account_manager.dart';
import 'controller/update_upi_manager.dart';
import 'delete_bottom_sheet.dart';

class EditUpi extends StatelessWidget {
  double widthIs = 0, heightIs = 0;
  UpdateUpiAccount updateUpiAccount = Get.put(UpdateUpiAccount());
  final GlobalKey<FormBuilderState> _updateUpiAccount =
      GlobalKey<FormBuilderState>();
  CashBackManager cashBackManager = Get.put(CashBackManager());

  String? upiId;
  String? id;

  EditUpi(this.upiId, this.id);

  @override
  Widget build(BuildContext context) {
    print("pi id ======> ${id}");
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
                heading: 'Update UPI details',
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
                        key: _updateUpiAccount,
                        initialValue: {
                          "id": id.toString(),
                          "upiId": upiId.toString(),
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
                                      "Your UPI's",
                                      style: AppStyle.shortHeading.copyWith(
                                        fontSize: Dimens.font_16sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
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
                                            "UPI", //'Points for cashback', // dynamic
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
                                              borderSide: const BorderSide(width: 1.0, color: Colors.blue))),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                      ]),
                                      name: 'upiId',
                                    ),
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
                      label: updateUpiAccount.isLoading == true
                          ? 'Saving..'
                          : 'Save Changes',
                      onPressed: () async {
                        _updateUpiAccount.currentState!.save();

                        print(
                            "upi data for api ${_updateUpiAccount.currentState!.value}");

                        print(_updateUpiAccount.currentState!.value);
                        updateUpiAccount.callUpdateUpiAccount(
                            _updateUpiAccount.currentState!.value, id);
                        await cashBackManager.fetchCustomerBankAccounts();
                        await cashBackManager.fetchCustomerUpiAccounts();
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
