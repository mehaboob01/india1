import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../constant/theme_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:contacts_service/contacts_service.dart';

import '../../widgets/cards_io.dart';

class LoyaltyPoints extends StatefulWidget {
  const LoyaltyPoints({Key? key}) : super(key: key);

  @override
  State<LoyaltyPoints> createState() => _LoyaltyPointsState();
}

class _LoyaltyPointsState extends State<LoyaltyPoints> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: transParentAppbar('Loyalty program '),
        body: Column(

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(children: [
                CardScreen('assets/images/card_bg_celebration.png'),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,

                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 24, left: 12, right: 12),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Current balance',
                                      overflow: TextOverflow.visible,
                                      maxLines: 1,
                                      style: TextStyle(
                                        overflow: TextOverflow.visible,
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.white,
                                        fontSize: Dimens.font_14sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              child: Image.asset(
                                                "assets/images/coins.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              '52',
                                              style: TextStyle(
                                                overflow: TextOverflow.visible,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.white,
                                                fontSize: Dimens.font_24sp,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 2.0),
                                          child: Text(
                                            'Points',
                                            overflow: TextOverflow.visible,
                                            maxLines: 1,
                                            style: TextStyle(
                                              overflow: TextOverflow.visible,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.white,
                                              fontSize: Dimens.font_16sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: 36,
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Spacer(),
                                        Text(
                                          'Redeem Now',
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: Dimens.font_14sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.cardBg1),
                                        ),
                                        Spacer(),
                                        SizedBox(
                                          height: 36,
                                          child: Image.asset(
                                            "assets/images/btn_img.png",
                                            fit: BoxFit.fill,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                    )),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 44,
                              child: Padding(
                                padding:  EdgeInsets.all(12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [
                                        Text(
                                          'Total earned:',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: Dimens.font_14sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.white),
                                        ),
                                        SizedBox(width: 4,),
                                        Text(
                                          '71',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: Dimens.font_18sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.white),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Total Redeemed:',
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: Dimens.font_14sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.white),
                                        ),
                                        SizedBox(width: 4,),
                                        Text(
                                          '16',
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: Dimens.font_18sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(2.0),
                              )),
                          Spacer()
                        ],
                      ),
                    ),

                    Container(

                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      color: AppColors.white,
                      child: Column(

                        children: [
                          SizedBox(height: 4,),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 44,
                              child: Padding(
                                padding:  EdgeInsets.all(12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    Text(
                                      'Your rewards',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: Dimens.font_16sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black),
                                    ),

                                    Spacer(),
                                    Text(
                                      'History',
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: Dimens.font_14sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primary),
                                    ),

                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white,

                              )),



                        ],
                      ),
                    ),
                  ],
                ),

              ]),
            ),

          ],
        ));
  }
}
