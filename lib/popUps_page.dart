import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:india_one/screens/home_start/home_manager.dart';
import 'package:india_one/screens/insurances/model/insurance_summary_model.dart';
import 'package:india_one/screens/profile/profile_screen.dart';
import 'package:india_one/widgets/button_with_flower.dart';
import 'package:india_one/widgets/common_textfield.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'constant/theme_manager.dart';

class DisplayPopuP {
  Future welcomepopup(
      {required BuildContext context, required String welcomePoints}) async {
    return Future.delayed(
        Duration(milliseconds: 300),
        () => Alert(
              padding: EdgeInsets.zero,
              style: AlertStyle(
                  alertPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  alertBorder: Border.all(width: 0)),
              buttons: [],
              context: context,
              content: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.Welcome_home_popbg))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text(
                        'Welcome to',
                        style: AppStyle.shortHeading
                            .copyWith(height: 1.2, fontSize: Dimens.font_24sp),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          text(
                            'Cashback',
                            style: AppStyle.shortHeading.copyWith(
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                                letterSpacing: 1.2,
                                fontSize: Dimens.font_24sp),
                          ),
                          text(
                            ' by ',
                            style: AppStyle.shortHeading.copyWith(
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                                fontSize: Dimens.font_20sp),
                          ),
                          text(
                            'India1',
                            style: AppStyle.shortHeading.copyWith(
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                                letterSpacing: 1.2,
                                fontSize: Dimens.font_24sp),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      text(
                        'You just won',
                        style: AppStyle.shortHeading
                            .copyWith(fontSize: Dimens.font_20sp),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Dimens.padding_12dp),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(AppImages.goldenHexagonal),
                            Positioned(
                              top: 45,
                              child: text(
                                welcomePoints,
                                style: AppStyle.shortHeading.copyWith(
                                    fontWeight: FontWeight.w900, fontSize: 40),
                              ),
                            ),
                          ],
                        ),
                      ),
                      text(
                        'Points',
                        style: AppStyle.shortHeading.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: Dimens.font_24sp),
                      ),
                    ],
                  ),
                ),
              ),
            ).show());
  }

  Future getProfileWelcome(
      {required BuildContext context, required String profilePoints}) {
    double height = Get.height;
    double width = Get.width;
    return Future.delayed(
        Duration(milliseconds: 300),
        () => Alert(
              padding: EdgeInsets.zero,
              style: AlertStyle(
                  alertPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  alertBorder: Border.all(width: 0)),
              buttons: [],
              context: context,
              content: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.Welcome_home_popbg))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // text(
                      //   'Complete your profile',
                      //   style: AppStyle.shortHeading.copyWith(
                      //       height: 1.2,
                      //       color: AppColors.orangeColor,
                      //       fontSize: Dimens.font_24sp),
                      // ),
                      text(
                        'Complete your profile',
                        style: AppStyle.shortHeading.copyWith(
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                            color: AppColors.orangeColor,
                            letterSpacing: 1.2,
                            fontSize: Dimens.font_20sp),
                      ),

                      SizedBox(height: height * 0.02),
                      text(
                        'You have a chance to',
                        style: AppStyle.shortHeading.copyWith(
                            fontSize: Dimens.font_18sp, color: Colors.white),
                      ),
                      text(
                        'earn upto',
                        style: AppStyle.shortHeading.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: Dimens.font_18sp),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Dimens.padding_12dp),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(AppImages.goldenHexagonal),
                            Positioned(
                              top: 45,
                              child: text(
                                profilePoints,
                                style: AppStyle.shortHeading.copyWith(
                                    fontWeight: FontWeight.w900, fontSize: 40),
                              ),
                            ),
                          ],
                        ),
                      ),
                      text(
                        'Points',
                        style: AppStyle.shortHeading.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: Dimens.font_20sp),
                      ),
                      SizedBox(height: height * 0.05),
                      ButtonWithFlower(
                          label: 'OK',
                          onPressed: () => Get.to(ProfileScreen()),
                          buttonWidth: width * 0.4,
                          buttonHeight: 40,
                          labelSize: 18,
                          buttonGradient: const LinearGradient(
                              begin: Alignment(-2, 0),
                              end: Alignment.centerRight,
                              colors: [
                                AppColors.orangeGradient1,
                                AppColors.orangeGradient2,
                              ]),
                          iconToRight: false,
                          labelColor: Colors.white,
                          labelWeight: FontWeight.normal)
                    ],
                  ),
                ),
              ),
            ).show());
  }

  Future getDropDownPopUp(
      {required BuildContext context,
      required List<dynamic> itemList,
      required String itemListNullError,
      required String searcHintText,
      required String searchFormName,
      required TextEditingController searchCtrl}) {
    double height = Get.height;
    double width = Get.width;
    TextEditingController editCtrl = TextEditingController();

    return Future.delayed(
        Duration(milliseconds: 300),
        () => showDialog(
              useSafeArea: true,
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                contentPadding: EdgeInsets.zero,
                content: Container(
                    width: width * 0.8,
                    height: itemList.length.toDouble() < 10
                        ? 120 * itemList.length.toDouble()
                        : height * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(children: [
                      // close button
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.close,
                              size: 25,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SearchTextContainer(
                            formName: searchFormName,
                            hintText: searcHintText,
                            listNullText: itemListNullError,
                            editCtrl: editCtrl,
                            searchCtrl: searchCtrl,
                            itemList: itemList),
                      )
                      // search textfield
                    ])),
              ),
            ));
  }
}

// search container for search popup display for above mentioned search dropdown menu

class SearchTextContainer extends StatefulWidget {
  const SearchTextContainer(
      {super.key,
      required this.formName,
      required this.hintText,
      required this.editCtrl,
      required this.itemList,
      required this.searchCtrl,
      required this.listNullText});
  final String formName;
  final String hintText;
  final String listNullText;
  final TextEditingController editCtrl;
  final TextEditingController searchCtrl;
  final List<dynamic> itemList;

  @override
  State<SearchTextContainer> createState() => _SearchTextContainerState();
}

class _SearchTextContainerState extends State<SearchTextContainer> {
  List<dynamic> listupdate = [];
  // search function
  void searchList(String query) {
    if (query.isEmpty) {
      setState(() {
        listupdate = widget.itemList;
      });
    } else {
      final suggestions = widget.itemList.where((element) {
        final data = element.toLowerCase();
        final input = query.toLowerCase();

        return data.contains(input);
      }).toList();
      setState(() => listupdate = suggestions);
    }
  }

  void initState() {
    super.initState();
    listupdate = widget.itemList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: CommonTextField(
              formName: widget.formName,
              floatingBehavior: FloatingLabelBehavior.never,

              // inputController:

              suffixIcon: widget.editCtrl.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        widget.editCtrl.clear();
                      },
                      child: Icon(
                        Icons.close,
                        size: 25,
                        color: AppColors.greyInlineText.withOpacity(0.8),
                      ))
                  : null,
              hintText: widget.hintText,

              inputController: widget.editCtrl,
              inputOnChanged: (value) {
                searchList(value ?? '');
              },
              inputFormat: [
                FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9]"))
              ],
              inputValidator: (value) {},
            ),
          ),
        ),
        Expanded(
          child: Container(
              margin: EdgeInsets.all(8.0),
              width: double.maxFinite,
              color: Colors.white,
              child: listupdate.isEmpty
                  ? Center(
                      child: text(widget.listNullText),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => Divider(
                        thickness: 0,
                        height: 1,
                      ),
                      itemCount: listupdate.length,
                      itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          widget.searchCtrl.text = listupdate[index];
                          Get.back();
                        },
                        title: text(listupdate[index],
                            textOverflow: TextOverflow.visible),
                      ),
                    )),
        ),
      ],
    );
  }
}
