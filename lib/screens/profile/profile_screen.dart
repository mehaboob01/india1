import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_one/screens/profile/controller/profile_controller.dart';
import 'package:india_one/screens/profile/model/profile_details_model.dart';

import '../../constant/theme_manager.dart';
import '../../widgets/loyalty_common_header.dart';
import 'stepper_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  ProfileController profileController = Get.put(ProfileController());
  ProfileDetailsModel profileDetailsModel = ProfileDetailsModel();

  RxBool isPersonalDetailsVisible = false.obs,
      isResidentialDetailsVisible = false.obs,
      isOccupationDetailsVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    getPersonalDetailButton();
    getResidentialDetailButton();
    getOccupationDetailButton();
    return Scaffold(
      body: Column(
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
                        child: CircularProgressIndicator(),
                      )
                    ] else ...[
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  height: 100,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          "${profileController.profileDetailsModel.value.mobileNumber ?? ''}",
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
                                      height: 140,
                                      width: 140,
                                      margin: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.orangeColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 110,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.lightOrangeColor
                                              .withOpacity(0.4),
                                          width: 10,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 45,
                                      width: 45,
                                      margin: EdgeInsets.only(
                                          left: 20, right: 25, bottom: 0),
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
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            details(title: 'Personal details'),
                            details(title: 'Residential address'),
                            details(title: 'Occupation Details'),
                            details(title: 'Bank account(s)'),
                            details(title: 'UPI ID(s) / VPA Number(s)'),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 48,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Spacer(),
                                      Text(
                                        'logout'.tr,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
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
                                            colors: [
                                              Colors.orange,
                                              Colors.redAccent
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white70
                                                  .withOpacity(0.8),
                                              offset: Offset(
                                                -6.0,
                                                -6.0,
                                              ),
                                              blurRadius: 16.0,
                                            ),
                                            BoxShadow(
                                              color: AppColors.darkerGrey
                                                  .withOpacity(0.4),
                                              offset: Offset(6.0, 6.0),
                                              blurRadius: 16.0,
                                            ),
                                          ],
                                          color: 1 == 1
                                              ? AppColors.btnColor
                                              : AppColors.btnDisableColor,
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        )
                                      : BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white70
                                                  .withOpacity(0.8),
                                              offset: Offset(
                                                -6.0,
                                                -6.0,
                                              ),
                                              blurRadius: 16.0,
                                            ),
                                            BoxShadow(
                                              color: AppColors.darkerGrey
                                                  .withOpacity(0.4),
                                              offset: Offset(6.0, 6.0),
                                              blurRadius: 16.0,
                                            ),
                                          ],
                                          color: 1 == 1
                                              ? AppColors.btnColor
                                              : AppColors.btnDisableColor,
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        )),
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
    );
  }

  Widget singleDetails({required String title, required String value}) {
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
        Text(
          value,
          style: TextStyle(
            color: AppColors.lightBlack,
            fontSize: Dimens.font_18sp,
          ),
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

  getOccupationDetailButton() {
    if (profileDetailsModel.employmentType == null &&
        profileDetailsModel.occupation == null &&
        profileDetailsModel.income == null &&
        profileDetailsModel.panNumber == null) {
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
            initiallyExpanded: true,
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: AppColors.lightBlack,
                      fontSize: Dimens.font_18sp,
                    ),
                  ),
                ),
                if ((title == 'Personal details' &&
                        (isPersonalDetailsVisible.value == true)) ||
                    (title == 'Residential address' &&
                        (isResidentialDetailsVisible.value == true)) ||
                    (title == 'Occupation Details' &&
                        (isOccupationDetailsVisible.value == true))) ...[
                  InkWell(
                    onTap: () {
                      nextStep(title);
                    },
                    child: Icon(Icons.note_alt_outlined),
                  ),
                ],
                //
              ],
            ),
            children: [
              Container(
                height: 2,
                color: AppColors.lightGreyColor,
                margin: EdgeInsets.symmetric(horizontal: 10),
              ),
              if (title == 'Personal details') ...[
                personalDetails(),
              ] else if (title == 'Residential address') ...[
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
                        value: profileDetailsModel.firstName ?? "No First name",
                      ),
                      singleDetails(
                        title: "Mobile number",
                        value: profileDetailsModel.mobileNumber ?? "",
                      ),
                      singleDetails(
                        title: "Email ID",
                        value: profileDetailsModel.email ?? "No email ID",
                      ),
                      singleDetails(
                        title: "Gender",
                        value: profileDetailsModel.gender ?? "Not entered",
                      ),
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
                      ),
                      singleDetails(
                        title: "Alternate number",
                        value: profileDetailsModel.mobileNumber ?? "No number",
                      ),
                      singleDetails(
                        title: "Date of birth",
                        value: profileDetailsModel.dateOfBirth ?? "No DOB",
                      ),
                      singleDetails(
                        title: "Marital status",
                        value:
                            profileDetailsModel.maritalStatus ?? "Not updated",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isPersonalDetailsVisible.value)
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
                      ),
                      singleDetails(
                        title: "Address line 2",
                        value: "${address.addressLine2 ?? 'No Address'}",
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: singleDetails(
                              title: "Pincode",
                              value: "${address.postCode ?? 'No Postcode'}",
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: singleDetails(
                              title: "City",
                              value: "${address.city ?? 'No City'}",
                            ),
                          ),
                        ],
                      ),
                      singleDetails(
                        title: "State",
                        value: "${address.state ?? 'No State'}",
                      ),
                    ]
                  : [
                      Text("Could not find any residential data!"),
                    ],
            ),
          ),
          if (isResidentialDetailsVisible.value == false)
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
              Text(
                "Account 1:",
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
                      value: "State Bank of India",
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: singleDetails(
                      title: "Account number",
                      value: "XXXXXXX6543",
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
                      value: "INGV0005943",
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: singleDetails(
                      title: "Account type",
                      value: "Savings account",
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        addDetailButton(
          title: 'Add Bank Account',
          callBack: () {
            nextStep('Bank account');
          },
        ),
      ],
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
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: singleDetails(
                              title: "Occupation",
                              value: profileDetailsModel.occupation ??
                                  "No Occupation",
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
                              title: "Monthly income",
                              value: "${profileDetailsModel.income ?? 0}",
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: singleDetails(
                              title: "PAN number",
                              value: profileDetailsModel.panNumber ?? "No Pan",
                            ),
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
              singleDetails(
                title: "UPI ID 1",
                value: "anilsaha@okicici",
              ),
            ],
          ),
        ),
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
