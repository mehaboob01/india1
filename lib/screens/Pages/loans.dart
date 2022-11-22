import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/core/data/remote/api_constant.dart';
import 'package:india_one/screens/Pages/loan_dashboard_history.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/utils/common_webview.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/card.dart';
import '../../widgets/common_banner.dart';
import '../../widgets/common_page_header.dart';

class LoansPage extends StatefulWidget {
  @override
  State<LoansPage> createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  LoanController loanController = Get.put(LoanController());

  @override
  void initState() {
    super.initState();
    loanController.recentTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonPageHeader(pageName: PageName.loans),
              CommonPageCategoriesHeading(pageName: PageName.loans),
              Padding(
                padding: EdgeInsets.only(bottom: 2.0.hp, left: 4.0.wp, right: 4.0.wp),
                child: const LoansCard(),
              ),
              CommonBanner(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: LoanDashboardHistory(isFromLoans: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoansCard extends StatelessWidget {
  const LoansCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2.0.wp,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(MRouter.chooseAmountIO);
          },
          child: ItemCard(
            image: AppImages.handRupeeSvg,
            label: 'Personal',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed(MRouter.bikeLoanIO);
          },
          child: ItemCard(
            image: AppImages.bikeSvg,
            label: 'Bike',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed(MRouter.carLoanIO);
          },
          child: ItemCard(
            image: AppImages.carSvg,
            label: 'Car',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     Get.toNamed(MRouter.tractorLoanIO);
        //   },
        //   child: ItemCard(
        //     image: AppImages.tractorSvg,
        //     label: 'Tractor',
        //     itembgColor: ItemCardbgColor.lightBlue,
        //   ),
        // ),
        InkWell(
          onTap: () {
            Get.toNamed(MRouter.farmLoan);
          },
          child: ItemCard(
            image: AppImages.tractorSvg,
            label: 'Farm',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     Get.to(() => CommonWebView(
        //       title: 'MSME',
        //       url: Apis.msme,
        //     ));
        //   },
        //   child: ItemCard(
        //     image: AppImages.handSackSvg,
        //     label: 'MSME',
        //     itembgColor: ItemCardbgColor.lightBlue,
        //   ),
        // ),
        InkWell(
          onTap: () {
            Get.toNamed(MRouter.goldLoanIO);
          },
          child: ItemCard(
            image: AppImages.goldSvg,
            label: 'Gold',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(() => CommonWebView(
                  title: 'Credit Card',
                  url: Apis.creditCard,
                ));
          },
          child: ItemCard(
            image: AppImages.creditCardSvg,
            label: 'Emi Card',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(() => CommonWebView(
                  title: 'Credit Card',
                  url: Apis.creditCard,
                ));
          },
          child: ItemCard(
            image: AppImages.creditCardSvg,
            label: 'Credit Card',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(() => CommonWebView(
                  title: 'Credit Score',
                  url: Apis.creditScore,
                ));
          },
          child: ItemCard(
            image: AppImages.creditScoreSvg,
            label: 'Credit Score',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        )
      ],
    );
  }
}
