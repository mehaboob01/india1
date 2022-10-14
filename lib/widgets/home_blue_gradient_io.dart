import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:india_one/widgets/text_io.dart';
import '../constant/theme_manager.dart';
import '../screens/home_start/home_manager.dart';
import 'container_only_io.dart';
import 'divider_io.dart';
import 'icon_io.dart';

class HomeBlueGradientIO extends StatefulWidget {
  HomeBlueGradientIO({Key? key}) : super(key: key);

  @override
  State<HomeBlueGradientIO> createState() => _HomeBlueGradientIOState();
}

class _HomeBlueGradientIOState extends State<HomeBlueGradientIO> {
  double heightIs = 0, widthIs = 0;

  HomeManager _homeManager = Get.put(HomeManager());

  @override
  Widget build(BuildContext context) {
    widthIs = MediaQuery.of(context).size.width;
    heightIs = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(3),
      width: widthIs,
      height: 378,

      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                AppColors.homeGradient1Color,
                AppColors.homeGradient2Color,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            topLeft: Radius.circular(0),
          )),
      child:

      Stack(
        children:

       [
         Image.asset(
           'assets/tile_images/card_bg.png',
           fit: BoxFit.fill,
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height*0.8,
         ),
         Padding(
           padding: const EdgeInsets.all(4.0),
           child: SafeArea(
             child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         'Welcome!',
                         overflow: TextOverflow.visible,
                         maxLines: 1,
                         style: TextStyle(
                           overflow: TextOverflow.visible,
                           fontWeight: FontWeight.w500,
                           color: AppColors.white,
                           fontSize: Dimens.font_18sp,
                         ),
                       ),
                       Row(
                         children: [
                           //Spacer(),
                           Container(
                             height:  28,
                             width: 28,
                             child: Center(
                               child: Text(
                                 'Aa',
                                 overflow: TextOverflow.visible,
                                 maxLines: 1,
                                 style: TextStyle(
                                   overflow: TextOverflow.visible,
                                   fontWeight: FontWeight.w500,
                                   color: Colors.black.withOpacity(0.7),
                                   fontSize: Dimens.font_18sp,
                                 ),
                               ),
                             ),

                             decoration: BoxDecoration(
                               color: AppColors.white.withOpacity(0.9),
                               borderRadius: BorderRadius.circular(6.0),
                             ),),
                          SizedBox(width: 8,),
                           Container(
                             height:  28,
                             width: 28,
                             child: Icon(
                               CupertinoIcons.bell,
                               color: Colors.black.withOpacity(0.7),
                               // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                             ),

                             decoration: BoxDecoration(
                               color: AppColors.white.withOpacity(0.9),
                               borderRadius: BorderRadius.circular(6.0),
                             ),),
                           SizedBox(width: 8,),
                           Container(
                             height:  28,
                             width: 28,
                             child: Icon(
                               CupertinoIcons.profile_circled,
                               color: Colors.black.withOpacity(0.7),
                              // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                             ),

                             decoration: BoxDecoration(
                               color: AppColors.white.withOpacity(0.9),
                               borderRadius: BorderRadius.circular(6.0),
                             ),),
                           //Spacer(),
                           // IconIO(
                           //   Icons.notifications,
                           //   onpressed: () {},
                           //   color: AppColors.whiteColor,
                           // ),
                           // IconIO(
                           //   Icons.account_box,
                           //   onpressed: () {},
                           //   color: AppColors.whiteColor,
                           // ),
                         ],
                       )
                     ],
                   ),
                 ),
                 SizedBox(height: 6,),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Align(
                     alignment: Alignment.centerLeft,
                     child:  Text(
                       'Cashback by India1 summary',
                       maxLines: 2,
                       style: TextStyle(
                           fontSize: Dimens.font_18sp,
                           fontWeight: FontWeight.w600,
                           color: AppColors.white),
                     ),
                   ),
                 ),
                 SizedBox(height: 12,),
                 Row(
                   children: [
                     ContainerOnlyIO(
                       [40, 9, 9, 9],
                       Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           TextIO(
                             "Current balance",
                             color: AppColors.whiteColor,
                             fontWeight: FontWeight.w500,
                             size: 16,
                             padding: 0,
                           ),
                           DividerIO(
                             height: 6,
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
                                   Obx(()=>  Text(
                                       _homeManager.redeemablePoints.toString(),
                                       style: TextStyle(
                                         overflow: TextOverflow.visible,
                                         fontWeight: FontWeight.w500,
                                         color: AppColors.white,
                                         fontSize: Dimens.font_24sp,
                                       ),
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
                       [9, 0, 27, 0],
                       width: widthIs / 2.16,
                       height: 72,
                       color: AppColors.homeGradientUpperLayerColor,
                     ),
                     ContainerOnlyIO(
                       [9, 9, 9, 40],
                       Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Row(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               TextIO(
                                 "Total earned : ",
                                 fontWeight: FontWeight.w300,
                                 size: 16,
                                 color: AppColors.white,
                                 padding: 0,
                               ),
                               Obx( ()=>
                                  TextIO(
                                   _homeManager.pointsEarned.toString(),
                                   fontWeight: FontWeight.bold,
                                   size: 18,
                                   color: AppColors.whiteColor,
                                   padding: 0,
                                 ),
                               )
                             ],
                           ),
                           DividerIO(
                             height: 6,
                           ),
                           Row(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               TextIO(
                                 "Total redeemed : ",
                                 fontWeight: FontWeight.w300,
                                 size: 16,
                                 color: AppColors.white,
                                 padding: 0,
                               ),
                               Obx(()=>
                                  TextIO(
                                   _homeManager.pointsRedeemed.toString(),
                                   fontWeight: FontWeight.bold,
                                   size: 18,
                                   color: AppColors.whiteColor,
                                   padding: 0,
                                 ),
                               )
                             ],
                           ),
                         ],
                       ),
                       [23, 0, 12, 0],
                       width: widthIs / 2.16,
                       height: 72,
                       color: AppColors.homeGradientUpperLayerColor,
                     )
                   ],
                 ),
                 Spacer(),
                 Container(
                   color: AppColors.homeGradientUpperLayerColor,
                   margin: EdgeInsets.all(9),
                   padding: EdgeInsets.all(9),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       TextIO(
                         "Ways to redeem:",
                         color: AppColors.whiteColor,
                         size: 12,
                       ),
                       Row(
                         children: [
                           SvgPicture.asset('assets/images/mobile_icon.svg'),
                           TextIO(
                             "Recharge",
                             fontWeight: FontWeight.w300,
                             color: AppColors.whiteColor,
                             size: 12,
                           ),
                         ],
                       ),
                       Row(
                         children: [
                           SvgPicture.asset('assets/images/wallet_icon.svg'),
                           TextIO(
                             "Cashback",
                             fontWeight: FontWeight.w300,
                             color: AppColors.whiteColor,
                             size: 12,
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
                 DividerIO(),

                 // buttons
                 Spacer(),
                 Container(
                     width: MediaQuery.of(context).size.width * 0.9,
                     height: 48,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Spacer(),
                         Text(
                           'Redeem Points Now',
                           maxLines: 2,
                           style: TextStyle(
                               fontSize: Dimens.font_16sp,
                               fontWeight: FontWeight.w600,
                               color: AppColors.cardBg1),
                         ),
                         Spacer(),
                         SizedBox(
                           height: 42,
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
                 Spacer(),
               ],
             ),
           ),
         ),
       ]
      ),
    );
  }
}
