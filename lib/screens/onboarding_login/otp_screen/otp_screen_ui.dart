import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_one/widgets/screen_bg.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../constant/routes.dart';
import '../../../constant/theme_manager.dart';

import '../user_login/login_manager.dart';
import 'otp_manager.dart';

class OtpScreen extends StatefulWidget {
  String? phoneNumber;
  int? retryInSeconds;

  OtpScreen(this.phoneNumber, this.retryInSeconds);

  @override
  State<OtpScreen> createState() => _OtpState();
}

class _OtpState extends State<OtpScreen> with CodeAutoFill {
  var _otpController = TextEditingController();

  final interval = Duration(seconds: 1);
  OtpManager _otpManager = Get.put(OtpManager());
  LoginManager _loginManager = Get.put(LoginManager());
  String? codeValue = '';
  //static const timerMaxSeconds = 28;
  int currentSeconds = 0;
  Timer? timer;
  bool isBlue = false;

  void startTimer(int? seconds) {
    currentSeconds = seconds ?? widget.retryInSeconds!;

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (mounted)
        setState(() {
          currentSeconds--;
          if (currentSeconds == 0) {
            isBlue = true;
            timer!.cancel();
          }
          ;
        });
    });
  }

  final GlobalKey<FormBuilderState> _userOtp = GlobalKey<FormBuilderState>();
  String get timerText =>
      '${((widget.retryInSeconds! - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((widget.retryInSeconds! - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= currentSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    listenOtp();
    startTimer(null);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SmsAutoFill().unregisterListener();
    timer!.cancel();
    super.dispose();
  }

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: AppColors.white,
                    child: Stack(
                      children: [
                        LoginBgScreen(AppImages.newOtpBgPng),
                        buildOtpCard()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOtpCard() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Padding(
            padding: EdgeInsets.all(24.0),
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
                                height: 16,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 12.0,
                                  right: 12.0,
                                ),
                                child: Obx(
                                  () => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _otpManager.resendOtpLoading == true
                                          ? Text(
                                              "Resending OTP",
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontFamily: AppFonts.appFont,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.black,
                                                fontSize: 26,
                                              ),
                                            )
                                          : _otpManager.isLoading == true
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      "Verifying..",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            AppFonts.appFont,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors.black,
                                                        fontSize: 26,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Container(
                                                        height: 16,
                                                        width: 16,
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 2.0,
                                                          color: AppColors
                                                              .facebookBlue,
                                                        ))
                                                  ],
                                                )
                                              : Text(
                                                  "enter_otp".tr,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppFonts.appFont,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.black,
                                                    fontSize: 26,
                                                  ),
                                                ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Text(
                                              "otp_message".tr,
                                              style: TextStyle(
                                                fontFamily: AppFonts.appFont,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.black,
                                                fontSize: Dimens.font_16sp,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              widget.phoneNumber.toString(),
                                              style: TextStyle(
                                                fontFamily: AppFonts.appFont,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.black,
                                                fontSize: Dimens.font_16sp,
                                              ),
                                            ),
                                          ],
                                        ),
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
                          child: Column(
                            children: [
                              PinFieldAutoFill(
                                decoration: UnderlineDecoration(
                                  lineHeight: 1,
                                  hintText: '••••',
                                  hintTextStyle: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.dotsColor,
                                      fontSize: Dimens.font_24sp),
                                  textStyle: TextStyle(
                                      fontFamily: AppFonts.appFont,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                      fontSize: Dimens.font_24sp),
                                  colorBuilder: FixedColorBuilder(Colors.grey),
                                ),
                                currentCode: codeValue,
                                cursor: Cursor(
                                  width: 2,
                                  height: 40,
                                  color: AppColors.primary,
                                  radius: Radius.circular(1),
                                  enabled: true,
                                ),
                                onCodeChanged: (code) {
                                  setState(() {
                                    codeValue = code.toString();
                                  });
                                  if (codeValue!.length == 4) {
                                    FocusScope.of(context).unfocus();
                                    _otpManager.callVerifyOtpApi(
                                        codeValue.toString(), context);
                                  }
                                  _otpManager.wrongOtp.value = false;
                                },
                                codeLength: 4,
                                controller: _otpController,
                              ),
                            ],
                          )),
                      SizedBox(height: 14),
                      Obx(
                        () => Padding(
                          padding: EdgeInsets.only(
                            left: 12.0,
                            right: 12.0,
                          ),
                          child: Visibility(
                            visible: _otpManager.wrongOtp.value == true
                                ? true
                                : false,
                            child: Text(
                              "invalid_otp".tr,
                              overflow: TextOverflow.visible,
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: AppFonts.appFont,
                                overflow: TextOverflow.visible,
                                fontWeight: FontWeight.w500,
                                color: AppColors.googleRed,
                                fontSize: Dimens.font_14sp,
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
                                _otpManager.wrongOtp.value = false;
                                Get.offAllNamed(MRouter.userLogin);
                              },
                              child: Text(
                                "edit_number".tr,
                                style: TextStyle(
                                  fontFamily: AppFonts.appFont,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.cardBg1,
                                  fontSize: Dimens.font_16sp,
                                ),
                              ),
                            ),
                            Spacer(),
                            Obx(
                              () => _otpManager.resendOtpLoading.value == false
                                  ? GestureDetector(
                                      onTap: () async {
                                        if (currentSeconds == 0) {
                                          FocusScope.of(context).unfocus();
                                          var appSignatureId =
                                              await SmsAutoFill()
                                                  .getAppSignature;

                                          _loginManager.callSentOtpApi(
                                              widget.phoneNumber.toString(),
                                              context,
                                              true,
                                              appSignatureId,
                                              true);
                                          listenOtp();
                                          startTimer(30);

                                          // listenOtp();

                                          // _otpManager
                                          //     .callResendOtpApi(
                                          //         widget.phoneNumber.toString(),
                                          //         context,
                                          //         true)
                                          //     .then((value) {
                                          //   print("value ==> $value");
                                          //   if (value == true) {
                                          //     _otpController.clear();
                                          //     currentSeconds = 28;
                                          //     startTimer();
                                        } else {}
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'resend_otp'.tr,
                                            style: TextStyle(
                                              fontFamily: AppFonts.appFont,
                                              fontWeight: FontWeight.w600,
                                              color: isBlue
                                                  ? AppColors.cardBg1
                                                  : AppColors.greyText,
                                              fontSize: Dimens.font_16sp,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Visibility(
                                            visible: currentSeconds == 0
                                                ? false
                                                : true,
                                            child: Text(
                                              'in'.tr,
                                              style: TextStyle(
                                                fontFamily: AppFonts.appFont,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.greyText,
                                                fontSize: Dimens.font_16sp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Visibility(
                                            visible: currentSeconds == 0
                                                ? false
                                                : true,
                                            child: SizedBox(
                                              width: 58,
                                              height: 22,
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(2),
                                                  child: Text(
                                                    "00:" +
                                                        currentSeconds
                                                            .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppFonts.appFont,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColors.greyText,
                                                      fontSize:
                                                          Dimens.font_16sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          'sending_otp'.tr,
                                          style: TextStyle(
                                            fontFamily: AppFonts.appFont,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.greyText,
                                            fontSize: Dimens.font_16sp,
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
                // ------ chirag edits -------------
                // TextField(
                //   onChanged: (value) {
                //     if (value.length == 4) {
                //       //  OtpManager.callVerifyOtpApi;
                //     }
                //   },
                // ),
                // ----- chirag edits ends here ---------------
                Spacer(),
              ],
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(44),
                topLeft: Radius.circular(44),
              ),
              border: Border.all(
                color: AppColors.white,
                width: 0.5,
              ),
              color: AppColors.white // green as background color
              )),
    );
  }

  void listenOtp() async {
    await SmsAutoFill().unregisterListener();
    listenForCode();
    await SmsAutoFill().listenForCode;

    print("OTP listen Called");
  }

  @override
  void codeUpdated() {
    // TODO: implement codeUpdated
  }
}
