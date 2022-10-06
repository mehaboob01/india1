import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant/routes.dart';
import '../../../constant/theme_manager.dart';
import '../../../widgets/screen_bg.dart';
import 'login_manager.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
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
          height: 464,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                FormBuilder(
                  key: _loginKey,
                  initialValue: {
                    "mobile": "",
                  },
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  "Welcome to India 1",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                    fontSize: Dimens.font_20sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 44),
                        Padding(
                            padding: EdgeInsets.only(
                              left: 12.0,
                              right: 12.0,
                            ),
                            child: FormBuilderTextField(

                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimens.font_16sp),
                              decoration: new InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFCDCBCB), width: 2.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderSide: const BorderSide(
                                      color: Color(0xFFCDCBCB), width: 2.0),
                                ),
                                border: const OutlineInputBorder(),
                                labelText: 'Enter your mobile number',
                                labelStyle:
                                    new TextStyle(color: Color(0xFF787878)),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),

                              ]),
                              name: 'mobile',
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Checkbox(
                                activeColor: AppColors.bgScreenColor,
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
                                  "Agree to India1",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.black,
                                    fontSize: Dimens.font_18sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                GestureDetector(
                                  onTap: _launchTermConditionUrl,
                                  child: Container(
                                    color: AppColors.lightYellow,
                                    child: Text(
                                      "Terms & Conditions",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black,
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
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Visibility(
                                visible: alertTextShow == true ? true : false,
                                child: Icon(
                                  CupertinoIcons.exclamationmark_octagon,
                                  color: AppColors.googleRed,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Flexible(
                                child: Visibility(
                                  visible: alertTextShow == true ? true : false,
                                  child: Text(
                                    "Agree to our Terms & Conditions to proceed further",
                                    overflow: TextOverflow.visible,
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.visible,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.googleRed,
                                      fontSize: Dimens.font_14sp,
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
                                  _loginKey.currentState!.value,context);
                              Get.offAllNamed(MRouter.otpScreen);

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
                  child:
                  Container(
                    width: MediaQuery.of(context).size.height * 0.9,
                    height: 48,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Send OTP',
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
                      color: termConditionChecked == true
                          ? AppColors.btnColor
                          : AppColors.btnDisableColor,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 28,
                )
              ],
            ),
          ),
          decoration: BoxDecoration(

              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
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
