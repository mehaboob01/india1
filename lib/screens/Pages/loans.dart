import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/core/data/remote/api_constant.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/utils/common_webview.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/card.dart';
import '../../widgets/common_banner.dart';
import '../../widgets/common_page_header.dart';
import '../home_start/home_manager.dart';
import '../loans/track_based_loan/track_based_loan.dart';
import 'loan_dashboard_history.dart';

class LoansPage extends StatefulWidget {
  @override
  State<LoansPage> createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  HomeManager _homeManager = Get.put(HomeManager());

  LoanController loanController = Get.put(LoanController());


  @override
  void initState() {
    super.initState();
    _homeManager.showAuth.value = false;
    loanController.recentTransactions();
  }

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
              CommonPageHeader(pageName: PageName.loans),
              CommonPageCategoriesHeading(pageName: PageName.loans),
              Padding(
                padding: EdgeInsets.only(
                    bottom: 2.0.hp, left: 4.0.wp, right: 4.0.wp),
                child: const LoansCard(),
              ),
              CommonBanner(),

              //  loans history
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
            label: 'personal',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed(MRouter.bikeLoanIO);
          },
          child: ItemCard(
            image: AppImages.bikeSvg,
            label: '2_wheeler',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        ),

        InkWell(
          onTap: () {
            Get.toNamed(MRouter.farmLoan);
          },
          child: ItemCard(
            image: AppImages.tractorSvg,
            label: 'farm_eqp',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(() => TrackBasedLoan());
          },
          child: ItemCard(
            image: AppImages.tractorSvg,
            label: 'track_based_loan',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        ),

        InkWell(
          onTap: () {
            Get.toNamed(MRouter.goldLoanIO);
          },
          child: ItemCard(
            image: AppImages.goldSvg,
            label: 'gold',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed(MRouter.emiCard);
          },
          child: ItemCard(
            image: AppImages.creditCardSvg,
            label: 'emi_card',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed(MRouter.creditCard);
          },
          child: ItemCard(
            image: AppImages.creditCardSvg,
            label: 'credit_card',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed(MRouter.creditScore);
          },
          child: ItemCard(
            image: AppImages.creditScoreSvg,
            label: 'credit_score',
            itembgColor: ItemCardbgColor.lightBlue,
          ),
        )
      ],
    );
  }
}
