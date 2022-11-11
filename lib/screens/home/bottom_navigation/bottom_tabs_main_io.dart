import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/Pages/loans.dart';
import 'package:india_one/screens/Pages/payments.dart';

import 'package:india_one/screens/home/bottom_navigation/custom_widgets/home_each_bottom_tab_io.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../core/data/local/shared_preference_keys.dart';
import '../../Pages/insurance.dart';
import '../../Pages/savings.dart';
import '../../home_start/home_main_io.dart';


class BottomTabsMainIO extends StatefulWidget {
  const BottomTabsMainIO({Key? key}) : super(key: key);

  @override
  State<BottomTabsMainIO> createState() => _BottomTabsMainIOState();
}

class _BottomTabsMainIOState extends State<BottomTabsMainIO> {
  double heightIs = 0, widthIs = 0;
  int selectedTabId = 0;
  Widget mainHomeWidget = Container();

  @override
  void initState() {
    mainHomeWidget = HomeMainIO(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightIs = MediaQuery.of(context).size.height;
    widthIs = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SizedBox(
            height: heightIs - bottomMargin+9,
            child: mainHomeWidget,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: AppColors.transparent,
              height: bottomNavigationCircleRadius,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      HomeEachBottomTabIO('assets/images/homeInactive.svg','assets/images/underline.svg', "${'home'.tr}", () {
                        selectedTabId = 0;
                        mainHomeWidget = HomeMainIO(false);
                        setState(() {


                           showAuth();
                          selectedTabId;
                          mainHomeWidget;
                        });
                      }, selectedTabId == 0, 12),
                      HomeEachBottomTabIO('assets/images/loanInactive.svg','assets/images/underline.svg', "${'loans'.tr}", () {
                        selectedTabId = 1;
                        mainHomeWidget = LoansPage();
                        setState(() {
                          showAuth();
                          selectedTabId;
                          mainHomeWidget;
                        });
                      }, selectedTabId == 1, 12),
                      HomeEachBottomTabIO('assets/images/paymentsInactive.svg','assets/images/underline.svg', "${'payments'.tr}", () {
                        selectedTabId = 2;
                        mainHomeWidget = PaymentsPage();
                        setState(() {
                          showAuth();
                          selectedTabId;
                          mainHomeWidget;
                        });
                      }, selectedTabId == 2, 12),
                      HomeEachBottomTabIO(
                          'assets/images/insuranceInactive.svg','assets/images/underline.svg', "${'insurance'.tr}", () {
                        selectedTabId = 3;
                        mainHomeWidget = InsurancePage();
                        setState(() {
                          showAuth();
                          selectedTabId;
                          mainHomeWidget;
                        });
                      }, selectedTabId == 3, 12),
                      HomeEachBottomTabIO('assets/images/savingsInactive.svg','assets/images/underline.svg', "${'savings'.tr}", () {
                        selectedTabId = 4;
                        mainHomeWidget = SavingsPage();
                        setState(() {
                          showAuth();
                          selectedTabId;
                          mainHomeWidget;
                        });
                      }, selectedTabId == 4, 12),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs!.setBool(SPKeys.SHOW_AUTH, false);
  }
}
