import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:india_one/widgets/screen_bg.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../constant/routes.dart';
import '../../../constant/theme_manager.dart';

import 'otp_manager.dart';

class OtpScreen extends StatefulWidget {
  String? phoneNumber;

  OtpScreen(this.phoneNumber);

  @override
  State<OtpScreen> createState() => _OtpState();
}

class _OtpState extends State<OtpScreen> {
  final interval =  Duration(seconds: 1);
  OtpManager _otpManager = Get.put(OtpManager());

  String? codeValue = '';
  static const timerMaxSeconds = 28;
  int currentSeconds = timerMaxSeconds;
  Timer? timer;

  void startTimer()
  {
    timer = Timer.periodic(Duration(seconds: 1), (_) {

    setState(() {
      currentSeconds--;
      if(currentSeconds == 0) timer!.cancel();
    });
    });
  }




  final GlobalKey<FormBuilderState> _userOtp = GlobalKey<FormBuilderState>();
  String get timerText => '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    listenOtp();
    startTimer();
    //startTimeout();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: AppColors.white,
                child: Stack(
                  children: [BgScreen(), buildOtpCard()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOtpCard() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 524,
          child: Padding(
            padding:  EdgeInsets.all(24.0),
            child: Column(
              children: [
                FormBuilder(
                  key: _userOtp,
                  initialValue: {
                    "mobile": "",
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 12.0,
                                  right: 12.0,
                                ),
                                child: Image.asset(
                                  "assets/images/india_one_logo.png",
                                  width: 120,
                                  height: 90,
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 12.0,
                                  right: 12.0,
                                ),
                                child: Obx(()=>
                                   Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _otpManager.resendOtpLoading == true?

                                      Text(
                                        "Resending OTP",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black,
                                          fontSize: Dimens.font_20sp,
                                        ),
                                      ):
                                      _otpManager.isLoading == true?
                                      Row(
                                        children: [
                                          Text(
                                            "Verifying..",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.black,
                                              fontSize: Dimens.font_20sp,
                                            )
                                          ),
                                          SizedBox(width: 4,),
                                          Container(
                                              height: 16,
                                              width: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.0,
                                                color: AppColors.facebookBlue,
                                              ))
                                        ],
                                      ):Text(
                                        "Enter OTP",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black,
                                          fontSize: Dimens.font_20sp,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "We sent it to the number",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.black,
                                              fontSize: Dimens.font_14sp,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            widget.phoneNumber.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.facebookBlue,
                                              fontSize: Dimens.font_14sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      Padding(
                          padding: EdgeInsets.only(
                            left: 12.0,
                            right: 12.0,
                          ),
                          child: PinFieldAutoFill(
                            currentCode: codeValue,
                            onCodeChanged: (code) {
                              setState(() {
                                codeValue = code.toString();
                              });
                            },
                            codeLength: 4,
                            onCodeSubmitted: (val) {
                              _otpManager.callVerifyOtpApi(
                                  codeValue.toString(), context);
                            },
                          )),
                      SizedBox(height: 14),
                      Obx(
                        ()=> Padding(
                          padding: EdgeInsets.only(
                            left: 12.0,
                            right: 12.0,
                          ),
                          child: Visibility(
                            visible:
                                _otpManager.wrongOtp == true ? true : false,
                            child: Text(
                              "Invalid OTP entered. Please enter valid OTP",
                              overflow: TextOverflow.visible,
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.visible,
                                fontWeight: FontWeight.w500,
                                color: AppColors.googleRed,
                                fontSize: Dimens.font_12sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 12.0,
                          right: 12.0,
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.offAllNamed(MRouter.userLogin);
                              },
                              child: Text(
                                "Edit Number",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                  fontSize: Dimens.font_14sp,
                                ),
                              ),
                            ),
                            Spacer(),
                            Obx(
                              () => _otpManager.resendOtpLoading == false
                                  ? GestureDetector(
                                      onTap: () {
                                        if(currentSeconds == 0)
                                        _otpManager.callResendOtpApi(
                                            widget.phoneNumber.toString(),
                                            context,
                                            true);
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'Resend OTP',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.facebookBlue,
                                              fontSize: Dimens.font_14sp,
                                            ),
                                          ),
                                          SizedBox(width: 4,),
                                          Visibility(
                                            visible: currentSeconds == 0 ? false : true,
                                            child: Text(
                                              'in',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.facebookBlue,
                                                fontSize: Dimens.font_14sp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 6,),
                                          Visibility(
                                            visible: currentSeconds == 0 ? false : true,
                                            child: SizedBox(
                                              width: 22,
                                              height: 22,
                                              child: Stack(


                                                children:[
                                                  CircularProgressIndicator(
                                                    valueColor: AlwaysStoppedAnimation(Colors.green),
                                                    backgroundColor: AppColors.facebookBlue,
                                                    strokeWidth: 2,
                                                    value: currentSeconds/timerMaxSeconds,
                                                  ),


                                                  Center(
                                                    child: Padding(
                                                      padding:  EdgeInsets.all(2),
                                                      child: Text(currentSeconds.toString(),
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        color: AppColors.facebookBlue,
                                                        fontSize: Dimens.font_14sp,
                                                      ),
                                                ),
                                                    ),
                                                  ),]
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          'Sending',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.facebookBlue,
                                            fontSize: Dimens.font_14sp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Container(
                                            height: 16,
                                            width: 16,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.0,
                                              color: AppColors.facebookBlue,
                                            ))
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          decoration: BoxDecoration(
              borderRadius:  BorderRadius.only(
                topRight: Radius.circular(44),
                topLeft: Radius.circular(44),
              ),
              border: Border.all(
                color: AppColors.white,
                width: 0.5,
              ),
              // radius of 10
              color: AppColors.white // green as background color
              )),
    );
  }

  void listenOtp() async {
    // await SmsAutoFill().unregisterListener();
    // listenForCode();
    await SmsAutoFill().listenForCode;
    print("OTP listen Called");
  }


}
