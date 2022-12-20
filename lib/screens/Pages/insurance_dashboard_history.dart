import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/screens/insurances/model/insurance_recent_transaction_model.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/loyalty_common_header.dart';

class InsuranceDashboardHistory extends StatelessWidget {
  final bool isFromInsurance;

  InsuranceDashboardHistory({Key? key, required this.isFromInsurance})
      : super(key: key);

  LoanController loanController = Get.put(LoanController());

  final TextStyle _stats = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Color(0xFF2D2D2D),
  );
  final TextStyle _statsTitle = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Color(0xFF333333),
  );

  @override
  Widget build(BuildContext context) {
    return isFromInsurance
        ? body()
        : Scaffold(
            primary: false,
            body: Column(
              children: [
                SafeArea(
                  child: CustomAppBar(
                    heading: 'Recent transactions',
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(0),
                    child: body(),
                  ),
                ),
              ],
            ),
          );
  }

  Widget body() {
    return Obx(() => Column(
          children: [
            if (isFromInsurance == true) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent transactions",
                      style: AppStyle.shortHeading.copyWith(
                        color: Color(0xff2d2d2d),
                        fontSize: 14.0.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() =>
                            InsuranceDashboardHistory(isFromInsurance: false));
                      },
                      child: Text(
                        "History",
                        style: AppStyle.shortHeading.copyWith(
                          color: AppColors.orangeGradient2,
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (loanController.createLoanLoading.value == true) ...[
              Center(
                child: LoadingAnimationWidget.inkDrop(
                  size: 34,
                  color: AppColors.primary,
                ),
              )
            ] else ...[
              if (loanController.insuranceRecentTransactionModel.value
                  .recentTransactions!.isEmpty) ...[
                Text("No recent transaction found")
              ] else ...[
                ListView.builder(
                  padding:
                      EdgeInsets.symmetric(vertical: isFromInsurance ? 0 : 16),
                  itemCount: isFromInsurance &&
                          loanController.insuranceRecentTransactionModel.value
                                  .recentTransactions!.length >
                              5
                      ? 5
                      : loanController.insuranceRecentTransactionModel.value
                          .recentTransactions!.length,
                  primary: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    RecentTransactions e = loanController
                        .insuranceRecentTransactionModel
                        .value
                        .recentTransactions![index];
                    return Container(
                      padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                height: 50,
                                width: 50,
                                child: CachedNetworkImage(
                                  imageUrl: e.logoUrl ?? '',
                                  errorWidget: (context, _, error) {
                                    return Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 110,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.title ?? '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF2D2D2D),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    e.type ?? '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF999999),
                                        fontSize: 14),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("₹ ${e.amount ?? 0}", style: _stats),
                                    Text(
                                      "Amount coveres",
                                      style: _statsTitle,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${e.dateTime != null || e.dateTime != '' ? DateFormat('dd-MMM-yyyy').format(DateTime.parse(e.dateTime.toString())) : ''}",
                                      style: _stats,
                                    ),
                                    Text(
                                      "Bought On",
                                      style: _statsTitle,
                                    )
                                  ],
                                ),
                              ),
                              // Expanded(
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.end,
                              //     children: [
                              //       Text(
                              //         e.status ?? '',
                              //         style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: loanController.statusTextColor(e.status ?? '')),
                              //       ),
                              //       Text(
                              //         "Status",
                              //         style: _statsTitle,
                              //       )
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  shrinkWrap: true,
                )
              ]
            ],
          ],
        ));
  }
}
