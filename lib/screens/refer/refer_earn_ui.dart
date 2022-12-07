import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';
import 'package:india_one/screens/refer/contacts_manager.dart';
import 'package:india_one/widgets/circular_progressbar.dart';
import 'package:india_one/widgets/common_textfield.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/loyalty_common_header.dart';
import 'refer_manager.dart';

ContactCont contactCont = Get.put(ContactCont());

class ReferEarn extends StatefulWidget {
  const ReferEarn({key});

  @override
  State<ReferEarn> createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  ReferManager _referManager = Get.put(ReferManager());
  ContactCont _contactCont = Get.put(ContactCont());

  List<String> invitedList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var snackBar = SnackBar(
    content: Text('Already invited!'),
  );

  @override
  Widget build(BuildContext context) {
    if (contactCont.contacts == null)
      return Center(child: CircularProgressIndicator());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => _referManager.isLoading == true
            ? CircularProgressbar()
            : SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomAppBar(heading: "Refer & Earn"),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: 25.0.wp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0.wp),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.referEarnGradient1,
                                  AppColors.referEarnGradient2
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 6.0.wp,
                                        bottom: 6.0.wp,
                                        left: 4.0.wp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                                style: AppStyle.shortHeading
                                                    .copyWith(
                                                        color:
                                                            Color(0xFFEBEBEB),
                                                        //fontWeight: FontWeight.w600,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.5),
                                                text:
                                                    'Refer a friend or a family member & get\na chance to',
                                                children: [
                                              TextSpan(
                                                  text: ' Earn upto 100 points',
                                                  style: AppStyle.shortHeading
                                                      .copyWith(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                            ])),
                                        // SizedBox(height: 1.0.wp),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        color:
                                            Color(0xFFD9D9D9).withOpacity(0.1),
                                      ),
                                      padding: EdgeInsets.only(
                                          top: 2.0.wp,
                                          bottom: 2.0.wp,
                                          left: 2.0.wp,
                                          right: 2.0.wp),
                                      child: Center(
                                          child: Image.asset(
                                        AppImages.referEarnSVG,
                                        fit: BoxFit.fill,
                                      )),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          Container(
                            height: Get.height * 0.07,
                            width: double.maxFinite,
                            child: TextFormField(
                              onChanged: (value) {
                                if (value != "" || value != " ") {
                                  contactCont.filterList(value);
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: "Search by name",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  prefixIcon: Icon(Icons.search)),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Obx(
                            () => _contactCont.isLoading.value == true
                                ? CircularProgressbar()
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        contactCont.filteredList.value.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 2, right: 2, bottom: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 25,
                                              backgroundColor:
                                                  AppColors.primary,
                                              child: Container(
                                                height: double.maxFinite,
                                                width: double.maxFinite,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFF004280),
                                                        Color(0xFF7EA2C4)
                                                      ],
                                                    )),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      contactCont
                                                              .filteredList
                                                              .value[index]
                                                              .name
                                                              .first
                                                              .isEmpty
                                                          ? ""
                                                          : "${contactCont.filteredList.value[index].name.first.substring(0, 1)}",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      contactCont
                                                              .filteredList
                                                              .value[index]
                                                              .name
                                                              .last
                                                              .isEmpty
                                                          ? ""
                                                          : "${contactCont.filteredList.value[index].name.last.substring(0, 1)}",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.02,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(contactCont.filteredList
                                                      .value[index].displayName
                                                      .toString()),
                                                  Text(
                                                      ' ${contactCont.filteredList.value[index].phones.isNotEmpty ? contactCont.filteredList.value[index].phones.first.number : 'No Number'}')
                                                ],
                                              ),
                                            ),
                                            inviteButton(index)
                                          ],
                                        ),
                                      );
                                    }),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
      ),
    );
  }

  inviteButton(int index) {
    return GestureDetector(
      onTap: () {
        if (invitedList.contains(contactCont
            .filteredList.value[index].phones.first.number
            .toString())) {
          print("already invited");
          const snackBar = SnackBar(
            content: Text('Already invited!'),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          setState(() {
            _referManager.callReferApi(contactCont
                .filteredList.value[index].phones.first.number
                .toString()
                .replaceAll(' ', '')
                .replaceAll('-', '')
                .replaceAll('(', '')
                .replaceAll(')', ''));

            invitedList.add(contactCont
                .filteredList.value[index].phones.first.number
                .toString());

            print("selected list${invitedList.toString()}");
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: 4, right: 4),
        child: Container(
          height: Get.height * 0.04,
          width: Get.width * 0.2,
          decoration: BoxDecoration(
              border: invitedList.contains(
                      contactCont.filteredList.value[index].phones.isNotEmpty
                          ? contactCont
                              .filteredList.value[index].phones.first.number
                              .toString()
                          : null)
                  ? Border.all(width: 1, color: AppColors.primary)
                  : null,
              borderRadius: BorderRadius.circular(5),
              gradient: invitedList.contains(
                      contactCont.filteredList.value[index].phones.isNotEmpty
                          ? contactCont
                              .filteredList.value[index].phones.first.number
                              .toString()
                          : null)
                  ? LinearGradient(
                      colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                    )
                  : LinearGradient(
                      colors: [Color(0xFF004280), Color(0xFF357CBE)],
                    )),
          child: Center(
              child: Text(
            invitedList.contains(contactCont
                        .filteredList.value[index].phones.isNotEmpty
                    ? contactCont.filteredList.value[index].phones.first.number
                        .toString()
                    : null)
                ? "Invited"
                : "Invite",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: invitedList.contains(
                        contactCont.filteredList.value[index].phones.isNotEmpty
                            ? contactCont
                                .filteredList.value[index].phones.first.number
                                .toString()
                            : null)
                    ? AppColors.primary
                    : AppColors.white),
          )),
        ),
      ),
    );
  }

  LinearGradient linearGradient = LinearGradient(
      colors: [Color(0xFF004280), Color(0xFF357CBE)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  Widget shareInvite(name, logoPath, onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: Get.height * 0.06,
            width: Get.width * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF8F9FB).withOpacity(1),
                  Color.fromARGB(255, 239, 237, 237).withOpacity(1)
                ],
              ),
            ),
            child: ShaderMask(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(logoPath),
                ),
                shaderCallback: (bounds) {
                  return linearGradient.createShader(bounds);
                }),
          ),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF2D2D2D)),
        )
      ],
    );
  }
}
