import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:india_one/constant/routes.dart';
import 'package:india_one/constant/theme_manager.dart';
import 'package:india_one/core/data/model/common_model.dart';
import 'package:india_one/core/data/remote/api_constant.dart';
import 'package:india_one/core/data/remote/dio_api_call.dart';
import 'package:india_one/screens/onboarding_login/splash/splash_ui.dart';
import 'package:india_one/screens/profile/model/bank_details_model.dart';
import 'package:india_one/screens/profile/model/profile_details_model.dart';
import 'package:india_one/screens/profile/model/upload_signed_model.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../core/data/local/shared_preference_keys.dart';
import '../../home_start/home_manager.dart';
import '../model/upi_id_model.dart';

class ProfileController extends GetxController {
  HomeManager _homeManager = Get.put(HomeManager());
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

  RxString maritalStatus = ''.obs,
      employmentType = ''.obs,
      city = ''.obs,
      state = ''.obs,
      gender = ''.obs,
      customerId = ''.obs,
      accountType = ''.obs,
      vehicleType = ''.obs,
      nomineeRelationship = ''.obs;

  Rx<TextEditingController> bankNameController = TextEditingController().obs;
  Rx<TextEditingController> accountNumberController =
      TextEditingController().obs;
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
    accountType.value = '';
    vehicleType.value = '';
  }

  setData() {
    firstNameController.value.text = profileDetailsModel.value.firstName ?? '';
    lastNameController.value.text = profileDetailsModel.value.lastName ?? '';
    mobileNumberController.value.text =
        profileDetailsModel.value.mobileNumber ?? '';
    alternateNumberController.value.text =
        profileDetailsModel.value.alternateNumber ?? '';
    emailController.value.text = profileDetailsModel.value.email ?? '';
    dobController.value.text = profileDetailsModel.value.dateOfBirth ?? '';
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
    monthlyIncomeController.value.text = "${profileDetailsModel.value.income}";
    panNumberController.value.text = profileDetailsModel.value.panNumber ?? '';
  }

  RxInt loanRequirement = (-1).obs;
  RxInt subProduct = (-1).obs;
  RxInt brand = (-1).obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _homeManager.showAuth.value = false;
    getId();
    pageSelection?.value = PageController(initialPage: currentStep.value - 1);
    Future.delayed(Duration(seconds: 2), () {
      getProfileData();
      // getBankDetails();
      // getUpiIdDetails();
    });
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

  accountNumberValidation(value) {
    String pattern = r'(^[0-9]{9,18}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length < 9) {
      return 'Please enter valid account number of 9 digit';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid account number';
    }
    return null;
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
    if (value.toString().trim().length < 6) {
      return 'Enter valid pin code';
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
              child: Text(
                'Select Image mode',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimens.font_18sp,
                  color: AppColors.black,
                ),
              ),
            ),
            ListTile(
              title: Text('Camera'),
              leading: Icon(Icons.camera_alt_outlined),
              onTap: () async {
                image.value =
                    (await _picker.pickImage(source: ImageSource.camera))!.path;
                Get.back();
                await cropImage();
              },
            ),
            Divider(),
            ListTile(
              title: Text('Gallery'),
              leading: Icon(Icons.photo_size_select_actual_outlined),
              onTap: () async {
                image.value =
                    (await _picker.pickImage(source: ImageSource.gallery))!
                        .path;
                Get.back();
                await cropImage();
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
              "firstName": firstNameController.value.text,
              "lastName": lastNameController.value.text.trim().isNotEmpty
                  ? lastNameController.value.text
                  : null,
              "mobileNumber": mobileNumberController.value.text,
              "alternateNumber": alternateNumberController.value.text,
              "dateOfBirth": dobController.value.text.trim().isNotEmpty
                  ? dobController.value.text
                  : null,
              "preferredLanguage": "EN",
              "email": emailController.value.text.trim().isNotEmpty
                  ? emailController.value.text
                  : null,
              "gender": gender.value.isNotEmpty ? gender.value : null,
              "maritalStatus":
                  maritalStatus.value.isNotEmpty ? maritalStatus.value : null,
              if (loanApplicationId != null) ...{
                "panNumber": panNumberController.value.text,
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
      addPersonalLoading.value = false;
    }
  }

  Future addResidentialDetails(
      {bool? isFromLoan = false,
      Function? callBack,
      String? loanApplicationId,String? insuranceApplicationId,}) async {
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
            },if (insuranceApplicationId != null || insuranceApplicationId != '') ...{
              "insuranceApplicationId": insuranceApplicationId,
            },
            "customerDetails": {
              "address": {
                "addressLine1": "${addressLine1Controller.value.text}",
                "addressLine2": "${addressLine2Controller.value.text}",
                "postCode": "${pincodeController.value.text}",
                "city": "${city.value}",
                "state": "${state.value}"
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

    print("empployment type ${employmentType.value}");
    print(employmentType.value);
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
              "panNumber": "${panNumberController.value.text}",
              "occupation": "${occupationController.value.text}",
              "income": "${monthlyIncomeController.value.text}",
              "preferredLanguage": "EN",
              "employmentType":
                  "${employmentType.value.toString() == "Self Employed" ? "SelfEmployed" : employmentType.value.toString() == "Business Owner" ? "BusinessOwner" : employmentType.value}",
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

  Future addBankAccountData() async {
    try {
      getBankAccountLoading.value = true;
      var response = await DioApiCall().commonApiCall(
        endpoint: Apis.addBankAccount,
        method: Type.POST,
        data: json.encode(
          {
            "customerId": customerId.value,
            "bankAccount": {
              "accountNumber": "${accountNumberController.value.text}",
              "ifscCode": "${ifscController.value.text}",
              "accountType": "${accountType.value}",
            }
          },
        ),
      );
      if (response != null) {
        if (response['account'] != null) {
          getBankDetails();
          Get.back();
        }
      }
    } catch (exception) {
      print(exception);
    } finally {
      getBankAccountLoading.value = false;
    }
  }

  logoutApi(BuildContext context) async {
    try {
      logoutLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? deviceId = prefs.getString(SPKeys.DEVICE_ID);
      String? customerID = prefs.getString(SPKeys.CUSTOMER_ID);
      var response = await http.post(Uri.parse(baseUrl + Apis.log_out),
          body: jsonEncode({"customerId": customerID, "deviceId": deviceId}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "x-digital-api-key": "1234"
          });

      print("response of send otp${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        CommonApiResponseModel commonApiResponseModel =
            CommonApiResponseModel.fromJson(jsonData);

        if (commonApiResponseModel.status!.code == 2000) {
          logoutLoading.value = false;
          if (Platform.isAndroid) {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.clear();

            Navigator.of(context).pushNamedAndRemoveUntil(
                MRouter.splashRoute, (Route<dynamic> route) => false);
          } else if (Platform.isIOS) {
            exit(0);
          }
        } else {
          Flushbar(
            title: "Server Error!",
            message: commonApiResponseModel.status!.message.toString(),
            duration: Duration(seconds: 1),
          )..show(Get.context!);
        }
      } else {
        logoutLoading.value = false;
        Flushbar(
          title: "Server Error!",
          message: "Please try after sometime ...",
          duration: Duration(seconds: 1),
        )..show(Get.context!);
      }
    } catch (e) {
      var snackBar = SnackBar(
        content: Text("Something went wrong!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      logoutLoading.value = false;
    }
  }
}
