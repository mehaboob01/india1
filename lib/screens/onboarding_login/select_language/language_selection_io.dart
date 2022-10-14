import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_one/constant/theme_manager.dart';

import 'package:india_one/screens/onboarding_login/select_language/each_language_io.dart';
import 'package:india_one/screens/onboarding_login/user_login/user_login_ui.dart';
import 'package:india_one/widgets/screen_bg.dart';

import 'package:india_one/widgets/text_io.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageSelectionIO extends StatefulWidget {
  const LanguageSelectionIO({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionIO> createState() => _LanguageSelectionIOState();
}

class _LanguageSelectionIOState extends State<LanguageSelectionIO> {
  double heightIs = 0, widthIs = 0;
  int selectedLanguage = 0;

  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
    {'name': 'ಕನ್ನಡ', 'locale': Locale('ka', 'IN')},
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
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.9,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 44,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/india_one_logo.png",
                        width: 120,
                        height: 64,
                      ),
                      SizedBox(height: 4,),
                      Center(
                        child: Text(
                          'select_prefer_lan'.tr,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                            fontSize: Dimens.font_20sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 44,
                ),
                InkWell(


                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,

                    child: Wrap(
                      children: [
                        EachLanguageIO("English", () {
                          updateLanguage(locale[0]['locale'], 0);
                        },
                            selectedLanguage == 0
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 0
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("हिन्दी", () {
                          updateLanguage(locale[1]['locale'], 1);
                        },
                            selectedLanguage == 1
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 1
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("ಕನ್ನಡ", () {
                          updateLanguage(locale[2]['locale'], 2);
                        },
                            selectedLanguage == 2
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 2
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("मराठी", () {
                          updateLanguage(locale[3]['locale'], 3);
                        },
                            selectedLanguage == 3
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 3
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("తెలుగు", () {
                          updateLanguage(locale[4]['locale'], 4);
                        },
                            selectedLanguage == 4
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 4
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("தமிழ்", () {
                          updateLanguage(locale[5]['locale'], 5);
                        },
                            selectedLanguage == 5
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 5
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("മലയാളം", () {
                          updateLanguage(locale[6]['locale'], 6);
                        },
                            selectedLanguage == 6
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 6
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("বাংলো", () {
                          updateLanguage(locale[7]['locale'], 7);
                        },
                            selectedLanguage == 7
                                ? AppColors.selectedLangColor
                                : AppColors.unSelectedLangColor,
                            selectedLanguage == 7
                                ? AppColors.selectedTextColor
                                : AppColors.unSelectedTextColor),
                        EachLanguageIO("ଓଡିଆ", () {
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
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserLogin()),
            );
          },
          child: Padding(
            padding:  EdgeInsets.only(left: 14.0, right: 14.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  Text(
                    'proceed_btn'.tr,
                    style: AppTextThemes.button,
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
                // color: termConditionChecked == true
                //     ? AppColors.btnColor
                //     : AppColors.btnDisableColor,
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
          ),
        )
      ],
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
