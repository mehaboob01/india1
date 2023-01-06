import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_one/screens/onboarding_login/otp_screen/otp_manager.dart';
import 'package:india_one/screens/onboarding_login/user_login/tnc_io.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../constant/theme_manager.dart';
import '../../../widgets/screen_bg.dart';
import '../otp_screen/otp_screen_ui.dart';
import 'login_manager.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

class UserLogin extends StatefulWidget {
  UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  String? mobileno = '';
  int charLength = 0;
  bool? termConditionChecked = false;
  bool? alertTextShow = false;

  final autofill = SmsAutoFill();
  final GlobalKey<FormBuilderState> _loginKey = GlobalKey<FormBuilderState>();
  LoginManager _loginManager = Get.put(LoginManager());
  OtpManager _otpManager = Get.put(OtpManager());
  var _textController = new TextEditingController();

  //fun for show mobile numbers
  Future<void> getMobilePopup() async {
    try {
      var data = await autofill.hint ?? '';
      var buffer = new StringBuffer();
      if (data.isNotEmpty) {
        mobileno = data.substring(3);
        for (int i = 0; i < mobileno!.length; i++) {
          buffer.write(mobileno![i]);
          var nonZeroIndex = i + 1;
          if (nonZeroIndex % 4 == 0 && nonZeroIndex != mobileno!.length) {
            buffer.write(' ');
          }
        }
        var autoSelectNumber = buffer.toString();
        mobileno = autoSelectNumber;
        mobileno = mobileno.toString() + ' ';
        _textController.text =
            FlutterLibphonenumber().formatNumberSync(mobileno.toString());
      }
    } catch (e) {}
  }

  _onTextChanged(String? value) {
    setState(() {
      charLength = value!.length;
      if (charLength == 12) {
        _loginKey.currentState!.validate();
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getMobilePopup();
    _loginManager.callTermConditionPolicyApi();

  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    //code for prevent landscape view
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: Obx(
        () => IgnorePointer(
          ignoring: _controller.ignorePointer.value,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: SingleChildScrollView(
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
                            // LoginBgScreen('assets/images/login_bg.png'),
                            buildLoginCard()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginCard() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                FormBuilder(
                  key: _loginKey,
                  initialValue: {
                    "mobile": "",
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                              child: Text(
                                'mobile_number'.tr,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: AppFonts.appFont,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32),
                      Padding(
                          padding: EdgeInsets.only(
                            left: 12.0,
                            right: 12.0,
                          ),
                          child: FormBuilderTextField(
                            autofocus: false,
                            controller: _textController,
                            onChanged: _onTextChanged,
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              new CustomInputFormatter(),
                              LengthLimitingTextInputFormatter(12),
                            ],
                            style: TextStyle(
                                letterSpacing: 3,
                                fontFamily: AppFonts.appFont,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                                fontSize: Dimens.font_24sp),
                            decoration: new InputDecoration(
                              errorStyle: GoogleFonts.roboto(
                                fontSize: Dimens.font_14sp,
                                fontWeight: FontWeight.w500,
                              ),
                              prefixIcon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      '+91 ',
                                      style: TextStyle(
                                          letterSpacing: 3,
                                          fontFamily: AppFonts.appFont,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black,
                                          fontSize: Dimens.font_24sp),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                              hintText: '• • • •  • • •  • • •',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.dotsColor,
                                  fontSize: Dimens.font_28sp),
                              labelStyle:
                                  new TextStyle(color: Color(0xFF787878)),
                            ),
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'empty_error_msg'.tr;
                              else if (value.length < 12)
                                return 'empty_error_msg'.tr;
                              else
                                return null;
                            },
                            name: 'mobile',
                          )),
                      SizedBox(
                        height: 44,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            5.0))), // Rounded Checkbox
                                activeColor: AppColors.facebookBlue,
                                //only check box
                                value: termConditionChecked,
                                //unchecked
                                onChanged: (bool? value) {
                                  //value returned when checkbox is clicked
                                  setState(() {
                                    termConditionChecked = value;
                                    alertTextShow = false;
                                  });
                                }),
                            SizedBox(
                              width: 4,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SingleChildScrollView(
                                    child: Row(
                                      children: [
                                        Text(
                                          "i_accept".tr,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontFamily: AppFonts.appFont,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.black,
                                            fontSize: Dimens.font_16sp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Obx(
                                          ()=> _loginManager.isPrivacyLoading == true?  Container(
                                              height: 18,
                                              width: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.0,
                                                color: AppColors.blueColor,
                                              )): Container(
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {

                                                    print("ontapp");

                                                    print(_loginManager.termCondition);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Tnc_IO(_loginManager.termCondition,"term_condition")),
                                                    );
                                                  },
                                                  child: Text(
                                                    "term_condition".tr,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontFamily: AppFonts.appFont,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColors.facebookBlue,
                                                      fontSize: Dimens.font_16sp,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 4,),
                                                GestureDetector(
                                                  onTap: () {

                                                    print("ontapp");

                                                    print(_loginManager.privacyPolicy);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Tnc_IO(_loginManager.privacyPolicy,"privacy_policy")),
                                                    );
                                                  },
                                                  child: Text(
                                                    " & Privacy policy".tr,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontFamily: AppFonts.appFont,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColors.facebookBlue,
                                                      fontSize: Dimens.font_16sp,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Visibility(
                              visible: alertTextShow == true ? true : false,
                              child: Icon(
                                CupertinoIcons.exclamationmark_circle_fill,
                                color: AppColors.googleRed,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Visibility(
                              visible: alertTextShow == true ? true : false,
                              child: Expanded(
                                child: Text(
                                  'checkbox_select_error'.tr,
                                  overflow: TextOverflow.visible,
                                  maxLines: 2,
                                  style: TextStyle(
                                    overflow: TextOverflow.visible,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.googleRed,
                                    fontSize: Dimens.font_12sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: termConditionChecked == true
                      ? () {
                          setState(() async {
                            alertTextShow = false;
                            _loginKey.currentState!.save();
                            if (_loginKey.currentState!.validate()) {
                              var appSignatureId =
                                  await SmsAutoFill().getAppSignature;

                              _loginManager.callSentOtpApi(
                                  _loginKey.currentState!.value['mobile']
                                      .replaceAll(' ', '')
                                      .toString(),
                                  context,
                                  termConditionChecked,
                                  appSignatureId,
                                  false);
                            } else {}
                          });
                        }
                      : () {
                          setState(() {
                            _loginKey.currentState!.save();
                            _loginKey.currentState!.validate();
                            if (_loginKey.currentState!.validate())
                              alertTextShow = true;
                          });
                        },
                  child: Obx(() => _loginManager.isLoading == false
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 44,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Text(
                                'request_otp'.tr,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              Spacer(),
                              SizedBox(
                                height: 48,
                                child: termConditionChecked == true
                                    ? Image.asset(
                                        "assets/images/btn_img.png",
                                        fit: BoxFit.fill,
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                          decoration: termConditionChecked == true
                              ? BoxDecoration(
                                  gradient: new LinearGradient(
                                    end: Alignment.topRight,
                                    colors: [Colors.orange, Colors.redAccent],
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
                                      color:
                                          AppColors.darkerGrey.withOpacity(0.4),
                                      offset: Offset(6.0, 6.0),
                                      blurRadius: 16.0,
                                    ),
                                  ],
                                  color: termConditionChecked == true
                                      ? AppColors.btnColor
                                      : AppColors.btnDisableColor,
                                  borderRadius: BorderRadius.circular(6.0),
                                )
                              : BoxDecoration(
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
                                      color:
                                          AppColors.darkerGrey.withOpacity(0.4),
                                      offset: Offset(6.0, 6.0),
                                      blurRadius: 16.0,
                                    ),
                                  ],
                                  color: termConditionChecked == true
                                      ? AppColors.btnColor
                                      : AppColors.btnDisableColor,
                                  borderRadius: BorderRadius.circular(6.0),
                                ))
                      : Container(
                          width: MediaQuery.of(context).size.height * 0.9,
                          height: 44,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Row(
                                children: [
                                  Text(
                                    'sending_otp'.tr,
                                    style: AppTextThemes.button,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Container(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        color: AppColors.white,
                                      ))
                                ],
                              ),
                              Spacer(),
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
                              colors: [Colors.orange, Colors.redAccent],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.8),
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
                            // color: termConditionChecked == true
                            //     ? AppColors.btnColor
                            //     : AppColors.btnDisableColor,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        )),
                ),
                SizedBox(
                  height: 16,
                )
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
              // radius of 10
              color: AppColors.white // green as background color
              )),
    );
  }
}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
