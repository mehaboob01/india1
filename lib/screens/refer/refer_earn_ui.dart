import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/screens/refer/contacts_manager.dart';
import 'package:india_one/widgets/circular_progressbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/theme_manager.dart';
import '../../core/data/local/shared_preference_keys.dart';
import '../../widgets/loyalty_common_header.dart';
import 'refer_manager.dart';

ContactCont contactCont = Get.put(ContactCont());

class ReferEarn extends StatefulWidget {
  ReferEarn({key});

  @override
  State<ReferEarn> createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  ReferManager _referManager = Get.put(ReferManager());
  ContactCont _contactCont = Get.put(ContactCont());
  TextEditingController _controller = TextEditingController();

  List<String> invitedList = [];

  @override
  void initState() {


    super.initState();
    if (_contactCont.isPermissionAllowed.isTrue) {
      _contactCont.fetchContacts();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  var snackBar = SnackBar(
    content: Text('Already invited!'),
  );
  var _scrollController = ScrollController();
  TextEditingController _editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => _referManager.isLoading == true
            ? CircularProgressbar()
            : SafeArea(
                child: SingleChildScrollView(
                    controller: _scrollController,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  color: Color(0xFFEBEBEB),
                                                  //fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.5,
                                                ),
                                                text:
                                                    'Refer a friend or a family member & get\na chance to',
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        ' Earn upto 100 points',
                                                    style: AppStyle.shortHeading
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // SizedBox(height: 1.0.wp),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(60),
                                            color: Color(0xFFD9D9D9)
                                                .withOpacity(0.1),
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
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,

                                        controller: _editingController,
                                        decoration: InputDecoration(
                                          hintText: "Enter a number to refer",
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await _referManager.callReferApi(
                                            _editingController.text);
                                      },
                                      child: Container(
                                        height: Get.height * 0.06,
                                        width: Get.width * 0.2,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: AppColors.primary),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFF004280),
                                                Color(0xFF357CBE)
                                              ],
                                            )),
                                        child: Center(
                                            child: Text(
                                          "Invite",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              contactCont.isPermissionAllowed.value
                                  ? permissionAllowed()
                                  : permissionNotAllowed(),
                              // contactCont.isListLoading.value
                              //     ? CircularProgressbar()
                              //     : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
      ),
    );
  }

  permissionNotAllowed() {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          height: Get.height * 0.15,
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
          child: GestureDetector(
            onTap: () async {
              await _handleLocationPermission();
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "You have not allowed the permission to access contacts, please allow the permissions to see the contacts on your phone.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "Allow Permissions Now",
                        style:
                            TextStyle(color: Colors.amberAccent, fontSize: 18),
                      ),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      ImageIcon(
                        AssetImage(
                          AppImages.rightArrow,
                        ),
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Future _handleLocationPermission() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? firstInit =
        sharedPreferences.getBool(SPKeys.FIRST_INIT_CONTACT_PERMISSION);
    var status = Permission.contacts.request();
    if (await status.isGranted || await status.isLimited) {
      _contactCont.isPermissionAllowed.value = true;
      await contactCont.fetchContacts();
      return;
    } else if (await status.isDenied) {
      Permission.contacts.request();
      if (firstInit != null) {
        sharedPreferences.setBool(SPKeys.FIRST_INIT_CONTACT_PERMISSION, true);
      }
    } else if (await status.isPermanentlyDenied) {
      if (firstInit == null || firstInit) {
        sharedPreferences.setBool(SPKeys.FIRST_INIT_CONTACT_PERMISSION, false);
        return false;
      } else {
        Geolocator.openAppSettings();
        Get.toNamed(MRouter.homeScreen);
      }
    }
  }

  permissionAllowed() {
    return Column(
      children: [
        Container(
          height: Get.height * 0.07,
          width: double.maxFinite,
          child: TextFormField(
            controller: _controller,
            onChanged: (value) {
              if (value != "" || value != " ") {
                contactCont.filterList(value);
              }
            },
            decoration: InputDecoration(
                hintText: "Search by name",
                hintStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: Icon(Icons.search)),
          ),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Obx(
          () => _contactCont.isLoading.value == true
              ? CircularProgressbar()
              : ListView.builder(
                  // itemExtent: 60,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _contactCont.contactsLenght.value,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColors.primary,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    contactCont.filteredList.value[index].name
                                            .first.isEmpty
                                        ? ""
                                        : "${contactCont.filteredList.value[index].name.first.substring(0, 1)}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    contactCont.filteredList.value[index].name
                                            .last.isEmpty
                                        ? ""
                                        : "${contactCont.filteredList.value[index].name.last.substring(0, 1)}",
                                    style: TextStyle(color: Colors.white),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(contactCont
                                    .filteredList.value[index].displayName
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
    );
  }

  inviteButton(int index) {
    return GestureDetector(
      onTap: () {


        if (invitedList.contains(contactCont
            .filteredList.value[index].phones.first.number
            .toString())) {

          const snackBar = SnackBar(
            content: Text('Already invited!'),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);

         // _controller.clear();

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
          // contactCont.contactsLenght.value =
          //     contactCont.contacts.length;
        //  _controller.clear();
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
                    : null )
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
    colors: [
      Color(0xFF004280),
      Color(0xFF357CBE),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
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
