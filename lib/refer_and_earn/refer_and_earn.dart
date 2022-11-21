// import 'package:contacts_service/contacts_service.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:india_one/refer_and_earn/refer_and_earn_controller.dart';
// import 'package:india_one/widgets/common_banner.dart';

// import 'package:india_one/widgets/loyalty_common_header.dart';

// import '../constant/theme_manager.dart';

// class ReferAndEarn extends StatelessWidget {
//   ReferAndEarn({super.key});
//   final referAndEarnController = Get.put(ReferAndEarnController());

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             backgroundColor: AppColors.white,
//             body: CustomScrollView(slivers: <Widget>[
//               SliverAppBar(
//                 backgroundColor: AppColors.white,
//                 expandedHeight: Get.size.height * 0.63,
//                 automaticallyImplyLeading: false,
//                 flexibleSpace: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomAppBar(heading: 'Refer & earn'),
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: 15.0),
//                         child: CommonBanner(
//                           onPressedBanner: null,
//                           noRefernowCTA: true,
//                         ),
//                       ),
//                       _shareAndInvite(),
//                       _favoritesScreen(),
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 15.0),
//                         height: 1,
//                         color: Color(0xffd9d9d9),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Container(
//                     margin: EdgeInsets.only(
//                         left: 15.0, right: 15.0, bottom: 15.0, top: 15.0),
//                     height: 40,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Color(0xffd1d1d1))),
//                     child: Row(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.symmetric(
//                               vertical: 8.0, horizontal: 15.0),
//                           child: Center(
//                             child: ShaderMask(
//                                 shaderCallback: (bounds) {
//                                   return LinearGradient(
//                                       begin: Alignment(0.1, 0.5),
//                                       end: Alignment(1, 1),
//                                       colors: [
//                                         Color(0xff004280),
//                                         Color(0xff00C376)
//                                       ]).createShader(bounds);
//                                 },
//                                 child: SvgPicture.asset(
//                                   AppImages.searchIconSvg,
//                                   fit: BoxFit.fill,
//                                 )),
//                           ),
//                         ),
//                         Expanded(
//                           child: TextField(
//                             decoration: new InputDecoration.collapsed(
//                               hintText: 'Search by number or name',
//                               hintStyle: AppStyle.shortHeading.copyWith(
//                                   color: const Color(0xff2d2d2d),
//                                   letterSpacing: 0,
//                                   fontSize: Dimens.font_16sp,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )),
//               ),
//               SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   childCount: referAndEarnController.contacts.length,
//                   (_, int index) {
//                     return Column(
//                       children: [
//                         ListTile(
//                           leading: Container(
//                               width: 40,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(18),
//                                   gradient: LinearGradient(
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                       colors: [
//                                         Colors.redAccent,
//                                         Colors.blueAccent
//                                       ])),
//                               child: Center(
//                                 child: ShaderMask(
//                                     shaderCallback: (bounds) {
//                                       return LinearGradient(
//                                           begin: Alignment(0.1, 0.5),
//                                           end: Alignment(1, 1),
//                                           colors: [
//                                             Color(0xff004280),
//                                             Color(0xff00C376)
//                                           ]).createShader(bounds);
//                                     },
//                                     child: SvgPicture.asset(
//                                       AppImages.whatsappIconSvg,
//                                       fit: BoxFit.fill,
//                                     )),
//                               )),
//                           title: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(referAndEarnController.contacts[index].value,
//                                   textScaleFactor: 1),
//                               //Text('Place ${index + 1}', textScaleFactor: 1.5),
//                               Text('number ${index + 1}', textScaleFactor: 1),
//                             ],
//                           ),
//                           trailing: _inviteBtn(onClicked: false),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ])));
//   }

// // ------------------  share and invite screen ---------------------------------------------------
//   final List<String> socialList = [
//     'Whatsapp',
//     'Facebook',
//     'Instagram',
//     'Message'
//   ];
//   final List<String> socialListIcons = [
//     AppImages.whatsappIconSvg,
//     AppImages.facebookIconSvg,
//     AppImages.instagramIconSvg,
//     AppImages.messageIconSvg,
//   ];
//   Widget _shareAndInvite() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Share & invite',
//             style: AppStyle.shortHeading.copyWith(
//                 color: const Color(0xff2d2d2d),
//                 fontSize: Dimens.font_20sp,
//                 fontWeight: FontWeight.w600),
//           ),
//           Row(
//             children: List.generate(
//                 socialList.length,
//                 (index) => Container(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Column(
//                         children: [
//                           Container(
//                               width: 40,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   gradient: LinearGradient(
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                       colors: [
//                                         Color(0xffEBFFF0),
//                                         Color(0xffF8F9FB)
//                                       ])),
//                               child: Center(
//                                 child: ShaderMask(
//                                     shaderCallback: (bounds) {
//                                       return LinearGradient(
//                                           begin: Alignment(0.1, 0.5),
//                                           end: Alignment(1, 1),
//                                           colors: [
//                                             Color(0xff004280),
//                                             Color(0xff00C376)
//                                           ]).createShader(bounds);
//                                     },
//                                     child: SvgPicture.asset(
//                                       socialListIcons[index],
//                                       fit: BoxFit.fill,
//                                     )),
//                               )),
//                           SizedBox(height: 8),
//                           Text(
//                             socialList[index],
//                             style: AppStyle.shortHeading.copyWith(
//                                 color: const Color(0xff2d2d2d),
//                                 fontSize: Dimens.font_14sp,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ],
//                       ),
//                     )),
//           )
//         ],
//       ),
//     );
//   }

// //  -----------------------  favorites screen -----------------------------------------------
//   Widget _favoritesScreen() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Favorites',
//             style: AppStyle.shortHeading.copyWith(
//                 color: const Color(0xff2d2d2d),
//                 fontSize: Dimens.font_20sp,
//                 fontWeight: FontWeight.w600),
//           ),
//           Row(
//             children: List.generate(
//                 socialList.length,
//                 (index) => Container(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Column(
//                         children: [
//                           Container(
//                               width: 40,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(18),
//                                   gradient: LinearGradient(
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                       colors: [
//                                         Colors.redAccent,
//                                         Colors.blueAccent
//                                       ])),
//                               child: Center(
//                                 child: ShaderMask(
//                                     shaderCallback: (bounds) {
//                                       return LinearGradient(
//                                           begin: Alignment(0.1, 0.5),
//                                           end: Alignment(1, 1),
//                                           colors: [
//                                             Color(0xff004280),
//                                             Color(0xff00C376)
//                                           ]).createShader(bounds);
//                                     },
//                                     child: SvgPicture.asset(
//                                       socialListIcons[index],
//                                       fit: BoxFit.fill,
//                                     )),
//                               )),
//                           SizedBox(height: 8),
//                           Text(
//                             socialList[index],
//                             style: AppStyle.shortHeading.copyWith(
//                                 color: const Color(0xff2d2d2d),
//                                 fontSize: Dimens.font_14sp,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           SizedBox(height: 8),
//                           _inviteBtn(onClicked: true)
//                         ],
//                       ),
//                     )),
//           ),
//           // Divider(
//           //   color: Color(0xffd9d9d9),
//           //   thickness: 1,
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget _inviteBtn({required bool onClicked}) {
//     return Container(
//         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(6),
//             gradient: LinearGradient(
//                 begin: Alignment(0.1, 0.5),
//                 end: Alignment(1, 1),
//                 colors: [Color(0xff004280), Color(0xff357CBE)])),
//         child: Text('Invite',
//             style: AppStyle.shortHeading.copyWith(
//               fontSize: Dimens.font_14sp,
//             )));
//   }
// }
