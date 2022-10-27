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
      padding: EdgeInsets.only(),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
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
              )),
          Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height * 0.9,
                  child: Wrap(
                    children: [
                      EachLanguageIO("English", () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setInt(
                            SPKeys.SELECTED_LANGUAGE, Language.ENGLISH.index);
                        updateLanguage(locale[Language.ENGLISH.index]['locale'],
                            Language.ENGLISH.index);
                      },
                          selectedLanguage == Language.ENGLISH.index
                              ? AppColors.selectedLangColor
                              : AppColors.unSelectedLangColor,
                          selectedLanguage == Language.ENGLISH.index
                              ? AppColors.selectedTextColor
                              : AppColors.unSelectedTextColor),
                      EachLanguageIO("ಕನ್ನಡ", () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setInt(
                            SPKeys.SELECTED_LANGUAGE, Language.KANNADA.index);

                        updateLanguage(locale[Language.KANNADA.index]['locale'],
                            Language.KANNADA.index);
                      },
                          selectedLanguage == Language.KANNADA.index
                              ? AppColors.selectedLangColor
                              : AppColors.unSelectedLangColor,
                          selectedLanguage == Language.KANNADA.index
                              ? AppColors.selectedTextColor
                              : AppColors.unSelectedTextColor),
                      EachLanguageIO("हिन्दी", () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setInt(
                            SPKeys.SELECTED_LANGUAGE, Language.HINDI.index);
                        updateLanguage(locale[Language.HINDI.index]['locale'],
                            Language.HINDI.index);
                      },
                          selectedLanguage == Language.HINDI.index
                              ? AppColors.selectedLangColor
                              : AppColors.unSelectedLangColor,
                          selectedLanguage == Language.HINDI.index
                              ? AppColors.selectedTextColor
                              : AppColors.unSelectedTextColor),
                      EachLanguageIO("मराठी", () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setInt(
                            SPKeys.SELECTED_LANGUAGE, Language.MARATHI.index);

                        updateLanguage(locale[Language.MARATHI.index]['locale'],
                            Language.MARATHI.index);
                      },
                          selectedLanguage == Language.MARATHI.index
                              ? AppColors.selectedLangColor
                              : AppColors.unSelectedLangColor,
                          selectedLanguage == Language.MARATHI.index
                              ? AppColors.selectedTextColor
                              : AppColors.unSelectedTextColor),
                      EachLanguageIO("తెలుగు", () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setInt(
                            SPKeys.SELECTED_LANGUAGE, Language.TELUGU.index);
                        updateLanguage(locale[Language.TELUGU.index]['locale'],
                            Language.TELUGU.index);
                      },
                          selectedLanguage == Language.TELUGU.index
                              ? AppColors.selectedLangColor
                              : AppColors.unSelectedLangColor,
                          selectedLanguage == Language.TELUGU.index
                              ? AppColors.selectedTextColor
                              : AppColors.unSelectedTextColor),
                      EachLanguageIO("தமிழ்", () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setInt(
                            SPKeys.SELECTED_LANGUAGE, Language.TAMIL.index);
                        updateLanguage(locale[Language.TAMIL.index]['locale'],
                            Language.TAMIL.index);
                      },
                          selectedLanguage == Language.TAMIL.index
                              ? AppColors.selectedLangColor
                              : AppColors.unSelectedLangColor,
                          selectedLanguage == Language.TAMIL.index
                              ? AppColors.selectedTextColor
                              : AppColors.unSelectedTextColor),
                      EachLanguageIO("മലയാളം", () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setInt(
                            SPKeys.SELECTED_LANGUAGE, Language.MALAYALAM.index);
                        updateLanguage(
                            locale[Language.MALAYALAM.index]['locale'],
                            Language.MALAYALAM.index);
                      },
                          selectedLanguage == Language.MALAYALAM.index
                              ? AppColors.selectedLangColor
                              : AppColors.unSelectedLangColor,
                          selectedLanguage == Language.MALAYALAM.index
                              ? AppColors.selectedTextColor
                              : AppColors.unSelectedTextColor),
                      EachLanguageIO("বাংলো", () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setInt(
                            SPKeys.SELECTED_LANGUAGE, Language.BENGALI.index);
                        updateLanguage(locale[Language.BENGALI.index]['locale'],
                            Language.BENGALI.index);
                      },
                          selectedLanguage == Language.BENGALI.index
                              ? AppColors.selectedLangColor
                              : AppColors.unSelectedLangColor,
                          selectedLanguage == Language.BENGALI.index
                              ? AppColors.selectedTextColor
                              : AppColors.unSelectedTextColor),
                      EachLanguageIO("ଓଡିଆ", () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setInt(
                            SPKeys.SELECTED_LANGUAGE, Language.ODIA.index);
                        updateLanguage(locale[Language.ODIA.index]['locale'],
                            Language.ODIA.index);
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
