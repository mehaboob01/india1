import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/provider_details.dart';
import 'package:india_one/screens/loans/provider_list.dart';
import 'package:india_one/utils/common_appbar_icons.dart';
import 'package:india_one/utils/common_webview.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../connection_manager/ConnectionManagerController.dart';

class LendersListOthers extends StatefulWidget {
  final String title;

  const LendersListOthers({Key? key, required this.title}) : super(key: key);

  @override
  State<LendersListOthers> createState() => _LendersListState();
}

class _LendersListState extends State<LendersListOthers> {
  LoanController loanController = Get.put(LoanController());
  bool isPersonalLoan = false;

  @override
  void initState() {
    super.initState();
    isPersonalLoan = (widget.title == 'Personal loan') ? true : false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loanController.getProviders(
          isPersonalLoan: isPersonalLoan, providerId: "", fromScreen: "Gold");
    });
  }

  final ConnectionManagerController _controller =
      Get.find<ConnectionManagerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IgnorePointer(
        ignoring: _controller.ignorePointer.value,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                        heading: '${widget.title}',
                        customActionIconsList: commonAppIcons),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                      child: text(
                        "Select the lender to proceed",
                        style: TextStyle(
                          color: AppColors.lightBlack,
                          fontSize: Dimens.font_16sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => (loanController
                                        .loanLenderOthersModel.value.lenders ==
                                    null ||
                                loanController
                                        .loanLenderOthersModel.value.lenders ==
                                    [])
                            ? Center(child: text("No lenders found"))
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: isPersonalLoan
                                    ? loanController.loanLenderOthersModel.value
                                        .lenders!.length
                                    : loanController.loanLenderOthersModel.value
                                        .lenders!.length,
                                itemBuilder: (context, index) {
                                  return LoanCommon().loanCard(
                                    lenders: loanController
                                        .loanLenderOthersModel
                                        .value
                                        .lenders?[index],
                                    applyButtonClick: () {
                                      if (loanController
                                              .loanLenderOthersModel
                                              .value
                                              .lenders![index]
                                              .loanApplyType !=
                                          "Redirect") {
                                        Get.to(
                                          () => ProviderDetail(
                                            title:
                                                '${widget.title}',
                                            lenders: loanController
                                                .loanLenderOthersModel
                                                .value
                                                .lenders![index],
                                            personalLoan: isPersonalLoan,
                                            providerId: loanController
                                                    .loanProvidersModel
                                                    .value
                                                    .providers?[index]
                                                    .id ??
                                                '',
                                          ),
                                        );

                                        // print("going to detail screen");
                                        // Get.to(
                                        //   () => ProviderDetail(
                                        //     title: '',
                                        //     personalLoan: '',
                                        //     lenders: '',
                                        //     providerId: '',
                                        //   ),
                                        // );
                                      } else {
                                        print("going to web screen");

                                        Get.to(
                                          () => CommonWebView(
                                            title: 'Gold Loan',
                                            url: loanController
                                                    .loanLenderOthersModel
                                                    .value
                                                    .lenders![index]
                                                    ?.redirectUrl
                                                    .toString() ??
                                                '',
                                          ),
                                        );
                                      }
                                    },
                                    isPersonalLoan: isPersonalLoan,
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  if (loanController.createLoanLoading.value == true) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: LoadingAnimationWidget.inkDrop(
                        size: 34,
                        color: AppColors.primary,
                      ),
                    );
                  } else {
                    return Container();
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
