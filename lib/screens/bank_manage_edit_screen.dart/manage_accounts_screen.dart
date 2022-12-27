import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/widgets/circular_progressbar.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/common_radio_card.dart';
import '../../widgets/loyalty_common_header.dart';
import '../loyality_points/cashback_redeem/cashback_redeemption_screen.dart';
import '../loyality_points/cashback_redeem/cb_manager.dart';
import '../loyality_points/cashback_redeem/your_accounts_page.dart';
import 'controller/update_bank_account_manager.dart';
import 'delete_bottom_sheet.dart';
import 'edit_accounts_screen.dart';
import 'edit_upi_screen.dart';

class ManageAccountsCard extends StatelessWidget {
  UpdateBankAccount updateBankAccount = Get.put(UpdateBankAccount());
  ManageAccountsCard({super.key});
  CashBackManager cashBackManager = Get.put(CashBackManager());

  final List<String> bankAccountType = [
    'saving',
    'current',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: updateBankAccount.isLoading.value == true
            ? Column(
              children: [
                CircularProgressbar(),
              ],
            )
            : SafeArea(
            child: Column(children: [
              const Align(
                alignment: Alignment.topCenter,
                child: CustomAppBar(
                  heading: 'Manage accounts',
                ),
              ),
              Obx(
                    () => cashBackManager.isLoading == true
                    ? CircularProgressbar()
                    : cashBackManager.customerBankList.length == 0 && cashBackManager.customerUPIList.length==0
                    ? Center(
                    child: Text(
                      "No Accounts!",
                      style: TextStyle(
                          fontSize: Dimens.font_20sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyText),
                    ))
                    :
                Expanded(
                    child:
                    ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.0.wp, vertical: 4.0.hp),
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
                            padding: EdgeInsets.only(
                                top: 2.0.hp, bottom: 4.0.hp),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.cardScreenBg),
                                borderRadius:
                                BorderRadius.circular(2.0.wp),
                              ),
                              child: Column(
                                children: List.generate(
                                    cashBackManager
                                        .customerBankList.length,
                                        (index) => CommonRadioCard(
                                      isEditable: true,
                                      isSelected: false,
                                      cardWidth: double.maxFinite,
                                      onEditPressed: () => Get.to(
                                              () => EditAccountsCard(
                                              bankList: cashBackManager
                                                  .bankList
                                                  .toList(),
                                              bankName: cashBackManager
                                                  .customerBankList[
                                              index]
                                                  .name,
                                              accountNumber: cashBackManager
                                                  .customerBankList[
                                              index]
                                                  .maskAccountNumber,
                                              ifscCode: cashBackManager
                                                  .customerBankList[
                                              index]
                                                  .ifscCode,
                                              accountType: cashBackManager
                                                  .customerBankList[
                                              index]
                                                  .accountType,
                                              id: cashBackManager
                                                  .customerBankList[
                                              index]
                                                  .id,
                                              index: index),
                                          arguments: [
                                            cashBackManager
                                                .customerBankList[
                                            index],
                                          ]),
                                      onDeletePressed: () =>
                                          CommonDeleteBottomSheet()
                                              .deleteBottomSheet(
                                              index: index,
                                              onDelete: () {
                                                print(
                                                    'Deleted ${cashBackManager.customerBankList[index].id} successfully');

                                                cashBackManager.delBankAccount(
                                                    cashBackManager
                                                        .customerBankList[
                                                    index]
                                                        .id);
                                                Get.back();


                                                //  cashBackManager.fetchCustomerBankAccounts();
                                              }),
                                      radioCardType:
                                      RadioCardType.bankAccount,
                                      bankAccountName:
                                      cashBackManager
                                          .customerBankList[
                                      index]
                                          .name,
                                      bankAccountIFSC:
                                      cashBackManager
                                          .customerBankList[
                                      index]
                                          .ifscCode,
                                      bankAccountNumber:
                                      cashBackManager
                                          .customerBankList[
                                      index]
                                          .maskAccountNumber,
                                      bankAccountType:
                                      cashBackManager
                                          .customerBankList[
                                      index]
                                          .accountType,
                                    )),
                              ),
                            ))
                            : const SizedBox.shrink(),
                        cashBackManager.customerUPIList.isNotEmpty
                            ? Text(
                          'Your UPI or VPA’s',
                          style: AppStyle.shortHeading.copyWith(
                              color: const Color(0xff2d2d2d),
                              fontWeight: FontWeight.w600),
                        )
                            : const SizedBox.shrink(),
                        cashBackManager.customerUPIList.isNotEmpty
                            ? Padding(
                            padding: EdgeInsets.only(
                                top: 2.0.hp, bottom: 4.0.hp),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.cardScreenBg),
                                borderRadius:
                                BorderRadius.circular(2.0.wp),
                              ),
                              child: Column(
                                children: List.generate(
                                    cashBackManager
                                        .customerUPIList.length,
                                        (index) => CommonRadioCard(
                                      isEditable: true,
                                      isSelected: false,
                                      onEditPressed: () =>
                                          Get.to(() {
                                            return EditUpi(
                                                upiId: cashBackManager
                                                    .customerUPIList[
                                                index]
                                                    .upiId,
                                                index: index,
                                                id: cashBackManager
                                                    .customerUPIList[
                                                index]
                                                    .id);
                                          }, arguments: [
                                            //  JsonModel().upiModel[index],
                                            RedeemMode.isUPI
                                          ]),
                                      onDeletePressed: () {
                                        CommonDeleteBottomSheet()
                                            .deleteBottomSheetUpi(
                                            onDelete: () async {
                                              print(
                                                  'Deleted ${cashBackManager.customerUPIList[index].upiId}');

                                              cashBackManager
                                                  .delUpiAccount(
                                                  cashBackManager
                                                      .customerUPIList[
                                                  index]
                                                      .id);

                                              Get.back();
                                              await Future.delayed(
                                                  Duration(seconds: 1),
                                                      () {
                                                    cashBackManager
                                                        .fetchCustomerUpiAccounts();
                                                    Get.back();
                                                  });
                                            });
                                      },
                                      cardWidth: double.maxFinite,
                                      radioCardType:
                                      RadioCardType.upi,
                                      upiId: cashBackManager
                                          .customerUPIList[index]
                                          .upiId,
                                    )),
                              ),
                            ))
                            : const SizedBox.shrink()
                      ],
                    )),
              )
            ])));
  }
}

enum RedeemMode { isBankAccount, isUPI }
