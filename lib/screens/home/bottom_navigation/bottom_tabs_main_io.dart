import 'package:flutter/material.dart';
import 'package:india_one/constant/theme_manager.dart';

import 'package:india_one/screens/home/bottom_navigation/custom_widgets/home_each_bottom_tab_io.dart';

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
      backgroundColor: AppColors.passiveTabColor,
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            height: heightIs - 99,
            child: mainHomeWidget,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(18))),
              height: 54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeEachBottomTabIO(Icons.home_filled, "Home", () {
                    selectedTabId = 0;
                    mainHomeWidget = HomeMainIO();
                    setState(() {
                      selectedTabId;
                      mainHomeWidget;
                    });
                  }, selectedTabId == 0, 12),
                  HomeEachBottomTabIO(Icons.payments_sharp, "Payments", () {
                    selectedTabId = 1;
                    mainHomeWidget = PaymentsMainIO();
                    setState(() {
                      selectedTabId;
                      mainHomeWidget;
                    });
                  }, selectedTabId == 1, 12),
                  HomeEachBottomTabIO(Icons.clean_hands_sharp, "Loans", () {
                    selectedTabId = 2;
                    mainHomeWidget = LoansMainIO();
                    setState(() {
                      selectedTabId;
                      mainHomeWidget;
                    });
                  }, selectedTabId == 2, 12),
                  HomeEachBottomTabIO(
                      Icons.health_and_safety_outlined, "Insurances", () {
                    selectedTabId = 3;
                    mainHomeWidget = InsurancesMainIO();
                    setState(() {
                      selectedTabId;
                      mainHomeWidget;
                    });
                  }, selectedTabId == 3, 12),
                  HomeEachBottomTabIO(Icons.savings, "Savings", () {
                    selectedTabId = 4;
                    mainHomeWidget = SavingsMainIO();
                    setState(() {
                      selectedTabId;
                      mainHomeWidget;
                    });
                  }, selectedTabId == 4, 12),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
