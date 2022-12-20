import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/controller/loan_controller.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/screens/loans/model/loan_lenders_model.dart';
import 'package:india_one/screens/loans/provider_details.dart';
import 'package:india_one/utils/common_appbar_icons.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/data/remote/api_constant.dart';
import '../../utils/common_webview.dart';
import 'model/NewLoanLenderModel.dart';

class ProvidersList extends StatefulWidget {
  final String title;
  final String providerId;

  // test

  const ProvidersList({
    Key? key,
    required this.title,
    required this.providerId,
  }) : super(key: key);

  @override
  State<ProvidersList> createState() => _ProvidersListState();
}

class _ProvidersListState extends State<ProvidersList> {
  LoanController loanController = Get.put(LoanController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loanController.getProviders(
          isPersonalLoan: false, providerId: widget.providerId);
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
                    customActionIconsList: commonAppIcons),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child: Text(
                    "Choose one lender from the list",
                    style: TextStyle(
                      color: AppColors.lightBlack,
                      fontSize: Dimens.font_16sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child:
                       ListView.builder(
                              shrinkWrap: true,
                              itemCount: loanController.loanLendersModel.value.lenders?.length,
                              itemBuilder: (context, index) {
                                List<Lenders>? lenders = loanController.loanLendersModel.value.lenders;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(12),
                                                  ),
                                                  height: 50,
                                                  width: 50,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(12),
                                                    child: CachedNetworkImage(
                                                      imageUrl: lenders?[index].details?.url == null? "":
                                                      lenders![index].details!.url.toString(),

                                                      errorWidget:
                                                          (context, _, error) {
                                                        return Icon(
                                                          Icons
                                                              .warning_amber_outlined,
                                                        );
                                                      },
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:  EdgeInsets
                                                            .symmetric(
                                                        horizontal: 16.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                         lenders?[index].details?.lender??
                                                              "Bajaj Finance",
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .lightBlack,
                                                            fontSize:
                                                                Dimens.font_16sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                         lenders?[index].details?.keywords == null?"": lenders![index].details!.keywords.toString(),
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .borderColor,
                                                            fontSize:
                                                                Dimens.font_14sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          if ("lenders?.keywords" != null ||
                                              "lenders?.keywords" != []) ...[
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              // child: Row(
                                              //   children: [
                                              //     ..."lenders"!.keywords!.map((e) =>
                                              //         Container(
                                              //           padding:
                                              //               EdgeInsets.symmetric(
                                              //             horizontal: 8,
                                              //             vertical: 4,
                                              //           ),
                                              //           margin:
                                              //               EdgeInsets.symmetric(
                                              //             horizontal: 4,
                                              //           ),
                                              //           decoration: BoxDecoration(
                                              //             borderRadius:
                                              //                 BorderRadius
                                              //                     .circular(10),
                                              //             color: AppColors
                                              //                 .lightSkyBlue,
                                              //           ),
                                              //           child: Text(
                                              //             e ?? '',
                                              //             style: TextStyle(
                                              //               color: AppColors
                                              //                   .borderColor,
                                              //               fontSize:
                                              //                   Dimens.font_14sp,
                                              //               fontWeight:
                                              //                   FontWeight.w500,
                                              //             ),
                                              //           ),
                                              //         ))
                                              //   ],
                                              // ),
                                            )
                                          ],
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(16.0),
                                            decoration: BoxDecoration(
                                              color: AppColors.lightGreyColors,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                LoanCommon().rowText(
                                                  value: 'Max amount',
                                                  title:
                                                      '₹ ${lenders?[index].details?.loanAmount == null ? "0" :lenders![index].details?.loanAmount}',
                                                ),
                                                LoanCommon().rowText(
                                                  value: 'Tenure',
                                                  title:
                                                  '${lenders?[index].details?.tenure == null ? "0" :lenders![index].details?.tenure}'
                                                ),
                                                LoanCommon().rowText(
                                                  value: 'Interest/m',
                                                  title:
                                                  ' ${lenders?[index].details?.loanInterest == null ? "0" :lenders![index].details?.loanInterest}'
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16.0,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: LoanCommon().borderButton(
                                                  title: 'View details',
                                                  callBack: () {
                                                    Get.to(() => CommonWebView(
                                                      title: 'Loan details',
                                                      url: lenders?[index].details?.url == null ?"":lenders![index].details!.url.toString(),
                                                    ));

                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Expanded(
                                                child: LoanCommon().filledButton(
                                                  title: 'Apply',
                                                  callBack: () {
                                                    LoanCommon().bottomSheet(
                                                      context,
                                                      lenderId: loanController
                                                              .loanLendersModel
                                                              .value
                                                              .lenders?[index]
                                                              .id == null? "":loanController
                                                          .loanLendersModel
                                                          .value
                                                          .lenders![index]
                                                          .id ??
                                                          '',
                                                      callBack: () {
                                                        Get.back();
                                                        loanController.applyLoan(
                                                          providerId: loanController
                                                                  .loanProvidersModel
                                                                  .value
                                                                  .providers?[
                                                                      index]
                                                                  .id ??
                                                              '',
                                                          lenderId: loanController
                                                                  .loanLendersModel
                                                                  .value
                                                                  .lenders?[index]
                                                                  .id == null ?"":loanController
                                                              .loanLendersModel
                                                              .value
                                                              .lenders?[index]
                                                              .id ??
                                                              '',
                                                        );
                                                      },
                                                      providerId: '',
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                        ),


              ],
            ),
            // Obx(() {
            //   if (loanController.createLoanLoading.value == true) {
            //     return Container(
            //       alignment: Alignment.center,
            //       color: Colors.white,
            //       child: LoadingAnimationWidget.inkDrop(
            //         size: 34,
            //         color: AppColors.primary,
            //       ),
            //     );
            //   } else {
            //     return Container();
            //   }
            // })
          ],
        ),
      ),
    );
  }
}
