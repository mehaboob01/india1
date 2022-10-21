import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';

import 'package:india_one/screens/home/bottom_navigation/custom_widgets/home_each_bottom_tab_io.dart';

import '../../../constant/other_constants_io.dart';

import '../../home_start/home_main_io.dart';
import '../../insurances/insurances_main_io.dart';
import '../../loans/loans_main_io.dart';
import '../../payments/payments_main_io.dart';
import '../../savings/savings_main_io.dart';

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
    mainHomeWidget = HomeMainIO();
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
                      HomeEachBottomTabIO('assets/images/homeInactive.svg','assets/images/dot_img.svg', "${'home'.tr}", () {
                        selectedTabId = 0;
                        mainHomeWidget = HomeMainIO();
                        setState(() {
                          selectedTabId;
                          mainHomeWidget;
                        });
                      }, selectedTabId == 0, 12),
                      HomeEachBottomTabIO('assets/images/loanInactive.svg','assets/images/dot_img.svg', "${'loans'.tr}", () {
                        selectedTabId = 1;
                        mainHomeWidget = LoansMainIO();
                        setState(() {
                          selectedTabId;
                          mainHomeWidget;
                        });
                      }, selectedTabId == 1, 12),
                      HomeEachBottomTabIO('assets/images/paymentsInactive.svg','assets/images/dot_img.svg', "${'payments'.tr}", () {
                        selectedTabId = 2;
                        mainHomeWidget = PaymentsMainIO();
                        setState(() {
                          selectedTabId;
                          mainHomeWidget;
                        });
                      }, selectedTabId == 2, 12),
                      HomeEachBottomTabIO(
                          'assets/images/insuranceInactive.svg','assets/images/dot_img.svg', "${'insurance'.tr}", () {
                        selectedTabId = 3;
                        mainHomeWidget = InsurancesMainIO();
                        setState(() {
                          selectedTabId;
                          mainHomeWidget;
                        });
                      }, selectedTabId == 3, 12),
                      HomeEachBottomTabIO('assets/images/savingsInactive.svg','assets/images/dot_img.svg', "${'savings'.tr}", () {
                        selectedTabId = 4;
                        mainHomeWidget = SavingsMainIO();
                        setState(() {
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
}
