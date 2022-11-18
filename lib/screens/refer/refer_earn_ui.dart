import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/extensions.dart';
import 'package:india_one/screens/refer/contacts_manager.dart';
import 'package:india_one/widgets/common_textfield.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/loyalty_common_header.dart';

ContactCont contactCont = Get.put(ContactCont());

class ReferEarn extends StatefulWidget {
  const ReferEarn({key});

  @override
  State<ReferEarn> createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  @override
  void initState() {
    super.initState();
    contactCont.fetchFavs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (contactCont.permissionDenied.value)
      return Center(child: Text('Permission denied'));
    if (contactCont.contacts == null)
      return Center(child: CircularProgressIndicator());
    return Scaffold(
      body: SafeArea(
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
                                top: 6.0.wp, bottom: 6.0.wp, left: 4.0.wp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: AppStyle.shortHeading.copyWith(
                                            color: Color(0xFFEBEBEB),
                                            //fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5),
                                        text:
                                            'Refer a friend or a family member & get\na chance to',
                                        children: [
                                      TextSpan(
                                          text: ' Earn upto 100 points',
                                          style: AppStyle.shortHeading.copyWith(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
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
                                color: Color(0xFFD9D9D9).withOpacity(0.1),
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
                  Text(
                    "Share & invite",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      shareInvite("Whatsapp", "assets/svg/refer/whatsApp.svg",
                          () {
                        print("whatsapp");
                      }),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      shareInvite(
                          "Facebook", "assets/svg/refer/facebook.svg", () {}),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      shareInvite(
                          "Instagram", "assets/svg/refer/instagram.svg", () {}),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      shareInvite(
                          "Message", "assets/svg/refer/message.svg", () {}),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Text(
                    "Favorites",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                      height: Get.height * 0.15,
                      child: Obx(
                        () => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: contactCont.favIsEmpty.value
                                    ? null
                                    : favContact(
                                        index,
                                        contactCont
                                            .favList.value[index].displayName,
                                        contactCont
                                            .favList.value[index].thumbnail));
                          },
                          itemCount: contactCont.favList.value.length,
                        ),
                      )),
                  Divider(
                    thickness: 2,
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
                            fontWeight: FontWeight.w500, fontSize: 14),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        prefixIcon: ShaderMask(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(AppImages.searchSvg),
                              ),
                            ),
                            shaderCallback: (bounds) {
                              return linearGradient.createShader(bounds);
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Obx(
                    () => ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: contactCont.filteredList.value.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.amber,
                                  child: Container(
                                    height: double.maxFinite,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient:
                                            contactCont.randomColorGradients()),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          contactCont.filteredList.value[index]
                                                  .name.first.isEmpty
                                              ? ""
                                              : "${contactCont.filteredList.value[index].name.first.substring(0, 1)}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          contactCont.filteredList.value[index]
                                                  .name.last.isEmpty
                                              ? ""
                                              : "${contactCont.filteredList.value[index].name.last.substring(0, 1)}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.02,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(contactCont
                                        .filteredList.value[index].displayName
                                        .toString()),
                                    Text(
                                        ' ${contactCont.filteredList.value[index].phones.isNotEmpty ? contactCont.filteredList.value[index].phones.first.number : 'No Number'}')
                                  ],
                                ),
                                Spacer(),
                                inviteButton()
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
    );
  }

  Widget favContact(index, name, thumbnail) {
    return Container(
      width: Get.width * 0.2,
      height: Get.height * 0.06,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 25,
            child: thumbnail != null
                ? Image.asset(thumbnail)
                : Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: contactCont.randomColorGradients()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          contactCont.favList.value[index].name.first.isEmpty
                              ? ""
                              : "${contactCont.favList.value[index].name.first.substring(0, 1)}",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          contactCont.favList.value[index].name.last.isEmpty
                              ? ""
                              : "${contactCont.filteredList.value[index].name.last.substring(0, 1)}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
          ),
          Text(name,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF2D2D2D),
              )),
          inviteButton(),
        ],
      ),
    );
  }

  inviteButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: Container(
        height: Get.height * 0.04,
        width: Get.width * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            colors: [Color(0xFF004280), Color(0xFF357CBE)],
          ),
        ),
        child: Center(
            child: Text(
          "Invite",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        )),
      ),
    );
  }

  LinearGradient linearGradient = LinearGradient(
      colors: [Color(0xFF004280), Color(0xFF00C376)],
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
