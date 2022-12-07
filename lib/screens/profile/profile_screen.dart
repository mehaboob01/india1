import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:india_one/core/data/remote/api_constant.dart';
import 'package:india_one/screens/profile/add_bank_account_screen.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';
import 'package:india_one/screens/profile/model/bank_details_model.dart';
import 'package:india_one/screens/profile/model/profile_details_model.dart';
import 'package:india_one/widgets/circular_progressbar.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/loyalty_common_header.dart';
import '../bank_manage_edit_screen.dart/manage_accounts_screen.dart';
import '../loyality_points/cashback_redeem/cb_manager.dart';
import 'common/profile_stepper.dart';
import 'stepper_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  ProfileController profileController = Get.put(ProfileController());
  CashBackManager cashBackManager = Get.put(CashBackManager());
  ProfileDetailsModel profileDetailsModel = ProfileDetailsModel();

  RxBool isPersonalDetailsVisible = false.obs, isResidentialDetailsVisible = false.obs, isOccupationDetailsVisible = false.obs, isBankAccountVisible = false.obs, isUpiIdVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    getPersonalDetailButton();
    getResidentialDetailButton();
    getOccupationDetailButton();
    getUpiIdButton();
    getBankAccountDetailsButton();
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        body: profileController.uploadProfileLoading == true
            ? CircularProgressbar()
            : Column(
                children: [
                  SafeArea(
                    child: CustomAppBar(
                      heading: 'Profile',
                    ),
                  ),
                  Expanded(
                    child: Obx(() => Stack(
                          children: [
                            if (profileController.getProfileLoading.value == true) ...[
                              Center(
                                child: LoadingAnimationWidget.inkDrop(
                                  size: 34,
                                  color: AppColors.primary,
                                ),
                              )
                            ] else ...[
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        Container(
                                          height: 95,
                                          padding: EdgeInsets.only(
                                            left: 100,
                                          ),
                                          margin: EdgeInsets.only(
                                            left: 80,
                                            right: 20,
                                            top: 20,
                                            bottom: 20,
                                          ),
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: <Color>[
                                                AppColors.cardBg1,
                                                AppColors.cardBg2,
                                              ],
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Mobile number",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: Dimens.font_14sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Obx(
                                                () => Text(
                                                  "+91 ${profileController.profileDetailsModel.value.mobileNumber ?? ''}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Dimens.font_18sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            Container(
                                              height: 130,
                                              width: 130,
                                              margin: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                              ),
                                              child: Obx(
                                                () => InkWell(
                                                  onTap: () {
                                                    profileController.pickImage(context);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.orangeColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: profileController.uploadProfileLoading.value == true
                                                        ? LoadingAnimationWidget.inkDrop(
                                                            size: 34,
                                                            color: AppColors.primary,
                                                          )
                                                        : ClipOval(
                                                            child: CachedNetworkImage(
                                                              fit: BoxFit.fill,
                                                              imageUrl: '${Apis.profileImageUrl}${profileController.profileDetailsModel.value.imageName}',
                                                              errorWidget: (context, _, error) {
                                                                return Icon(
                                                                  Icons.person,
                                                                  color: Colors.white,
                                                                  size: 100,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: AppColors.lightOrangeColor.withOpacity(0.4),
                                                  width: 10,
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                profileController.pickImage(context);
                                              },
                                              child: Container(
                                                height: 45,
                                                width: 45,
                                                margin: EdgeInsets.only(left: 20, right: 25, bottom: 0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: AppColors.lightOrangeColor,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 28,
                                                  color: AppColors.lightOrangeColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    details(title: 'Personal Details'),
                                    details(title: 'Residential Address'),
                                    details(title: 'Occupation Details'),
                                    details(title: 'Bank account(s)'),
                                    details(title: 'UPI ID(s) / VPA Number(s)'),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Obx(
                                      () => profileController.logoutLoading.value == true
                                          ? Center(
                                              child: LoadingAnimationWidget.inkDrop(
                                                size: 34,
                                                color: AppColors.primary,
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                profileController.logout();
                                              },
                                              child: Container(
                                                  width: MediaQuery.of(context).size.width * 0.9,
                                                  height: 48,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Spacer(),
                                                      Text(
                                                'Logout'.tr,
                                                        maxLines: 2,
                                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      Spacer(),
                                                      SizedBox(
                                                        height: 48,
                                                        child: Image.asset(
                                                          "assets/images/btn_img.png",
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  decoration: 1 == 1
                                                      ? BoxDecoration(
                                                          gradient: new LinearGradient(
                                                            end: Alignment.topRight,
                                                            colors: [Colors.orange, Colors.redAccent],
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.white70.withOpacity(0.8),
                                                              offset: Offset(
                                                                -6.0,
                                                                -6.0,
                                                              ),
                                                              blurRadius: 16.0,
                                                            ),
                                                            BoxShadow(
                                                              color: AppColors.darkerGrey.withOpacity(0.4),
                                                              offset: Offset(6.0, 6.0),
                                                              blurRadius: 16.0,
                                                            ),
                                                          ],
                                                          color: 1 == 1 ? AppColors.btnColor : AppColors.btnDisableColor,
                                                          borderRadius: BorderRadius.circular(6.0),
                                                        )
                                                      : BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.white70.withOpacity(0.8),
                                                              offset: Offset(
                                                                -6.0,
                                                                -6.0,
                                                              ),
                                                              blurRadius: 16.0,
                                                            ),
                                                            BoxShadow(
                                                              color: AppColors.darkerGrey.withOpacity(0.4),
                                                              offset: Offset(6.0, 6.0),
                                                              blurRadius: 16.0,
                                                            ),
                                                          ],
                                                          color: 1 == 1 ? AppColors.btnColor : AppColors.btnDisableColor,
                                                          borderRadius: BorderRadius.circular(6.0),
                                                        )),
                                            ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ]
                          ],
                        )),
                  ),
                ],
              ),
      ),
    );
  }

  Widget singleDetails(
      {required String title, required String value, bool? isEmpty}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.lightBlack,
            fontSize: Dimens.font_12sp,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        if (isEmpty != null)
          Text(
            value,
            style: isEmpty
                ? TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF999999),
                    fontSize: 16)
                : TextStyle(
                    color: AppColors.lightBlack,
                    fontSize: Dimens.font_18sp,
                    fontWeight: FontWeight.w600),
          )
        else
          Text(
            value,
            style: TextStyle(
                color: AppColors.lightBlack,
                fontSize: Dimens.font_18sp,
                fontWeight: FontWeight.w600),
          ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  getPersonalDetailButton() {
    if (profileController.profileDetailsModel.value.firstName == null &&
        profileController.profileDetailsModel.value.lastName == null &&
        profileController.profileDetailsModel.value.mobileNumber == null &&
        profileController.profileDetailsModel.value.alternateNumber == null &&
        profileController.profileDetailsModel.value.email == null &&
        profileController.profileDetailsModel.value.dateOfBirth == null &&
        profileController.profileDetailsModel.value.gender == null &&
        profileController.profileDetailsModel.value.maritalStatus == null) {
      isPersonalDetailsVisible.value = false;
    }
    isPersonalDetailsVisible.value = true;
  }

  getResidentialDetailButton() {
    if (profileDetailsModel.address?.addressLine1 == null &&
        profileDetailsModel.address?.addressLine2 == null &&
        profileDetailsModel.address?.postCode == null &&
        profileDetailsModel.address?.city == null &&
        profileDetailsModel.address?.state == null) {
      isResidentialDetailsVisible.value = false;
    }
    isResidentialDetailsVisible.value = true;
  }

  getBankAccountDetailsButton() {
    if (profileController.bankDetailsModel.value.preferredAccount == null || profileController.bankDetailsModel.value.accounts == []) {
      isBankAccountVisible.value = false;
    }
    isBankAccountVisible.value = true;
  }

  getUpiIdButton() {
    if (profileController.upiIdModel.value.upiIds == []) {
      isUpiIdVisible.value = false;
    }
    isUpiIdVisible.value = true;
  }

  getOccupationDetailButton() {
    if (profileDetailsModel.employmentType == null && profileDetailsModel.occupation == null && profileDetailsModel.income == null && profileDetailsModel.panNumber == null) {
      isOccupationDetailsVisible.value = false;
    }
    isOccupationDetailsVisible.value = true;
  }

  nextStep(title) {
    int stepNumber = 1;
    switch (title) {
      case 'Personal details':
        stepNumber = 1;
        break;

      case 'Residential address':
        stepNumber = 2;
        break;

      case 'Occupation Details':
        stepNumber = 3;
        break;
    }
    profileController.currentStep.value = stepNumber;
    Get.to(() => StepperScreen(
          stepNumber: stepNumber,
        ));
  }

  Widget details({required String title}) {
    LinearGradient linearGradient = LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
          Color(0xFFF2642C),
          Color(0xFFFFE943),
        ]);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Theme(
          data: ThemeData(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            iconColor: Colors.grey,
            collapsedIconColor: Colors.grey,
            initiallyExpanded: false,
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: AppColors.lightBlack,
                        fontSize: Dimens.font_18sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                if ((title == 'Personal Details' &&
                        (isPersonalDetailsVisible.value == true)) ||
                    (title == 'Residential Address' &&
                        (isResidentialDetailsVisible.value == true)) ||
                    (title == 'Occupation Details' &&
                        (isOccupationDetailsVisible.value == true)) ||
                    (title == 'Bank account(s)' &&
                        (isBankAccountVisible.value == true)) ||
                    (title == 'UPI ID(s) / VPA Number(s)' &&
                        (isUpiIdVisible.value == true))) ...[
                  InkWell(
                    onTap: () {
                      if (title == 'Bank account(s)') {
                        Get.to(() => ManageAccountsCard());
                      } else if (title == 'UPI ID(s) / VPA Number(s)') {
                        Get.to(() => ManageAccountsCard());
                      } else {
                        nextStep(title);
                      }
                    },
                    child: ShaderMask(
                        child: SvgPicture.asset("assets/svg/edit_icon.svg"),
                        shaderCallback: (bounds) {
                          return linearGradient.createShader(bounds);
                        }),
                  ),
                ],
                //
              ],
            ),
            children: [
              ProfileStepper().divider(),
              if (title == 'Personal Details') ...[
                personalDetails(),
              ] else if (title == 'Residential Address') ...[
                residentialAddress(),
              ] else if (title == 'Occupation Details') ...[
                occupationDetails(),
              ] else if (title == 'Bank account(s)') ...[
                bankAccount(),
              ] else if (title == 'UPI ID(s) / VPA Number(s)') ...[
                upiId(),
              ],
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget personalDetails() {
    return Obx(() {
      profileDetailsModel = profileController.profileDetailsModel.value;

      return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      singleDetails(
                          title: "First name",
                          value:
                              profileDetailsModel.firstName ?? "No First name",
                          isEmpty: profileDetailsModel.firstName == null
                              ? true
                              : false),
                      singleDetails(
                        title: "Mobile number",
                        value: "+91 ${profileDetailsModel.mobileNumber ?? ""}",
                        isEmpty: profileDetailsModel.mobileNumber!.isEmpty
                            ? true
                            : false,
                      ),
                      singleDetails(
                          title: "Email ID",
                          value: profileDetailsModel.email ?? "No email ID",
                          isEmpty:
                              profileDetailsModel.email == null ? true : false),
                      singleDetails(
                          title: "Gender",
                          value: profileDetailsModel.gender ?? "Not entered",
                          isEmpty: profileDetailsModel.gender == null
                              ? true
                              : false),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      singleDetails(
                          title: "Last name",
                          value: profileDetailsModel.lastName ?? "No last name",
                          isEmpty: profileDetailsModel.lastName == null
                              ? true
                              : false),
                      singleDetails(
                          title: "Alternate number",
                          value: profileDetailsModel.alternateNumber != null
                              ? "+91 ${profileDetailsModel.alternateNumber ?? "No Number"}"
                              : "No Number",
                          isEmpty: profileDetailsModel.alternateNumber == null
                              ? true
                              : false),
                      singleDetails(
                        isEmpty: profileDetailsModel.dateOfBirth == null
                            ? true
                            : false,
                          title: "Date of birth",
                        value: profileDetailsModel.dateOfBirth == null || profileDetailsModel.dateOfBirth == ''
                            ? "No DOB"
                            : DateFormat('dd-MM-yyyy').format(DateFormat("yyyy-MM-dd").parse(profileDetailsModel.dateOfBirth!)),
                      ),
                      singleDetails(
                          isEmpty: profileDetailsModel.maritalStatus == null
                              ? true
                              : false,

                          title: "Marital status",
                        value: profileDetailsModel.maritalStatus ?? "Not updated",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

            addDetailButton(
              title: 'Add Personal Details',
              callBack: () {
                nextStep('Personal details');
              },
            ),
        ],
      );
    });
  }

  Widget residentialAddress() {
    return Obx(() {
      profileDetailsModel = profileController.profileDetailsModel.value;
      Address address = profileDetailsModel.address ?? Address();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: isResidentialDetailsVisible.value == true
                  ? [
                      singleDetails(
                          title: "Address line 1",
                          value: "${address.addressLine1 ?? 'No Address'}",
                          isEmpty: address.addressLine1 == null ? true : false),
                      singleDetails(
                          title: "Address line 2",
                          value: "${address.addressLine2 ?? 'No Address'}",
                          isEmpty: address.addressLine2 == null ? true : false),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: singleDetails(
                                title: "Pincode",
                                value: "${address.postCode ?? 'No Postcode'}",
                                isEmpty:
                                    address.postCode == null ? true : false),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: singleDetails(
                                title: "City",
                                value: "${address.city ?? 'No City'}",
                                isEmpty: address.city == null ? true : false),
                          ),
                        ],
                      ),
                      singleDetails(
                          title: "State",
                          value: "${address.state ?? 'No State'}",
                          isEmpty: address.state == null ? true : false),
                    ]
                  : [
                      Text("Could not find any residential data!"),
                    ],
            ),
          ),
          // if (isResidentialDetailsVisible.value == false)
            addDetailButton(
              title: 'Add Residential Details',
              callBack: () {
                nextStep('Residential address');
              },
            ),
        ],
      );
    });
  }

  Widget bankAccount() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (profileController.getBankAccountLoading.value != false) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: LoadingAnimationWidget.inkDrop(
                size: 34,
                color: AppColors.primary,
              ),
            ),
          ] else ...[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: isBankAccountVisible.value == true
                    ? [
                        accountDetails(profileController.bankDetailsModel.value.preferredAccount ?? PreferredAccount(), null),
                        if (profileController.bankDetailsModel.value.accounts != null && profileController.bankDetailsModel.value.accounts != []) ...[
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(0),
                            itemCount: profileController.bankDetailsModel.value.accounts!.length,
                            itemBuilder: (context, index) => accountDetails(profileController.bankDetailsModel.value.accounts![index], index),
                          ),
                        ],
                      ]
                    : [
                        Text("Could not find any bank account data!"),
                      ],
              ),
            ),
            // if (isBankAccountVisible.value == false)
              addDetailButton(
                title: 'Add Bank Account',
                callBack: () {
                  Get.to(() => AddBankAccountScreen());
                },
              ),
          ]
        ],
      ),
    );
  }

  Widget occupationDetails() {
    return Obx(() {
      profileDetailsModel = profileController.profileDetailsModel.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: isResidentialDetailsVisible.value == true
                  ? [
                      Row(
                        children: [
                          Expanded(
                            child: singleDetails(
                                title: "Employment type",
                                value: profileDetailsModel.employmentType ??
                                    "No Type",
                                isEmpty:
                                    profileDetailsModel.employmentType == null
                                        ? true
                                        : false),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: singleDetails(
                                title: "Occupation",
                                value: profileDetailsModel.occupation ??
                                    "No Occupation",
                                isEmpty: profileDetailsModel.occupation == null
                                    ? true
                                    : false),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: singleDetails(
                                title: "Monthly income",
                                value: "${profileDetailsModel.income ?? ""}",
                                isEmpty: profileDetailsModel.income == null
                                    ? true
                                    : false),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: singleDetails(
                                title: "PAN number",
                                value:
                                    profileDetailsModel.panNumber ?? "No Pan",
                                isEmpty: profileDetailsModel.panNumber == null
                                    ? true
                                    : false),
                          ),
                        ],
                      )
                    ]
                  : [
                      Text("Could not find any of your occupation details!"),
                    ],
            ),
          ),
          if (isOccupationDetailsVisible.value == false)
            addDetailButton(
              title: 'Add Occupation Details',
              callBack: () {
                nextStep('Occupation Details');
              },
            ),
        ],
      );
    });
  }

  Widget accountDetails(PreferredAccount account, int? index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${index == null ? 'Primary Account:' : cashBackManager.customerBankList[0].name}",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.lightBlack,
            fontSize: Dimens.font_16sp,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: singleDetails(
                  title: "Bank name",
                  value:
                      "${cashBackManager.customerBankList.isEmpty ? "" : cashBackManager.customerBankList[0].name ?? ''}",
                  isEmpty: account.name == null ? true : false),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: singleDetails(
                title: "Account number",
                isEmpty: account.maskAccountNumber == null ? true : false,
                value:
                    "${cashBackManager.customerBankList.isEmpty ? "" : cashBackManager.customerBankList[0].maskAccountNumber ?? ''}",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: singleDetails(
                  title: "IFSC code",
                  value:
                      "${cashBackManager.customerBankList.isEmpty ? "" : cashBackManager.customerBankList[0].ifscCode ?? ''}",
                  isEmpty: account.ifscCode == null ? true : false),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: singleDetails(
                  title: "Account type",
                  value:
                      "${cashBackManager.customerBankList.isEmpty ? "" : cashBackManager.customerBankList[0].accountType ?? ''}",
                  isEmpty: account.accountType == null ? true : false),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        ProfileStepper().divider(),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }

  Widget upiId() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (profileController.upiIdModel.value.upiIds != null && profileController.upiIdModel.value.upiIds != []) ...[
                ListView.builder(
                  itemCount: profileController.upiIdModel.value.upiIds!.length,
                  itemBuilder: (context, index) {
                    return singleDetails(
                        title: "UPI ID $index",
                        value:
                            "${profileController.upiIdModel.value.upiIds![index]}",
                        isEmpty:
                            profileController.upiIdModel.value.upiIds == null
                                ? true
                                : false);
                  },
                ),
              ] else ...[
                Text(cashBackManager.customerUPIList.isEmpty ? "Could not find any upi id data!" : cashBackManager.customerUPIList[0].upiId.toString()),
              ]
            ],
          ),
        ),
        if (isUpiIdVisible.value == false)
          addDetailButton(
            title: 'Add UPI / VPA Details',
            callBack: () {},
          ),
      ],
    );
  }

  Widget addDetailButton({required String title, required Function callBack}) {
    return InkWell(
      onTap: () => callBack(),
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          border: Border.all(
            color: AppColors.butngradient1,
            width: 1,
          ),
        ),
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.butngradient1,
            fontWeight: FontWeight.w500,
            fontSize: Dimens.font_16sp,
          ),
        ),
      ),
    );
  }
}
