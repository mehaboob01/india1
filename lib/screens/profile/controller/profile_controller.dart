import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:india_one/constant/routes.dart';

import 'package:india_one/constant/theme_manager.dart';

import 'package:india_one/core/data/remote/api_constant.dart';
import 'package:india_one/core/data/remote/dio_api_call.dart';
import 'package:india_one/screens/loans/bike_loan/models_model.dart';
import 'package:india_one/screens/onboarding_login/user_login/user_login_ui.dart';
import 'package:india_one/screens/onboarding_login/splash/splash_ui.dart';
import 'package:india_one/screens/profile/model/bank_details_model.dart';
import 'package:india_one/screens/profile/model/profile_details_model.dart';
import 'package:india_one/screens/profile/model/upload_signed_model.dart';
import 'package:india_one/utils/common_methods.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../core/data/local/shared_preference_keys.dart';
import '../../../core/data/model/common_model.dart';
import '../../../utils/comman_validaters.dart';
import '../../home_start/home_manager.dart';
import '../../loyality_points/cashback_redeem/cb_manager.dart';
import '../model/upi_id_model.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

extension priceChange on int {
  String priceString() {
    final numberDigits = List.from(this.toString().split(''));
    int index = numberDigits.length - 3;
    while (index > 0) {
      numberDigits.insert(index, ',');
      index -= 3;
    }
    return numberDigits.join();
  }
}

class ProfileController extends GetxController {
  HomeManager _homeManager = Get.put(HomeManager());
  CashBackManager cashBackManager = Get.put(CashBackManager());

  RxBool addPersonalLoading = false.obs,
      addResidentialLoading = false.obs,
      addOccupationLoading = false.obs,
      addNomineeLoading = false.obs,
      getProfileLoading = true.obs,
      getPinCodeLoading = false.obs,
      getBankAccountLoading = false.obs,
      getUpiIdLoading = false.obs,
      autoValidation = false.obs,
      uploadProfileLoading = false.obs,
      logoutLoading = false.obs;
  RxInt currentStep = 1.obs;
  RxBool complete = false.obs;
  final salaryMode = ''.obs;
  List<String> titleList = [
    "Personal",
    "Residential",
    "Occupation",
  ];

  Rx<PageController>? pageSelection;

  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> mobileNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> alternateNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> addressLine1Controller =
      TextEditingController().obs;
  Rx<TextEditingController> addressLine2Controller =
      TextEditingController().obs;
  Rx<TextEditingController> pincodeController = TextEditingController().obs;
  Rx<TextEditingController> occupationController = TextEditingController().obs;
  Rx<TextEditingController> monthlyIncomeController =
      TextEditingController().obs;
  Rx<TextEditingController> panNumberController = TextEditingController().obs;
  Rx<TextEditingController> dobController = TextEditingController().obs;
  Rx<TextEditingController> nomineeNameController = TextEditingController().obs;
  Rx<TextEditingController> nomineeDobController = TextEditingController().obs;

  // additonal info screen in personal loan

  Rx<TextEditingController> noOfMonthsResiding = TextEditingController().obs;
  Rx<TextEditingController> highestQualification = TextEditingController().obs;
  Rx<TextEditingController> companyName = TextEditingController().obs;
  Rx<TextEditingController> designation = TextEditingController().obs;
  Rx<TextEditingController> workExp = TextEditingController().obs;
  Rx<TextEditingController> officeAddressLine1Controller =
      TextEditingController().obs;
  Rx<TextEditingController> officeAddressLine2Controller =
      TextEditingController().obs;
  Rx<TextEditingController> activeOrExistingLoans = TextEditingController().obs;

  RxString maritalStatus = ''.obs,
      employmentType = ''.obs,
      city = ''.obs,
      state = ''.obs,
      gender = ''.obs,
      customerId = ''.obs,
      vehicleType = ''.obs,
      twoWheelermakes = ''.obs,
      twoWheelerModel = ''.obs,
      nomineeRelationship = ''.obs,
      netbanking = ''.obs,
      accountType = ''.obs,
      existingLoan = ''.obs;

  Rx<TextEditingController> bankNameController = TextEditingController().obs;
  Rx<TextEditingController> accountNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> comfirmAccountNumber = TextEditingController().obs;
  Rx<TextEditingController> ifscController = TextEditingController().obs;

  Rx<ProfileDetailsModel> profileDetailsModel = ProfileDetailsModel().obs;

  late SharedPreferences prefs;

  Rx<BankDetailsModel> bankDetailsModel = BankDetailsModel().obs;
  Rx<UploadSignedModel> uploadSignedModel = UploadSignedModel().obs;
  Rx<UpiIdModel> upiIdModel = UpiIdModel().obs;

  RxString image = ''.obs;
  RxString imageUrl = ''.obs;
  CroppedFile? croppedFile;

  resetData() {
    firstNameController.value.text = '';
    lastNameController.value.text = '';
    mobileNumberController.value.text = '';
    alternateNumberController.value.text = '';
    emailController.value.text = '';
    addressLine1Controller.value.text = '';
    addressLine2Controller.value.text = '';
    pincodeController.value.text = '';
    occupationController.value.text = '';
    monthlyIncomeController.value.text = '';
    panNumberController.value.text = '';
    dobController.value.text = '';
    bankNameController.value.text = '';
    accountNumberController.value.text = '';
    ifscController.value.text = '';
    maritalStatus.value = '';
    employmentType.value = '';
    city.value = '';
    state.value = '';
    gender.value = '';
    customerId.value = '';
    accountType!.value = '';
    vehicleType.value = '';
    noOfMonthsResiding.value.text = '';
    highestQualification.value.text = '';
    companyName.value.text = '';
    designation.value.text = '';
    noOfMonthsResiding.value.text = '';
  }

  setData() {
    firstNameController.value.text = profileDetailsModel.value.firstName ?? '';
    lastNameController.value.text = profileDetailsModel.value.lastName ?? '';

    mobileNumberController.value.text =
        profileDetailsModel.value.mobileNumber ?? '';
    alternateNumberController.value.text =
        profileDetailsModel.value.alternateNumber ?? '';
    emailController.value.text = profileDetailsModel.value.email ?? '';
    dobController.value.text = profileDetailsModel.value.dateOfBirth == null
        ? ""
        : DateFormat('dd-MM-yyyy').format(DateFormat("yyyy-MM-dd")
                .parse(profileDetailsModel.value.dateOfBirth!)) ??
            '';
    gender.value = profileDetailsModel.value.gender ?? '';
    maritalStatus.value = profileDetailsModel.value.maritalStatus ?? '';

    addressLine1Controller.value.text =
        profileDetailsModel.value.address?.addressLine1 ?? '';
    addressLine2Controller.value.text =
        profileDetailsModel.value.address?.addressLine2 ?? '';
    pincodeController.value.text =
        profileDetailsModel.value.address?.postCode ?? '';
    city.value = profileDetailsModel.value.address?.city ?? '';
    state.value = profileDetailsModel.value.address?.state ?? '';

    employmentType.value = profileDetailsModel.value.employmentType ?? '';
    occupationController.value.text =
        profileDetailsModel.value.occupation ?? '';
    // monthlyIncomeController.value.text =
    //     "${(profileDetailsModel.value.income ?? 0).toInt().priceString()}";
    monthlyIncomeController.value.text =
        profileDetailsModel.value.income == null
            ? ''
            : CommonMethods()
                .indianRupeeValue(profileDetailsModel.value.income!.toDouble());

    // monthlyIncomeController.value.text =
    //     "${(profileDetailsModel.value.income ?? '').toString()}";
    panNumberController.value.text = profileDetailsModel.value.panNumber ?? '';

    // new changes
    accountType.value = profileDetailsModel.value.salaryMode ?? '';
    highestQualification.value.text =
        profileDetailsModel.value.highestQualification ?? '';

    print(
        "seting data to residing${profileDetailsModel.value.residingTenure.toString()}");

    noOfMonthsResiding.value.text =
        profileDetailsModel.value.residingTenure == null
            ? ""
            : profileDetailsModel.value.residingTenure.toString();
    companyName.value.text = profileDetailsModel.value.companyName == null
        ? ''
        : profileDetailsModel.value.companyName.toString();
    designation.value.text = profileDetailsModel.value.designation == null
        ? ''
        : profileDetailsModel.value.designation.toString();
    workExp.value.text = profileDetailsModel.value.workExperience == null
        ? ''
        : profileDetailsModel.value.workExperience.toString();
    officeAddressLine1Controller.value.text =
        profileDetailsModel.value.officeAddressLine1 == null
            ? ''
            : profileDetailsModel.value.officeAddressLine1.toString();
    officeAddressLine2Controller.value.text =
        profileDetailsModel.value.officeAddressLine2 == null
            ? ''
            : profileDetailsModel.value.officeAddressLine2.toString();
  }

  RxInt loanRequirement = (-1).obs;
  RxInt subProduct = (-1).obs;
  RxInt brand = (-1).obs;
  RxInt trackBasedloanRequirement = (-1).obs;
  RxInt trackBasedsubProduct = (-1).obs;
  RxInt trackBasedbrand = (-1).obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _homeManager.showAuth.value = false;
    getAppVersion();
    getId();
    pageSelection?.value = PageController(initialPage: currentStep.value - 1);
    Future.delayed(Duration(seconds: 2), () {
      getProfileData();
      // getBankDetails();
      // getUpiIdDetails();
    });
  }

  RxString appVersion = "".obs;
  getAppVersion() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    appVersion.value = info.version.trim().toString();
  }

  getId() async {
    prefs = await SharedPreferences.getInstance();
    customerId.value = prefs.getString(SPKeys.CUSTOMER_ID) ?? '';
    return customerId.value;
  }

  next() {
    if (currentStep <= titleList.length) {
      goTo(currentStep.value + 1);
    }
  }

  back() {
    if (currentStep > 1) {
      goTo(currentStep.value - 1);
    }
  }

  goTo(int step) {
    currentStep.value = step;
    if (currentStep > titleList.length) {
      complete.value = true;
    }
  }

  nameValidation(value, message) {
    if (value.toString().trim().length < 3) {
      return message;
    }
    return null;
  }

  accountNumberValidation({value, String? onNullError}) {
    // String pattern = r'(^[0-9]{9,18}$)';
    // RegExp regExp = new RegExp(pattern);
    // if (value.length < 9) {
    //   return 'Please enter valid account number of 9 digit';
    // } else if (!regExp.hasMatch(value)) {
    //   return 'Please enter valid account number';
    // }
    // return null;

    if (value != null) {
      return CommonValidations().numberValidation(
          value: value,
          nullError: onNullError ?? '*Account number is mandatory',
          invalidInputError: 'It only takes numbers',
          minValue: 9);
    } else {
      return '';
    }
  }

  ifscValidation(value) {
    String pattern = r'(^[A-Z]{4}0[A-Z0-9]{6}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length < 8) {
      return 'Please enter valid ifsc code';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid ifsc code';
    }
    return null;
  }

  mobileValidation(value) {
    String pattern = r'(^[0-9]{10}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  emailValidation(value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return null;
  }

  nullCheckValidation(value, message) {
    if (value == '' || value == null) {
      return message;
    }
    return null;
  }

  pinCodeValidation(value) {
    if (value == '' || value == null) {
      return 'Enter your pin code';
    } else if (value.length < 6) {
      return 'Pin code length should not be less than 6';
    }
    return null;
  }

  panValidation(value) {
    String pattern = r"^[A-Z]{5}[0-9]{4}[A-Z]{1}";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid pan number';
    else
      return null;
  }

  _handleMediaPermissions() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? firstInit =
        sharedPreferences.getBool(SPKeys.FIRST_INIT_STORAGE_PERMISSION);
    var status = Permission.storage.request();
    if (await status.isGranted || await status.isLimited) {
      image.value =
          (await _picker.pickImage(source: ImageSource.gallery))!.path;
      Get.back();
      // await cropImage();
      if(image.value!=null)
        {
          await compress().then((value) async {
            await cropImage();
          });
        }

    } else if (await status.isDenied) {
      if (firstInit != null) {
        sharedPreferences.setBool(SPKeys.FIRST_INIT_STORAGE_PERMISSION, true);
      }
    } else if (await status.isPermanentlyDenied) {
      if (firstInit == null || firstInit) {
        sharedPreferences.setBool(SPKeys.FIRST_INIT_STORAGE_PERMISSION, false);
        return false;
      } else {
        Geolocator.openAppSettings();
      }
    }
  }

  _handleCameraPermissions() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? firstInit =
        sharedPreferences.getBool(SPKeys.FIRST_INIT_CAMERA_PERMISSION);
    var status = Permission.camera.request();
    if (await status.isGranted || await status.isLimited) {
      image.value = (await _picker.pickImage(source: ImageSource.camera))!.path;
      Get.back();

      if(image.value!=null)
      {
        await compress().then((value) async {
          await cropImage();
        });
      }
    } else if (await status.isDenied) {
      if (firstInit != null) {
        sharedPreferences.setBool(SPKeys.FIRST_INIT_CAMERA_PERMISSION, true);
      }
    } else if (await status.isPermanentlyDenied) {
      if (firstInit == null || firstInit) {
        sharedPreferences.setBool(SPKeys.FIRST_INIT_CAMERA_PERMISSION, false);
        return false;
      } else {
        Geolocator.openAppSettings();
      }
    }
  }

  Future pickImage(context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: text(
                'Select Image mode',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.font_18sp,
                  color: AppColors.black,
                ),
              ),
            ),
            ListTile(
              title: text('Camera'),
              leading: Icon(Icons.camera_alt_outlined),
              onTap: () async {
                _handleCameraPermissions();
              },
            ),
            Divider(),
            ListTile(
              title: text('Gallery'),
              leading: Icon(Icons.photo_size_select_actual_outlined),
              onTap: () async {
                _handleMediaPermissions();
              },
            ),
          ],
        );
      },
    );
  }

  Future cropImage() async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: image.value,
      cropStyle: CropStyle.circle,
      aspectRatio: CropAspectRatio(ratioX: 0.1, ratioY: 0.1),
      maxHeight: 140,
      maxWidth: 140,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Profile',
            toolbarWidgetColor: Colors.black,
            showCropGrid: false,
            hideBottomControls: true,
            cropFrameColor: Colors.transparent),
        IOSUiSettings(
          title: 'Profile',
        ),
      ],
    );
    if (croppedFile?.path != null) {
      await uploadProfile(croppedFile: croppedFile!);
    }
  }

  Future uploadProfile({required CroppedFile croppedFile}) async {
    uploadProfileLoading.value = true;
    try {
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.generateImageUploadUrl,
        method: Type.POST,
        data: json.encode(
          {
            "customerId": "${prefs.getString(SPKeys.CUSTOMER_ID)}",
            "type": "ProfileImage",
            "fileName": croppedFile.path.toString().split("/").last,
          },
        ),
      );
      if (response != null) {
        uploadSignedModel.value = UploadSignedModel.fromJson(response);
        if (uploadSignedModel.value.uploadSignedURL != null) {
          uploadProfilePic(croppedFile);
        } else {
          Fluttertoast.showToast(
            msg: "something went wrong, try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "something went wrong, try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      uploadProfileLoading.value = false;
      Fluttertoast.showToast(
        msg: "${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      //  uploadProfileLoading.value = false;
    }
  }

  Future uploadProfilePic(CroppedFile croppedFile) async {
    uploadProfileLoading.value = true;
    try {
      Dio dioVar = Dio();
      Uint8List unit8Image = File(croppedFile.path).readAsBytesSync();

      Options options = Options(
        contentType: lookupMimeType(croppedFile.path),
        headers: {
          'Accept': "*/*",
          'Content-Length': unit8Image.length,
          'Connection': 'keep-alive',
          'User-Agent': 'ClinicPlush',
        },
      );

      dio.Response response = await dioVar.put(
        uploadSignedModel.value.uploadSignedURL ?? '',
        data: Stream.fromIterable(unit8Image.map((e) => [e])),
        options: options,
      );
      if (response.statusCode == 200) {
        updateProfileImage();
        Fluttertoast.showToast(
          msg: "Update Image Successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      uploadProfileLoading.value = false;
      Fluttertoast.showToast(
        msg: "${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      //  uploadProfileLoading.value = false;
    }
  }

  Future updateProfileImage() async {
    uploadProfileLoading.value = true;
    try {
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.uploadProfilePic,
        method: Type.PUT,
        data: json.encode(
          {
            "customerId": "${prefs.getString(SPKeys.CUSTOMER_ID)}",
            "fileName": uploadSignedModel.value.fileName,
          },
        ),
      );
      if (response != null) {
        if (response['imageURL'] == null) {
          Fluttertoast.showToast(
            msg: "something went wrong, try again!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Profile updated successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
          profileDetailsModel.value.imageName =
              "${response['imageURL'].toString().split("/").last}";
          profileDetailsModel.refresh();
        }
      } else {
        Fluttertoast.showToast(
          msg: "something went wrong, try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      uploadProfileLoading.value = false;
      Fluttertoast.showToast(
        msg: "${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      uploadProfileLoading.value = false;
    }
  }

  Future addPersonalDetails(
      {bool? isFromLoan = false,
      Function? callBack,
      String? loanApplicationId,
      String? insuranceApplicationId}) async {
    addPersonalLoading.value = true;
    try {
      Map<String, dynamic> personalDetailData = {
        "customerId": "${prefs.getString(SPKeys.CUSTOMER_ID)}",
        if (loanApplicationId != null) ...{
          "loanApplicationId": loanApplicationId,
        },
        if (insuranceApplicationId != null) ...{
          "insuranceApplicationId": insuranceApplicationId,
        },
        "customerDetails": {
          "firstName": firstNameController.value.text.trim(),
          "lastName": lastNameController.value.text.trim().isNotEmpty
              ? lastNameController.value.text.trim()
              : null,
          "mobileNumber": mobileNumberController.value.text.trim(),
          "alternateNumber":
              alternateNumberController.value.text.trim().isNotEmpty
                  ? alternateNumberController.value.text.trim()
                  : null,
          "dateOfBirth": dobController.value.text.trim().isNotEmpty
              ? DateFormat('yyyy-MM-dd').format(
                  DateFormat("dd-MM-yyyy").parse(dobController.value.text))
              : null,
          "preferredLanguage": "EN",
          "email": emailController.value.text.trim().isNotEmpty
              ? emailController.value.text.trim()
              : null,
          "gender": gender.value.isNotEmpty ? gender.value : null,
          "maritalStatus":
              maritalStatus.value.isNotEmpty ? maritalStatus.value : null,
          if (loanApplicationId != null) ...{
            "panNumber": panNumberController.value.text.trim(),
          }
        }
      };

      print("personal details==> ${personalDetailData}");

      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.addPersonalDetails,
        method: Type.PUT,
        data: json.encode(
          {
            "customerId": "${prefs.getString(SPKeys.CUSTOMER_ID)}",
            if (loanApplicationId != null) ...{
              "loanApplicationId": loanApplicationId,
            },
            if (insuranceApplicationId != null) ...{
              "insuranceApplicationId": insuranceApplicationId,
            },
            "customerDetails": {
              "firstName": firstNameController.value.text.trim(),
              "lastName": lastNameController.value.text.trim().isNotEmpty
                  ? lastNameController.value.text.trim()
                  : null,
              "mobileNumber": mobileNumberController.value.text.trim(),
              "alternateNumber":
                  alternateNumberController.value.text.trim().isNotEmpty
                      ? alternateNumberController.value.text.trim()
                      : null,
              "dateOfBirth": dobController.value.text.trim().isNotEmpty
                  ? DateFormat('yyyy-MM-dd').format(
                      DateFormat("dd-MM-yyyy").parse(dobController.value.text))
                  : null,
              "preferredLanguage": "en",
              "email": emailController.value.text.trim().isNotEmpty
                  ? emailController.value.text.trim()
                  : null,
              "gender": gender.value.isNotEmpty ? gender.value : null,
              "maritalStatus":
                  maritalStatus.value.isNotEmpty ? maritalStatus.value : null,
              if (loanApplicationId != null) ...{
                "panNumber": panNumberController.value.text.trim(),
              }
            }
          },
        ),
      );

      print("response of personal deetails==>$response");
      if (response != null) {
        if (isFromLoan == true || loanApplicationId != null) {
          callBack!();
        } else {
          Get.back();
          Fluttertoast.showToast(
            msg: "Update Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        }
        getProfileData();
      } else {
        Fluttertoast.showToast(
          msg: "something went wrong, try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: "${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      addPersonalLoading.value = false;
    }
  }

  Future addResidentialDetails({
    bool? isFromLoan = false,
    Function? callBack,
    String? loanApplicationId,
    String? insuranceApplicationId,
  }) async {
    addResidentialLoading.value = true;
    try {
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.residentialAddress,
        method: Type.PUT,
        data: json.encode(
          {
            "customerId": "${prefs.getString(SPKeys.CUSTOMER_ID)}",
            if (loanApplicationId != null || loanApplicationId != '') ...{
              "loanApplicationId": loanApplicationId,
            },
            if (insuranceApplicationId != null ||
                insuranceApplicationId != '') ...{
              "insuranceApplicationId": insuranceApplicationId,
            },
            "customerDetails": {
              "address": {
                "addressLine1": addressLine1Controller.value.text.isEmpty ||
                        addressLine1Controller.value.text == " "
                    ? null
                    : "${addressLine1Controller.value.text.trim()}",
                "addressLine2": addressLine2Controller.value.text.isEmpty ||
                        addressLine2Controller.value.text == " "
                    ? null
                    : "${addressLine2Controller.value.text.trim()}",
                "postCode": pincodeController.value.text.isEmpty ||
                        pincodeController.value.text == " "
                    ? null
                    : "${pincodeController.value.text.trim()}",
                "city": city.value.isEmpty || city.value == " "
                    ? null
                    : "${city.value}",
                "state": state.value.isEmpty || state.value == " "
                    ? null
                    : "${state.value}",
              }
            }
          },
        ),
      );
      if (response != null) {
        if (isFromLoan == true || loanApplicationId != null) {
          callBack!();
        } else {
          Get.back();
          Fluttertoast.showToast(
            msg: "Update Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        }
        getProfileData();
      } else {
        Fluttertoast.showToast(
          msg: "something went wrong, try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      addResidentialLoading.value = false;
    }
  }

  Future addOccupationDetails(
      {bool? isFromLoan = false,
      Function? callBack,
      String? loanApplicationId,
      String? insuranceApplicationId}) async {
    addOccupationLoading.value = true;
    //

    // print(accountType!.value);
    // print("SENDIG DATA=>$DATA");
    // print("loanApplicationId : $loanApplicationId");
    // print("insuranceApplicationId : $insuranceApplicationId");

    // print(accountType!.value);
    try {
      var response = await DioApiCall().commonApiCall(
          endpoint: Apis.additionalDetails,
          method: Type.PUT,
          data: json.encode(
            {
              "customerId": "${prefs.getString(SPKeys.CUSTOMER_ID)}",
              if (loanApplicationId != null) ...{
                "loanApplicationId": loanApplicationId,
              },
              if (insuranceApplicationId != null) ...{
                "insuranceApplicationId": insuranceApplicationId
              },
              "customerDetails": {
                "panNumber": panNumberController.value.text.isEmpty ||
                        panNumberController.value.text == ""
                    ? null
                    : panNumberController.value.text.trim(),
                "occupation": occupationController.value.text.isEmpty ||
                        occupationController.value.text == " "
                    ? null
                    : "${occupationController.value.text.trim()}",
                "salaryMode":
                    accountType!.value == '' ? null : accountType!.value,
                "income": monthlyIncomeController.value.text.isEmpty ||
                        monthlyIncomeController.value.text == ""
                    ? null
                    : "${monthlyIncomeController.value.text.trim().replaceAll(",", "")}",
                "preferredLanguage": "en",
                "employmentType": employmentType.value.isEmpty ||
                        employmentType.value == ""
                    ? null
                    : "${employmentType.value.toString() == "Self Employed" ? "SelfEmployed" : employmentType.value.toString() == "Business Owner" ? "BusinessOwner" : employmentType.value}",
              }
            },
          ));
      if (response != null) {
        print("response of occuaption${response}");
        if (isFromLoan == true || loanApplicationId != null) {
          callBack!();
        } else {
          Get.back();
          Fluttertoast.showToast(
            msg: "Update Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        }
        getProfileData();
      } else {
        print("response of occuaption${response}");
        Fluttertoast.showToast(
          msg: "something went wrong, try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: "${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      addOccupationLoading.value = false;
    }
  }

  Future addAdditionalDetails(
      {bool? isFromLoan = false,
      Function? callBack,
      String? loanApplicationId,
      String? insuranceApplicationId}) async {
    addOccupationLoading.value = true;

    // Map<String, dynamic> DATA =
    //
    // {
    //   "customerId": "${prefs.getString(SPKeys.CUSTOMER_ID)}",
    //   if (loanApplicationId != null) ...{
    //     "loanApplicationId": "334bfc8e-2cc7-42fa-9ee0-7b79d9c9be2d",
    //   },
    //   if (insuranceApplicationId != null) ...{
    //     "insuranceApplicationId": insuranceApplicationId
    //   },
    //   "customerDetails": {
    //     "panNumber": "${panNumberController.value.text.trim()}",
    //     "occupation": "${occupationController.value.text.trim()}",
    //     "income":
    //     "${monthlyIncomeController.value.text.trim().replaceAll(",", "")}",
    //     "preferredLanguage": "EN",
    //     "employmentType":
    //     "${employmentType.value.toString() == "Self Employed" ? "SelfEmployed" : employmentType.value.toString() == "Business Owner" ? "BusinessOwner" : employmentType.value}",
    //     "residingTenure": "${noOfMonthsResiding.value.text.trim()}",
    //     "companyName": "${companyName.value.text.trim()}",
    //     "designation": "${designation.value.text.trim()}",
    //     "workExperience": "${workExp.value.text.trim()}",
    //     "officeAddressLine1":
    //     "${officeAddressLine1Controller.value.text.trim()}",
    //     "officeAddressLine2":
    //     "${officeAddressLine2Controller.value.text.trim()}",
    //     "activeNetBanking": "${netbanking.value.trim()}",
    //     "activeEmi": "${existingLoan.value.trim()}",
    //     "noOfActiveEmi":
    //     "${activeOrExistingLoans.value.text.trim() == null ? "" : activeOrExistingLoans.value.text.trim()}",
    //     "highestQualification":
    //     "${highestQualification.value.text.trim()}",
    //     "salaryMode": accountType!.value == '' ? null : accountType!.value
    //     // "panNumber": "${panNumberController.value.text.trim()}",
    //     // "occupation": "${occupationController.value.text.trim()}",
    //     // "salaryMode": accountType.value,
    //     // "income":
    //     // "${monthlyIncomeController.value.text.trim().replaceAll(",", "")}",
    //     // "preferredLanguage": "EN",
    //     // "employmentType":
    //     // "${employmentType.value.toString() == "Self Employed" ? "SelfEmployed" : employmentType.value.toString() == "Business Owner" ? "BusinessOwner" : employmentType.value}",
    //   }
    // };
    // print("SENDIG add addition data=>${DATA}");
    // print("loanApplicationId : ${loanApplicationId}");
    // print("insuranceApplicationId : ${insuranceApplicationId}");
    //
    // print(accountType!.value);
    try {
      var response = await DioApiCall().commonApiCall(
          endpoint: Apis.additionalDetails,
          method: Type.PUT,
          data: json.encode({
            "customerId": "${prefs.getString(SPKeys.CUSTOMER_ID)}",
            if (loanApplicationId != null) ...{
              "loanApplicationId": loanApplicationId,
            },
            if (insuranceApplicationId != null) ...{
              "insuranceApplicationId": insuranceApplicationId
            },
            "customerDetails": {
              "panNumber": "${panNumberController.value.text.trim()}",
              "occupation": "${occupationController.value.text.trim()}",
              "income":
                  "${monthlyIncomeController.value.text.trim().replaceAll(",", "")}",
              "preferredLanguage": "en",
              "employmentType":
                  "${employmentType.value.toString() == "Self Employed" ? "SelfEmployed" : employmentType.value.toString() == "Business Owner" ? "BusinessOwner" : employmentType.value}",
              "residingTenure": "${noOfMonthsResiding.value.text.trim()}",
              "companyName": "${companyName.value.text.trim()}",
              "designation": "${designation.value.text.trim()}",
              "workExperience": "${workExp.value.text.trim()}",
              "officeAddressLine1":
                  "${officeAddressLine1Controller.value.text.trim()}",
              "officeAddressLine2":
                  "${officeAddressLine2Controller.value.text.trim()}",
              "activeNetBanking": "${netbanking.value.trim()}",
              "activeEmi": "${existingLoan.value.trim()}",
              "noOfActiveEmi":
                  "${activeOrExistingLoans.value.text.trim() == null ? "" : activeOrExistingLoans.value.text.trim()}",
              "highestQualification":
                  "${highestQualification.value.text.trim()}",
              "salaryMode": accountType!.value == '' ? null : accountType!.value
              // "panNumber": "${panNumberController.value.text.trim()}",
              // "occupation": "${occupationController.value.text.trim()}",
              // "salaryMode": accountType.value,
              // "income":
              // "${monthlyIncomeController.value.text.trim().replaceAll(",", "")}",
              // "preferredLanguage": "EN",
              // "employmentType":
              // "${employmentType.value.toString() == "Self Employed" ? "SelfEmployed" : employmentType.value.toString() == "Business Owner" ? "BusinessOwner" : employmentType.value}",
            }
          }));
      //  print("Additional response : ${response.data}");
      if (response != null) {
        if (isFromLoan == true || loanApplicationId != null) {
          callBack!();
        } else {
          Get.back();
          Fluttertoast.showToast(
            msg: "Update Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        }
        getProfileData();
      } else {
        Fluttertoast.showToast(
          msg: "something went wrong, try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: "${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      addOccupationLoading.value = false;
    }
  }

  void addNomineeDetails(
      {String? insuranceApplicationId,
      required Null Function() callBack}) async {
    addNomineeLoading.value = true;

    // print("empployment type ${employmentType.value}");
    // print(employmentType.value);
    try {
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.updateNomineeDetail,
        method: Type.POST,
        data: json.encode(
          {
            "customerId": "${prefs.getString(SPKeys.CUSTOMER_ID)}",
            if (insuranceApplicationId != null) ...{
              "applicatonId": insuranceApplicationId,
            },
            "nominee": {
              "name": "${nomineeNameController.value.text}",
              "dateOfBirth": nomineeDobController.value.text.trim().isNotEmpty
                  ? nomineeDobController.value.text
                  : null,
              "relationShip": "${nomineeRelationship.value}",
            }
          },
        ),
      );
      print("$response");
      if (response != null) {
        // if (isFromLoan == true || loanApplicationId != null) {
        //   callBack!();
        // } else {
        //   Get.back();
        //   Fluttertoast.showToast(
        //     msg: "Update Successfully!",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     fontSize: 16.0,
        //   );
        // }
        getProfileData();
        callBack();
      } else {
        Fluttertoast.showToast(
          msg: "something went wrong, try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: "${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      addNomineeLoading.value = false;
    }
  }

  Future getProfileData() async {
    try {
      Map<String, dynamic> data = {
        "customerId": '${prefs.getString(SPKeys.CUSTOMER_ID)}',
      };

      print("data of user${data}");
      getProfileLoading.value = true;
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.profile,
        method: Type.POST,
        data: json.encode(
          {
            "customerId": '${prefs.getString(SPKeys.CUSTOMER_ID)}',
          },
        ),
      );

      print("resposne==>${response}");
      if (response != null) {
        profileDetailsModel.value = ProfileDetailsModel.fromJson(response);

        setData();
      }
    } catch (exception) {
      print(exception);
    } finally {
      getProfileLoading.value = false;
    }
  }

  Future getCityState(value) async {
    getPinCodeLoading.value = true;
    try {
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.getCityState + "?postCode=$value",
        method: Type.GET,
      );
      if (response != null) {
        city.value = response['city'];
        state.value = response['state'];
      } else {
        Fluttertoast.showToast(
          msg: "Enter valid pincode.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (exception) {
      Fluttertoast.showToast(
        msg: "$exception",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      getPinCodeLoading.value = false;
    }
  }

  Future getBankDetails() async {
    getBankAccountLoading.value = true;
    try {
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.getBankAccount,
        method: Type.POST,
        data: json.encode(
          {
            "customerId": customerId.value,
          },
        ),
      );
      if (response != null) {
        bankDetailsModel.value = BankDetailsModel.fromJson(response);
      } else {
        Fluttertoast.showToast(
          msg: "couldn't get bank account details.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (exception) {
      Fluttertoast.showToast(
        msg: "$exception",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      getBankAccountLoading.value = false;
    }
  }

  Future getUpiIdDetails() async {
    getUpiIdLoading.value = true;
    try {
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.getUpiIds,
        method: Type.POST,
      );
      if (response != null) {
        upiIdModel.value = UpiIdModel.fromJson(response);
      } else {
        Fluttertoast.showToast(
          msg: "couldn't get upi id details.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0,
        );
      }
    } catch (exception) {
      Fluttertoast.showToast(
        msg: "$exception",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16.0,
      );
    } finally {
      getUpiIdLoading.value = false;
    }
  }

  Future addBankAccountData(String? bankId) async {
    try {
      getBankAccountLoading.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);

      Map<String, dynamic> data = {
        "customerId": customerId,
        "bankAccount": {
          "bankId": bankId,
          "accountNumber": "${accountNumberController.value.text}",
          "ifscCode": "${ifscController.value.text}",
          "accountType": accountType!.value.isEmpty ? null : accountType!.value,
        }
      };

      print("data for add bank${data}");

      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.addBankAccount,
        method: Type.POST,
        data: json.encode(
          {
            "customerId": customerId,
            "bankAccount": {
              "bankId": bankId,
              "accountNumber": "${accountNumberController.value.text}",
              "ifscCode": "${ifscController.value.text}",
              "accountType":
                  accountType!.value.isEmpty ? null : accountType!.value,
            }
          },
        ),
      );

      if (response != null) {
        if (response['account'] != null) {
          cashBackManager.fetchCustomerBankAccounts();
          Get.back();

          const snackBar = SnackBar(
            content: Text('Bank account added!'),
          );
          ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        } else {
          const snackBar = SnackBar(
            content: Text('Server Error!'),
          );
          ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
        }
      }
    } catch (exception) {
      print(exception);
    } finally {
      getBankAccountLoading.value = false;
    }
  }

  Future<void> compress() async {
    var result = await FlutterImageCompress.compressAndGetFile(
      image.value,
      '${image.value}compressed.jpg',
      keepExif: false,
      quality: 66,
    );
    image.value = result!.path;
  }

  // Future logout() async {
  //   try {
  //
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? deviceId = prefs.getString(SPKeys.DEVICE_ID);
  //     String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
  //
  //     Map<String,dynamic> dataforlogout =  {
  //       "customerId": '${customerId}',
  //       "deviceId": '${deviceId}',
  //     };
  //
  //     print("logout body${dataforlogout}");
  //     logoutLoading.value = true;
  //     var response = await DioApiCall().commonApiCall(
  //       endpoint: Apis.logoutUrl,
  //       method: Type.POST,
  //       data: json.encode(
  //         {
  //           "customerId": '${customerId}',
  //           "deviceId": '${deviceId}',
  //         },
  //       ),
  //
  //     );
  //
  //
  //
  //
  //
  //
  //   } catch (exception) {
  //     print(exception);
  //   } finally {
  //     logoutLoading.value = false;
  //   }
  // }

  void logoutUser() async {
    try {
      logoutLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? deviceId = prefs.getString(SPKeys.DEVICE_ID);
      String? customerId = prefs.getString(SPKeys.CUSTOMER_ID);
      String? accessToken = prefs.getString(SPKeys.ACCESS_TOKEN);

      var response = await http.post(Uri.parse(baseUrl + Apis.logoutUrl),
          body: jsonEncode({
            "customerId": customerId,
            "deviceId": deviceId,
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
            //"Authorization": accessToken.toString()
          });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        CommonApiResponseModel commonApiResponseModel =
            CommonApiResponseModel.fromJson(jsonData);

        if (commonApiResponseModel.status!.code == 2000) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          Get.toNamed(MRouter.userLogin);
        } else {
          Flushbar(
            title: "Server Error!",
            message: commonApiResponseModel.status!.message.toString(),
            duration: Duration(seconds: 1),
          )..show(Get.context!);
        }
      } else {
        Flushbar(
          title: "Server Error!",
          message: "Please try after sometime ...",
          duration: Duration(seconds: 1),
        )..show(Get.context!);
      }
    } catch (e) {
      Flushbar(
        title: "Server Error!",
        message: "Please try after sometime ...",
        duration: Duration(seconds: 1),
      )..show(Get.context!);
    } finally {
      logoutLoading.value = false;
    }
  }
}
