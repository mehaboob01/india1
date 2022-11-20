import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/provider_details.dart';
import 'package:india_one/screens/loans/provider_list.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LendersList extends StatefulWidget {
  final String title;

  const LendersList({Key? key, required this.title}) : super(key: key);

  @override
  State<LendersList> createState() => _LendersListState();
}

class _LendersListState extends State<LendersList> {
  LoanController loanController = Get.put(LoanController());
  bool isPersonalLoan = false;

  @override
  void initState() {
    super.initState();
    isPersonalLoan = (widget.title == 'Personal loan') ? true : false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loanController.getProviders(isPersonalLoan: isPersonalLoan);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  heading: '${widget.title}',
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
                    () => (isPersonalLoan
                            ? (loanController.loanProvidersModel.value.providers == null || loanController.loanProvidersModel.value.providers == [])
                            : (loanController.loanLendersModel.value.lenders == null || loanController.loanLendersModel.value.lenders == []))
                        ? Center(child: Text("No providers found"))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: isPersonalLoan ? loanController.loanProvidersModel.value.providers!.length : loanController.loanLendersModel.value.lenders!.length,
                            itemBuilder: (context, index) {
                              return LoanCommon().loanCard(
                                providers: loanController.loanProvidersModel.value.providers?[index],
                                lenders: loanController.loanLendersModel.value.lenders?[index],
                                applyButtonClick: () {
                                  if (isPersonalLoan == true) {
                                    Get.to(
                                      () => ProvidersList(
                                        title: '${widget.title}',
                                        providerId: loanController.loanProvidersModel.value.providers?[index].id ?? '',
                                      ),
                                    );
                                  } else {
                                    Get.to(
                                      () => ProviderDetail(
                                        title: '${widget.title}',
                                        lenders: loanController.loanLendersModel.value.lenders![index],
                                        personalLoan: isPersonalLoan,
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
    );
  }
}
