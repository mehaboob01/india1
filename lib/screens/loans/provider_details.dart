import 'package:draggable_bottom_sheet_nullsafety/draggable_bottom_sheet_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/screens/loans/loan_common.dart';
import 'package:india_one/widgets/loyalty_common_header.dart';

class ProviderDetail extends StatelessWidget {
  final String title;
  const ProviderDetail({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                CustomAppBar(
                  heading: '$title',
                  customActionIconsList: [
                    CustomActionIcons(
                      image: AppImages.bottomNavHome,
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-2, 0),
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.selectedLangColor,
                        AppColors.backGroundgradient2,
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(12),
                  child: LoanCommon().loanCard(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Top Features",
                            style: TextStyle(
                              color: AppColors.lightBlack,
                              fontSize: Dimens.font_20sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          ListView.builder(
                            itemCount: 2,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return LoanCommon().bulletPoint(
                                title: "Minimum documentation",
                              );
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Other details",
                            style: TextStyle(
                              color: AppColors.lightBlack,
                              fontSize: Dimens.font_20sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            itemCount: 20,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ExpansionTile(
                                tilePadding: EdgeInsets.all(0),
                                title: Text(
                                  'Interest Rate',
                                ),
                                children: [
                                  Text("Demo text"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: InkWell(
                onTap: (){
                  LoanCommon().bottomSheet(context);
                },
                child: LoanCommon().customButton(
                  title: 'Apply now',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
