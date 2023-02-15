// //DEV URL
final String baseUrl = "http://api-dev.india1-digital.hummingwavetech.com/v1/";
final String bucketBaseUrl =
    "https://india1-digital.s3.ap-south-1.amazonaws.com";

// UAT URL
// final String baseUrl = "https://digitaluatbackend.india1.co.in/v1/";
// final String bucketBaseUrl =
//     "https://hummingwave-uat.s3.ap-south-1.amazonaws.com";

// // prod link

// final String baseUrl = "https://digitalapi.india1.co.in/v1/";
// final String bucketBaseUrl = "https://india1-digital-production.s3.ap-south-1.amazonaws.com";

class Apis {
  // OnBoarding & login Api
  static String sendOtp = "auth/send-otp";
  static String verifyOtp = "auth/verify-otp";

  static String dashboard = "dashboards/home/";

  // for money withdrawl pop -up
  static String dashboardHome = "dashboards/home-test";
  static String updatePopUp = "dashboards/update-popup";

  static String bannerAds = "advertisement-banners";
  static String termCondition = "terms-and-conditions?language=";
  static String refreshTokenApi = "auth/refresh-token";

  // payments api
  static String payment_recharge = "dashboards/payments/Recharge";
  static String payment_dth = "dashboards/payments/DTH";
  static String payment_fastag = "dashboards/payments/Fastag";

  //map location's
  static String mapLocations = "atms/locations?customer-id=";

  // Loyalty Program Api

  static String loyaltyDashBoard = "dashboards/loyalty-program";
  static String loyaltyHistory = "loyalty/loyalty-history";
  static String usedPointsHistory = "dashboards/loyalty-program";

  // Mobile Recharge Api
  static String operatorList = "loyalty/recharge/operator/list?isPrepaid=1";
  static String circleList = "loyalty/recharge/circle/list";
  static String plans = "loyalty/recharge/plans";
  static String recharge = "loyalty/recharge/mobile";

  // bank api

  static String banks = "loyalty/banks";
  static String cashBackToBank = "loyalty/cashback/bank";
  static String updateBank = "customer/bank/account";
  static String fetchCustomerBankAccounts = "customer/bank/accounts";
  static String addCustomerBankAccount =
      "loyalty/customer/bank/account"; //post method
  static String deleteCustomerBankAccount =
      "customer/bank/account"; // delete method

  // upi api

  static String cashBackToUpi = "loyalty/cashback/upi";
  static String upiAdd = "customer/upi/id";
  static String upiUpdate = "customer/upi/id";
  static String fetchCustomerUpiAccounts = "customer/upi/ids";
  static String addCustomerUpiAccount = "loyalty/customer/upi/id"; //post method
  static String deleteCustomerUpiAccount = "customer/upi/id"; // delete method

  // for commit only
  // profile section api's
  static String profile = "customers/profile";
  static String addPersonalDetails = "customers/profile/personal-details";
  static String additionalDetails = "customers/profile/additional-details";
  static String residentialAddress = "customers/profile/residential-address";
  static String getCityState = "city-state";
  static String addBankAccount = "customer/bank/account";
  static String getBankAccount = "customer/bank/accounts";
  static String getUpiIds = "loyalty/customer/upi/id";
  static String updateNomineeDetail = "insurances/application/update-nominee";

  // //Loans

  // static String recentTransactionLoan = "dashboards/loans";
  // static String createLoanApplication = "loan/application";
  // static String updateAmountLoan = "loan/application/update-amount";
  //
  // static String getProviders = "loans/providers";
  // static String getLenders = "loans/lenders";
  // static String applyLoan = "loans/apply";

  static String recentTransactionLoan = "dashboards/loans";
  static String createLoanApplication = "loans/application";
  static String updateAmountLoan = "loans/application/update-basic-details";
  static String getProviders = "loans/providers";
  static String getLenders = "loans/lenders";
  static String applyLoan = "loans/apply";
  static String fetchFarmProducts = "loans/fetch-farm-products";
  static String fetcTrackBasedLoanProducts =
      "loans/fetch-track-based-loan-products";
  static String updateFarmLoanDetails =
      "loans/application/update-basic-details";
  static String fetchTwoWheelerMakes = "loans/fetch-two-wheeler-makes";
  static String fetchTwoWheelerModels = "loans/fetch-two-wheeler-models";

  ///insurance
  static String createInsurance = "insurances/application";
  static String applyForInsurance = "/insurances/apply";

  //uploadProfile
  static String generateImageUploadUrl = "images/generate-pre-signed-url";
  static String uploadProfilePic = "customers/profile/image";

  // 2 wheeler loan
  static String twoWheelerProduct = "loans/fetch-two-wheeler-makes";
  static String twoWheelerModel = "loans/fetch-two-wheeler-models";

  //miscellaneous
  static String profileImageUrl = "$bucketBaseUrl/images/profile-images/";
  static String creditCard =
      "https://applycc.yesbank.in/YESBankCreditCard?uid=ab180";
  static String emiCard =
      "https://www.bajajfinserv.in/insta-emi-network-card-apply-online?utm_source=RPMGA&utm_medium=Ind108&utm_campaign=A";
  static String msme = "https://flutter.dev/";
  static String creditScore =
      "https://www.creditmantri.com/alliance/?utm_content=alliance-lp&alliance_lender=india1&utm_campaign=alliances&utm_source=india1_PWA_EN&utm_term=alliance_india1&utm_medium=alliance";
  static String fdLink =
      "https://cos.stfc.in/cos/affiliate/cos_schemedetails.aspx?affiliatecode=INDIA1&subaffiliatecode=APP";
  static String digiGold =
      "https://investhaat.augmont.com/buy?utm_source=India1&utm_medium=APP&utm_campaign=1";
  static String twoWheelerIns =
      "https://www.godigit.com/partner/two-wheeler-insurance?utm_source=partner&utm_medium=email&utm_campaign=IndiaOne&utm_content=teleblock&imdKey=F355351E7D59822A22B60E6E82527C0A";
  static String Faq = "https://digitaluat.india1.co.in/Faq";
  static String fourWheelerIns =
      "https://www.godigit.com/partner/go-digit-car-insurance?utm_source=partner&utm_medium=email&utm_campaign=IndiaOne&utm_content=teleblock&imdKey=F355351E7D59822A22B60E6E82527C0A";

  // token related api's

  static String sendToken = "auth/device/token";

  // logout
  static String log_out = "auth/log-out";

  // notifications

  static String notifications = "notifications/list";
  static String markAsRead = "notifications/read";

  //insurance
  static String insuranceDashboard = "dashboards/insurances";

  //logout
  static String logoutUrl = "auth/log-out";
  // Refer app

  static String referApp = "referrals/refer";

  //Google Maps Key
  static String kPLACES_API_KEY = "AIzaSyDrS8UbvTITLC-jYhVQGLwLozz-CgKhw7k";
  // update language

  static String updateLan = "customers/profile/language";
}
