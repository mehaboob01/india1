import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:india_one/screens/onboarding_login/user_login/tnc_io.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../constant/theme_manager.dart';
import '../../../widgets/screen_bg.dart';
import 'login_manager.dart';

class UserLogin extends StatefulWidget {
   UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {


  @override
  void initState() {
    super.initState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
  }

  bool? termConditionChecked = false;
  bool? alertTextShow = false;

  final Uri _termConditionUrl = Uri.parse('https://pub.dev/packages/rflutter_alert/example');
  final GlobalKey<FormBuilderState> _loginKey = GlobalKey<FormBuilderState>();
  LoginManager _loginManager = Get.put(LoginManager());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      children: [BgScreen(), buildLoginCard()],
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

  Widget buildLoginCard() {
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
                  key: _loginKey,
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
                                child: Text(
                                  "Mobile Number",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                    fontSize: Dimens.font_20sp,
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
                          child: FormBuilderTextField(

                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              new CustomInputFormatter(),
                              LengthLimitingTextInputFormatter(12),
                            ],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.facebookBlue,
                                fontSize: Dimens.font_16sp),
                            decoration: new InputDecoration(

                              prefixIcon: Padding(
                                  padding: EdgeInsets.only(top: 14),
                                  child: Text('+91 ')),

                              hintText: '0000 0000 00',

                              labelStyle:
                                  new TextStyle(color: Color(0xFF787878)),
                            ),


                            validator : (value){
                              if(value!.isEmpty) return 'Please enter a 10 digit mobile number';
                              return null;
                            },
                            name: 'mobile',
                          )),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              shape:  RoundedRectangleBorder(
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
                            width: 2,
                          ),
                          Row(
                            children: [
                              Text(
                                "I accept",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.black,
                                  fontSize: Dimens.font_18sp,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Tnc_IO()),
                                  );
                                },
                                child: Container(
                                  child: Text(
                                    "Terms & Conditions",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.facebookBlue,
                                      fontSize: Dimens.font_18sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.all(12.0),
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
                              child: Text(
                                "Agree to our Terms & Conditions to proceed further",
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
                          setState(() {
                            alertTextShow = false;
                            _loginKey.currentState!.save();
                            if (_loginKey.currentState!.validate()) {
                              _loginManager.callSentOtpApi(
                                  _loginKey.currentState!.value['mobile'].replaceAll(' ', '')
                                      .toString(),
                                  context,
                                  termConditionChecked);
                            } else {
                              print("validation failed");
                            }
                          });
                        }
                      : () {
                          setState(() {
                            alertTextShow = true;
                          });
                        },
                  child: Obx(() => _loginManager.isLoading == false
                      ? Container(
                          width: MediaQuery.of(context).size.height * 0.9,
                          height: 48,
                          child: Padding(
                            padding:  EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Request OTP',
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
                          decoration: termConditionChecked == true
                              ? BoxDecoration(
                                  gradient: new LinearGradient(
                                    end: Alignment.topRight,
                                    colors: [Colors.orange, Colors.redAccent],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white70.withOpacity(0.8),
                                      offset:  Offset(
                                        -6.0,
                                        -6.0,
                                      ),
                                      blurRadius: 16.0,
                                    ),
                                    BoxShadow(
                                      color:
                                          AppColors.darkerGrey.withOpacity(0.4),
                                      offset:  Offset(6.0, 6.0),
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
                                      offset:  Offset(
                                        -6.0,
                                        -6.0,
                                      ),
                                      blurRadius: 16.0,
                                    ),
                                    BoxShadow(
                                      color:
                                          AppColors.darkerGrey.withOpacity(0.4),
                                      offset:  Offset(6.0, 6.0),
                                      blurRadius: 16.0,
                                    ),
                                  ],
                                  color: termConditionChecked == true
                                      ? AppColors.btnColor
                                      : AppColors.btnDisableColor,
                                  borderRadius: BorderRadius.circular(6.0),
                                ))
                      :
                  Container(
                          width: MediaQuery.of(context).size.height * 0.9,
                          height: 48,
                          child: Padding(
                            padding:  EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sending OTP',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 8,
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
                          ),
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
                              end: Alignment.topRight,
                              colors: [Colors.orange, Colors.redAccent],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.8),
                                offset:  Offset(
                                  -6.0,
                                  -6.0,
                                ),
                                blurRadius: 16.0,
                              ),
                              BoxShadow(
                                color: AppColors.darkerGrey.withOpacity(0.4),
                                offset:  Offset(6.0, 6.0),
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
                  height: 28,
                )
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

  Future<void> _launchTermConditionUrl() async {
    if (!await launchUrl(_termConditionUrl)) {
      throw 'Could not launch $_termConditionUrl';
    }
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
        buffer.write(
            ' '); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
