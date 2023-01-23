import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/onboarding_login/select_language/each_language_io.dart';
import 'package:india_one/screens/onboarding_login/user_login/user_login_ui.dart';
import 'package:india_one/widgets/screen_bg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../connection_manager/ConnectionManagerController.dart';
import '../../../core/data/local/shared_preference_keys.dart';
import 'select_lan_manager.dart';

class LanguageSelectionIO extends StatefulWidget {
  String fromScreen;
  LanguageSelectionIO(this.fromScreen);

  @override
  State<LanguageSelectionIO> createState() => _LanguageSelectionIOState();
}

class _LanguageSelectionIOState extends State<LanguageSelectionIO> {
  SelectLanManager _selectLanManager = Get.put(SelectLanManager());
  double heightIs = 0, widthIs = 0;
  int selectedLanguage = 0;
  @override
  void initState() {
    super.initState();
    getSelectedLan();
  }

  void getSelectedLan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? selectedLan = prefs.getInt(SPKeys.SELECTED_LANGUAGE);
    selectedLanguage = selectedLan!;
    setState(() {});
  }

  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'ಕನ್ನಡ', 'locale': Locale('ka', 'IN')},
    {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
    {'name': 'मराठी', 'locale': Locale('ma', 'IN')},
    {'name': 'తెలుగు', 'locale': Locale('te', 'IN')},
    {'name': 'தமிழ்', 'locale': Locale('ta', 'IN')},
    {'name': 'മലയാളം', 'locale': Locale('mal', 'IN')},
    {'name': 'বাংলো', 'locale': Locale('ban', 'IN')},
    {'name': 'ଓଡିଆ', 'locale': Locale('or', 'IN')},
  ];

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(child: buildSelectLanScreen()),
        ),
      ),
    );
  }

  Widget buildSelectLanScreen() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        BgScreen('assets/images/select_lan_bg.png'),
        buildContentOfScreen(),
      ],
    );
  }

  Widget buildContentOfScreen() {
    return Container(
      padding: EdgeInsets.all(6),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.only(top: 24.0),
              height: 64,
              child: Image.asset(
                "assets/images/india_one_logo.png",
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                  ),
                  child: Center(
                    child: text(
                      'select_prefer_lan'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          fontSize: Dimens.font_22sp,
                          fontFamily: AppFonts.appFont),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      // width: MediaQuery.of(context).size.width,
                      //height: MediaQuery.of(context).size.height * 0.9,
                      child: Wrap(
                        children: [
                          EachLanguageIO("English", () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setInt(SPKeys.SELECTED_LANGUAGE,
                                Language.ENGLISH.index);
                            prefs.setString(
                                SPKeys.SELECTED_LANGUAGE_CODE, "en");
                            updateLanguage(
                                locale[Language.ENGLISH.index]['locale'],
                                Language.ENGLISH.index);
                            if (prefs!.getString(SPKeys.CUSTOMER_ID) != null) {
                              print("api call");
                              // call update lan api
                              _selectLanManager.updateLan("en");
                            } else {
                              print("No api call for lan update!");
                            }
                          },
                              selectedLanguage == Language.ENGLISH.index
                                  ? AppColors.selectedLangColor
                                  : AppColors.unSelectedLangColor,
                              selectedLanguage == Language.ENGLISH.index
                                  ? AppColors.selectedTextColor
                                  : AppColors.unSelectedTextColor),
                          EachLanguageIO("हिन्दी", () async {
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            prefs.setInt(
                                SPKeys.SELECTED_LANGUAGE, Language.HINDI.index);
                            prefs.setString(
                                SPKeys.SELECTED_LANGUAGE_CODE, "hi");

                            updateLanguage(
                                locale[Language.HINDI.index]['locale'],
                                Language.HINDI.index);
                            if (prefs!.getString(SPKeys.CUSTOMER_ID) != null) {
                              print("api call");
                              // call update lan api
                              _selectLanManager.updateLan("hi");
                            } else {
                              print("No api call for lan update!");
                            }
                          },
                              selectedLanguage == Language.HINDI.index
                                  ? AppColors.selectedLangColor
                                  : AppColors.unSelectedLangColor,
                              selectedLanguage == Language.HINDI.index
                                  ? AppColors.selectedTextColor
                                  : AppColors.unSelectedTextColor),
                          EachLanguageIO("ಕನ್ನಡ", () async {
                            Fluttertoast.showToast(
                              msg: "Coming soon ...",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 16.0,
                            );
                            // SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            // prefs.setInt(SPKeys.SELECTED_LANGUAGE,
                            //     Language.KANNADA.index);
                            // prefs.setString(
                            //     SPKeys.SELECTED_LANGUAGE_CODE, "kn");
                            //
                            // updateLanguage(
                            //     locale[Language.KANNADA.index]['locale'],
                            //     Language.KANNADA.index);
                            // if (prefs!.getString(SPKeys.CUSTOMER_ID) != null) {
                            //   print("api call");
                            //   // call update lan api
                            //   _selectLanManager.updateLan("kn");
                            // } else {
                            //   print("No api call for lan update!");
                            // }
                          },
                              selectedLanguage == Language.KANNADA.index
                                  ? AppColors.selectedLangColor
                                  : AppColors.unSelectedLangColor,
                              selectedLanguage == Language.KANNADA.index
                                  ? AppColors.selectedTextColor
                                  : AppColors.unSelectedTextColor),

                          EachLanguageIO("मराठी", () async {
                            Fluttertoast.showToast(
                              msg: "Coming soon ...",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 16.0,
                            );
                            // SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            // prefs.setInt(SPKeys.SELECTED_LANGUAGE,
                            //     Language.MARATHI.index);
                            // prefs.setString(
                            //     SPKeys.SELECTED_LANGUAGE_CODE, "mr");
                            //
                            // updateLanguage(
                            //     locale[Language.MARATHI.index]['locale'],
                            //     Language.MARATHI.index);
                            // if (prefs!.getString(SPKeys.CUSTOMER_ID) != null) {
                            //   print("api call");
                            //   // call update lan api
                            //   _selectLanManager.updateLan("mr");
                            // } else {
                            //   print("No api call for lan update!");
                            // }
                          },
                              selectedLanguage == Language.MARATHI.index
                                  ? AppColors.selectedLangColor
                                  : AppColors.unSelectedLangColor,
                              selectedLanguage == Language.MARATHI.index
                                  ? AppColors.selectedTextColor
                                  : AppColors.unSelectedTextColor),
                          EachLanguageIO("తెలుగు", () async {
                            Fluttertoast.showToast(
                              msg: "Coming soon ...",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 16.0,
                            );
                            // SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            // prefs.setInt(SPKeys.SELECTED_LANGUAGE,
                            //     Language.TELUGU.index);
                            // prefs.setString(
                            //     SPKeys.SELECTED_LANGUAGE_CODE, "te");
                            //
                            // updateLanguage(
                            //     locale[Language.TELUGU.index]['locale'],
                            //     Language.TELUGU.index);
                            // if (prefs!.getString(SPKeys.CUSTOMER_ID) != null) {
                            //   print("api call");
                            //   // call update lan api
                            //   _selectLanManager.updateLan("te");
                            // } else {
                            //   print("No api call for lan update!");
                            // }
                          },
                              selectedLanguage == Language.TELUGU.index
                                  ? AppColors.selectedLangColor
                                  : AppColors.unSelectedLangColor,
                              selectedLanguage == Language.TELUGU.index
                                  ? AppColors.selectedTextColor
                                  : AppColors.unSelectedTextColor),
                          EachLanguageIO("தமிழ்", () async {
                            Fluttertoast.showToast(
                              msg: "Coming soon ...",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 16.0,
                            );
                            // SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            // prefs.setInt(
                            //     SPKeys.SELECTED_LANGUAGE, Language.TAMIL.index);
                            // prefs.setString(
                            //     SPKeys.SELECTED_LANGUAGE_CODE, "ta");
                            //
                            // updateLanguage(
                            //     locale[Language.TAMIL.index]['locale'],
                            //     Language.TAMIL.index);
                            // if (prefs!.getString(SPKeys.CUSTOMER_ID) != null) {
                            //   print("api call");
                            //   // call update lan api
                            //   _selectLanManager.updateLan("ta");
                            // } else {
                            //   print("No api call for lan update!");
                            // }
                          },
                              selectedLanguage == Language.TAMIL.index
                                  ? AppColors.selectedLangColor
                                  : AppColors.unSelectedLangColor,
                              selectedLanguage == Language.TAMIL.index
                                  ? AppColors.selectedTextColor
                                  : AppColors.unSelectedTextColor),
                          EachLanguageIO("മലയാളം", () async {
                            Fluttertoast.showToast(
                              msg: "Coming soon ...",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 16.0,
                            );
                            // SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            // prefs.setInt(SPKeys.SELECTED_LANGUAGE,
                            //     Language.MALAYALAM.index);
                            // prefs.setString(
                            //     SPKeys.SELECTED_LANGUAGE_CODE, "ml");
                            //
                            // updateLanguage(
                            //     locale[Language.MALAYALAM.index]['locale'],
                            //     Language.MALAYALAM.index);
                            // if (prefs!.getString(SPKeys.CUSTOMER_ID) != null) {
                            //   print("api call");
                            //   // call update lan api
                            //   _selectLanManager.updateLan("ml");
                            // } else {
                            //   print("No api call for lan update!");
                            // }
                          },
                              selectedLanguage == Language.MALAYALAM.index
                                  ? AppColors.selectedLangColor
                                  : AppColors.unSelectedLangColor,
                              selectedLanguage == Language.MALAYALAM.index
                                  ? AppColors.selectedTextColor
                                  : AppColors.unSelectedTextColor),
                          EachLanguageIO("বাংলো", () async {
                            Fluttertoast.showToast(
                              msg: "Coming soon ...",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 16.0,
                            );
                            // SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            // prefs.setInt(SPKeys.SELECTED_LANGUAGE,
                            //     Language.BENGALI.index);
                            // prefs.setString(
                            //     SPKeys.SELECTED_LANGUAGE_CODE, "bn");
                            //
                            // updateLanguage(
                            //     locale[Language.BENGALI.index]['locale'],
                            //     Language.BENGALI.index);
                            // if (prefs!.getString(SPKeys.CUSTOMER_ID) != null) {
                            //   print("api call");
                            //   // call update lan api
                            //   _selectLanManager.updateLan("bn");
                            // } else {
                            //   print("No api call for lan update!");
                            // }
                          },
                              selectedLanguage == Language.BENGALI.index
                                  ? AppColors.selectedLangColor
                                  : AppColors.unSelectedLangColor,
                              selectedLanguage == Language.BENGALI.index
                                  ? AppColors.selectedTextColor
                                  : AppColors.unSelectedTextColor),
                          EachLanguageIO("ଓଡିଆ", () async {
                            Fluttertoast.showToast(
                              msg: "Coming soon ...",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 16.0,
                            );
                            // SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            // prefs.setInt(
                            //     SPKeys.SELECTED_LANGUAGE, Language.ODIA.index);
                            // prefs.setString(
                            //     SPKeys.SELECTED_LANGUAGE_CODE, "bn");
                            //
                            // updateLanguage(
                            //     locale[Language.ODIA.index]['locale'],
                            //     Language.ODIA.index);
                          },
                              selectedLanguage == Language.ODIA.index
                                  ? AppColors.selectedLangColor
                                  : AppColors.unSelectedLangColor,
                              selectedLanguage == Language.ODIA.index
                                  ? AppColors.selectedTextColor
                                  : AppColors.unSelectedTextColor),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Visibility(
              visible: widget.fromScreen == "home" ? false : true,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserLogin()),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Center(
                          child: text(
                            'proceed_btn'.tr,
                            style: AppTextThemes.button,
                          ),
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
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }

  updateLanguage(Locale locale, int selectdLang) {
    Get.back();
    Get.updateLocale(locale);
    selectedLanguage = selectdLang;
    setState(() {
      selectedLanguage;
    });
  }
}

enum Language {
  ENGLISH,
  KANNADA,
  HINDI,
  MARATHI,
  TELUGU,
  TAMIL,
  MALAYALAM,
  BENGALI,
  ODIA
}
