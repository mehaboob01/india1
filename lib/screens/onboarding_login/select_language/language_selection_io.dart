import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/widgets/text_io.dart';

import '../../../constant/routes.dart';
import '../../../constant/theme_manager.dart';
import 'each_language_io.dart';

class LanguageSelectionIO extends StatefulWidget {
  const LanguageSelectionIO({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionIO> createState() => _LanguageSelectionIOState();
}

class _LanguageSelectionIOState extends State<LanguageSelectionIO> {
  double heightIs = 0, widthIs = 0;

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: heightIs,
          width: widthIs,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(9, 36, 9, 36),
                child: TextIO("Select language you prefer"),
              ),
              SizedBox(
                height: heightIs * .63,
                child: Wrap(
                  children: [
                    EachLanguageIO("English", () {}),
                    EachLanguageIO("हिन्दी", () {}),
                    EachLanguageIO("ಕನ್ನಡ", () {}),
                    EachLanguageIO("मराठी", () {}),
                    EachLanguageIO("తెలుగు", () {}),
                    EachLanguageIO("தமிழ்", () {}),
                    EachLanguageIO("മലയാളം", () {}),
                    EachLanguageIO("മലയാളം", () {}),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    Get.offAllNamed(MRouter.userLogin);
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
                            'NEXT',
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
            ],
          ),
        ),
      ),
    );
  }
}
