import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/screens/insurances/controller/insurance_controller.dart';
import 'package:india_one/screens/insurances/widgets/custom_drop_down.dart';
import 'package:india_one/screens/insurances/widgets/policy_item_widget.dart';
import 'package:india_one/utils/common_appbar_icons.dart';

import '../../../constant/theme_manager.dart';
import '../../../widgets/circular_progressbar.dart';
import '../../../widgets/loyalty_common_header.dart';
import '../insurance_common.dart';
import '../model/insurance_application_model.dart';

class HealthInsurance extends StatefulWidget {
  final bool isAccidentInsurance;

  const HealthInsurance({
    Key? key,
    required this.isAccidentInsurance,
  }) : super(key: key);

  @override
  State<HealthInsurance> createState() => _HealthInsuranceState();
}

class _HealthInsuranceState extends State<HealthInsurance> {
  double widthIs = 0, heightIs = 0;
  InsuranceController insuranceController = Get.put(InsuranceController());

  @override
  void initState() {
    super.initState();

    insuranceController.createInsuranceApplication(
        insuranceType: InsuranceType.CriticalIllness);
  }

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: body(),
    );
  }

  Widget body() {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(
              heading: widget.isAccidentInsurance
                  ? 'Critical Illness'
                  : "Critical Illness",
              customActionIconsList: commonAppIcons),
          Container(
            width: widthIs,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.loyaltyCardBg),
                    fit: BoxFit.fill)
                // gradient: new LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                //   colors: [AppColors.blueColor, AppColors.backGroundgradient2],
                // ),
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select a plan",
                  style: AppTextThemes.button,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Choose sum insured to view the most suited policies.",
                  style: AppTextThemes.labelStyle.apply(
                    color: AppColors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: Colors.transparent),
                    color: AppColors.backGroundgradient2,
                  ),
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: CustomDropDown(
                      item: <String>[
                        'Sum insured for 1 lakh',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value.toString(),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        insuranceController.insuranceFilter.value = value;
                      },
                      // label: 'Two wheeler required',
                      hint: 'Select insurance amount',
                      value: insuranceController.insuranceFilter.value == ''
                          ? null
                          : insuranceController.insuranceFilter.value,
                    ),
                  ),
                ),
                /* SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppImages.imgSearch),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              hintText: "Search by policy name"),
                        ),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              return insuranceController.createInsuranceApplicationLoading.value
                  ? CircularProgressbar()
                  : (insuranceController.insuranceApplicationModel.value.plans
                                  ?.length ??
                              0) ==
                          0
                      ? Text("No data available")
                      : ListView.separated(
                          itemCount: insuranceController
                                  .insuranceApplicationModel
                                  .value
                                  .plans
                                  ?.length ??
                              0,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemBuilder: (context, index) {
                            return PolicyItemWidget(
                              plan: insuranceController
                                      .insuranceApplicationModel
                                      .value
                                      .plans?[index] ??
                                  Plans(),
                              isAccidentInsurance: widget.isAccidentInsurance,
                            );
                          },
                        );
            }),
          ),
        ],
      ),
    );
  }
}
