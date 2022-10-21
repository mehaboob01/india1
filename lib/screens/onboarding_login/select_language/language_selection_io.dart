import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/onboarding_login/select_language/each_language_io.dart';
import 'package:india_one/screens/onboarding_login/user_login/user_login_ui.dart';
import 'package:india_one/widgets/screen_bg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/data/local/shared_preference_keys.dart';

class LanguageSelectionIO extends StatefulWidget {
  String fromScreen;
  LanguageSelectionIO(this.fromScreen);

  @override
  State<LanguageSelectionIO> createState() => _LanguageSelectionIOState();
}

class _LanguageSelectionIOState extends State<LanguageSelectionIO> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildSelectLanScreen(),
    );
  }

  Widget buildSelectLanScreen() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        BgScreen('assets/images/select_lan_bg.png'),
        SingleChildScrollView(child: buildContentOfScreen()),
      ],
    );
  }

  Widget buildContentOfScreen() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 38,
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 64,
                          child: Image.asset(
                            "assets/images/india_one_logo.png",
                          ),
                        ),
                        SizedBox(
                          height: 44,
                        ),
                        Center(
                          child: Text(
                            'select_prefer_lan'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                                fontSize: Dimens.font_22sp,
                                fontFamily: 'Graphik'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 44,
                ),
                InkWell(
                  child: SizedBox(
                    // width: MediaQuery.of(context).size.width,
                    //height: MediaQuery.of(context).size.height * 0.9,
                    child: Wrap(
                      children: [
                        EachLanguageIO("English", () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setInt(SPKeys.SELECTED_LANGUAGE, 0);
                          updateLanguage(locale[0]['locale'], 0);
                        },
                            selectedLanguage == 0
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 0
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("ಕನ್ನಡ", () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setInt(SPKeys.SELECTED_LANGUAGE, 1);

                          updateLanguage(locale[1]['locale'], 1);
                        },
                            selectedLanguage == 1
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 1
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("हिन्दी", () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setInt(SPKeys.SELECTED_LANGUAGE, 2);
                          updateLanguage(locale[2]['locale'], 2);
                        },
                            selectedLanguage == 2
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 2
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("मराठी", () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setInt(SPKeys.SELECTED_LANGUAGE, 3);

                          updateLanguage(locale[3]['locale'], 3);
                        },
                            selectedLanguage == 3
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 3
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("తెలుగు", () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setInt(SPKeys.SELECTED_LANGUAGE, 4);
                          updateLanguage(locale[4]['locale'], 4);
                        },
                            selectedLanguage == 4
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 4
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("தமிழ்", () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setInt(SPKeys.SELECTED_LANGUAGE, 5);
                          updateLanguage(locale[5]['locale'], 5);
                        },
                            selectedLanguage == 5
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 5
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("മലയാളം", () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setInt(SPKeys.SELECTED_LANGUAGE, 6);
                          updateLanguage(locale[6]['locale'], 6);
                        },
                            selectedLanguage == 6
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 6
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("বাংলো", () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setInt(SPKeys.SELECTED_LANGUAGE, 7);
                          updateLanguage(locale[7]['locale'], 7);
                        },
                            selectedLanguage == 7
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 7
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("ଓଡିଆ", () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setInt(SPKeys.SELECTED_LANGUAGE, 8);
                          updateLanguage(locale[8]['locale'], 8);
                        },
                            selectedLanguage == 8
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 8
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
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
                        child: Text(
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
            height: 32,
          )
        ],
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
