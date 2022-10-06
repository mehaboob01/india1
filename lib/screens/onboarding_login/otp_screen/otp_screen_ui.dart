import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:india_one/widgets/screen_bg.dart';

import '../../../constant/routes.dart';
import '../../../constant/theme_manager.dart';

class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => _OtpState();
}

class _OtpState extends State<OtpScreen> {
  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 28;
  int currentSeconds = 0;
  bool? reSendOtp = false;

  final GlobalKey<FormBuilderState> _userOtp = GlobalKey<FormBuilderState>();
  String get timerText => '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if(timer.tick == 28)
          {}
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppColors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: 84,
                    ),
                    Text("Enter OTP",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimens.font_20sp,
                            color: Colors.black87)),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "We have sent you a 4-digit verification code",
                      overflow: TextOverflow.visible,
                      maxLines: 1,
                      style: TextStyle(
                        overflow: TextOverflow.visible,
                        fontWeight: FontWeight.w500,
                        color: AppColors.bgScreenColor,
                        fontSize: Dimens.font_14sp,
                      ),
                    ),
                  ],
                )),
            Spacer(flex: 2),
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24.0, left: 44.0),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.white,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                SizedBox(height: 24),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '9131480982',
                                  style: TextStyle(
                                      fontSize: Dimens.font_14sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                SizedBox(height: 24),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'Edit number',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimens.font_14sp,
                                      color: AppColors.btnColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 32.0, left: 32.0, top: 12.0),
                      child: FormBuilder(
                        key: _userOtp,
                        initialValue: {
                          "otp1": "",
                          "otp2": "",
                          "otp3": "",
                          "otp4": "",
                        },
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  height: 48,
                                  width: 48,
                                  child: FormBuilderTextField(
                                    name: 'otp1',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (value!.length == 1) {
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                    decoration:
                                        InputDecoration(border: InputBorder.none),
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.bgScreenColor)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 48,
                                  width: 48,
                                  child: FormBuilderTextField(
                                    name: 'otp2',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (value!.length == 1) {
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                    decoration:
                                        InputDecoration(border: InputBorder.none),
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.bgScreenColor)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 48,
                                  width: 48,
                                  child: FormBuilderTextField(
                                    name: 'otp3',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (value!.length == 1) {
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                    decoration:
                                        InputDecoration(border: InputBorder.none),
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.bgScreenColor)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 48,
                                  width: 48,
                                  child: FormBuilderTextField(
                                    name: 'otp4',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (value!.length == 1) {
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                    decoration:
                                        InputDecoration(border: InputBorder.none),
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.bgScreenColor)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 56.0, left: 32.0),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.white,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: 24),
                          SizedBox(
                            width: 4,
                          ),
                          Row(

                            children: [
                              Text(
                                "Resend OTP",
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.visible,
                                  color:  AppColors.bgScreenColor,
                                  fontSize: Dimens.font_14sp,
                                ),
                              ),
                              SizedBox(width: 4,),
                              Visibility(
                                visible: currentSeconds == 0?false:true,
                                child: Text(
                                  timerText,
                                  style: TextStyle(
                                    overflow: TextOverflow.visible,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.bgScreenColor,
                                    fontSize: Dimens.font_14sp,
                                  ),
                                ),
                              ),


                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(flex: 3),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: (){

                  Get.offAllNamed(MRouter.verifiedScreen);


                },
                child: Container(
                  width: MediaQuery.of(context).size.height * 0.9,
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white70.withOpacity(0.8),
                        offset: const Offset(
                          -6.0,
                          -6.0,
                        ),
                        blurRadius: 16.0,
                      ),
                      BoxShadow(
                        color: AppColors.darkerGrey.withOpacity(0.4),
                        offset: const Offset(6.0, 6.0),
                        blurRadius: 16.0,
                      ),
                    ],
                    color: AppColors.btnColor,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
            ),
            Spacer(flex: 1),
          ],
      ),
    ),
        ));
  }

  Widget otpBoxBuilder(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 70,
      width: 70,
      child: FormBuilderTextField(
        name: 'otp',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value!.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: InputDecoration(border: InputBorder.none),
      ),
      decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
    );
  }
}
