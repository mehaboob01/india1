import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/provider_details.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';

class ProviderList extends StatelessWidget {
  final String title;

  const ProviderList({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              heading: '$title',
              customActionIconsList: [
                CustomActionIcons(
                  image: AppImages.bottomNavHome,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              child: Text(
                "Choose one among the providers to proceed",
                style: TextStyle(
                  color: AppColors.lightBlack,
                  fontSize: Dimens.font_16sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return LoanCommon().loanCard(
                    applyButtonClick: () {
                      Get.to(() => ProviderDetail(
                            title: '$title',
                          ));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
