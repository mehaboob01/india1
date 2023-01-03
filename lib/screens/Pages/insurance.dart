import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/screens/insurances/health/health_insurance.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';

import '../../constant/routes.dart';
import '../../constant/theme_manager.dart';
import '../../widgets/card.dart';
import '../../widgets/common_banner.dart';
import '../../widgets/common_page_header.dart';
import '../home_start/home_manager.dart';
import 'insurance_dashboard_history.dart';
import 'loan_dashboard_history.dart';

class InsurancePage extends StatefulWidget {
  @override
  State<InsurancePage> createState() => _InsurancePageState();
}

class _InsurancePageState extends State<InsurancePage> {
  HomeManager _homeManager = Get.put(HomeManager());
  LoanController loanController = Get.put(LoanController());

  @override
  void initState() {
    super.initState();
    _homeManager.showAuth.value = false;
    loanController.insuranceRecentTransactions();
  }

  // const InsurancePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonPageHeader(pageName: PageName.insurance),
              CommonPageCategoriesHeading(pageName: PageName.insurance),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 2.0.hp, left: 4.0.wp, right: 4.0.wp),
                child: const InsuranceCard(),
              ),
              CommonBanner(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: InsuranceDashboardHistory(isFromInsurance: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InsuranceCard extends StatelessWidget {
  const InsuranceCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2.0.wp,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(MRouter.bikeInsurance);
          },
          child: ItemCard(
            image: AppImages.bikeSvg,
            label: '2_wheeler',
            itembgColor: ItemCardbgColor.lightRed2,
          ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed(MRouter.carInsurance);
          },
          child: ItemCard(
            image: AppImages.carSvg,
            label: '4_wheeler',
            itembgColor: ItemCardbgColor.lightRed2,
          ),
        ),
        InkWell(
          onTap: () {
            // Get.toNamed(MRouter.healthInsurance, arguments: [
            //   {"isAccidentInsurance": false}
            // ]);
            Get.to(()=>HealthInsurance(isAccidentInsurance: false,));
          },
          child: ItemCard(
            image: AppImages.criticalIllnessSvg,
            label: 'critical_illness',
            itembgColor: ItemCardbgColor.lightRed2,
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     // Get.toNamed(MRouter.healthInsurance, arguments: [
        //     //   {"isAccidentInsurance": true}
        //     // ]);
        //     Get.to(()=>HealthInsurance(isAccidentInsurance: false,));
        //   },
        //   child: ItemCard(
        //     image: AppImages.accidentSvg,
        //     label: 'Accident',
        //     itembgColor: ItemCardbgColor.lightRed2,
        //   ),
        // ),
      ],
    );
  }
}
