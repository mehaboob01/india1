import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/common_radio_card.dart';
import '../../widgets/loyalty_common_header.dart';
import '../loyality_points/cashback_redeem/cashback_redeemption_screen.dart';
import '../loyality_points/cashback_redeem/cb_manager.dart';
import '../loyality_points/cashback_redeem/your_accounts_page.dart';
import 'delete_bottom_sheet.dart';
import 'edit_accounts_screen.dart';

class ManageAccountsCard extends StatelessWidget {
  ManageAccountsCard({super.key});
  final cashBackManager = Get.find<CashBackManager>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(children: [
          const Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(
              heading: 'Manage accounts',
            ),
          ),
          Expanded(
              child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 2.0.wp, vertical: 4.0.hp),
            children: [
              cashBackManager.customerBankList.isNotEmpty
                  ? Text(
                      'Your accounts',
                      style: AppStyle.shortHeading.copyWith(
                          color: const Color(0xff2d2d2d),
                          fontWeight: FontWeight.w600),
                    )
                  : const SizedBox.shrink(),
              cashBackManager.customerBankList.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: 2.0.hp, bottom: 4.0.hp),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.cardScreenBg),
                          borderRadius: BorderRadius.circular(2.0.wp),
                        ),
                        child: Column(
                          children: List.generate(
                              cashBackManager.customerBankList.length,
                              (index) => CommonRadioCard(
                                    isEditable: true,
                                    isSelected: false,
                                    cardWidth: double.maxFinite,
                                    onEditPressed: () => Get.to(
                                        () => EditAccountsCard(),
                                        arguments: [
                                          cashBackManager
                                              .customerBankList[index],
                                          RedeemMode.isBankAccount
                                        ]),
                                    onDeletePressed: () =>
                                        CommonDeleteBottomSheet()
                                            .deleteBottomSheet(
                                                index: index,
                                                onDelete: () {
                                                  print(
                                                      'Deleted ${cashBackManager.customerBankList[index].name} successfully');
                                                }),
                                    radioCardType: RadioCardType.bankAccount,
                                    bankAccountName: cashBackManager
                                        .customerBankList[index].name,
                                    bankAccountIFSC: cashBackManager
                                        .customerBankList[index].ifscCode,
                                    bankAccountNumber: cashBackManager
                                        .customerBankList[index]
                                        .maskAccountNumber,
                                    bankAccountType: cashBackManager
                                        .customerBankList[index].accountType,
                                  )),
                        ),
                      ))
                  : const SizedBox.shrink(),
              UserAccountPage().upiCard.isNotEmpty
                  ? Text(
                      'Your UPI or VPA’s',
                      style: AppStyle.shortHeading.copyWith(
                          color: const Color(0xff2d2d2d),
                          fontWeight: FontWeight.w600),
                    )
                  : const SizedBox.shrink(),
              UserAccountPage().upiCard.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: 2.0.hp, bottom: 4.0.hp),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.cardScreenBg),
                          borderRadius: BorderRadius.circular(2.0.wp),
                        ),
                        child: Column(
                          children: List.generate(
                              UserAccountPage().upiCard.length,
                              (index) => CommonRadioCard(
                                    isEditable: true,
                                    isSelected: false,
                                    onEditPressed: () => Get.to(
                                        () => EditAccountsCard(),
                                        fullscreenDialog: true,
                                        arguments: [
                                          //  JsonModel().upiModel[index],
                                          RedeemMode.isUPI
                                        ]),
                                    onDeletePressed: () {
                                      CommonDeleteBottomSheet()
                                          .deleteBottomSheet(
                                              index: index, onDelete: () {});
                                      // onDelete: () => JsonModel()
                                      //     .accountModel
                                      //     .removeAt(index));
                                    },
                                    cardWidth: double.maxFinite,
                                    radioCardType: RadioCardType.upi,
                                    upiId: CardModel().upiModel[index]['upiId'],
                                  )),
                        ),
                      ))
                  : const SizedBox.shrink()
            ],
          ))
        ])));
  }
}
