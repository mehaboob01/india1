

// DEV URL
 final String baseUrl  = "http://india1digital-env.eba-5k3w2wxz.ap-south-1.elasticbeanstalk.com/";

// UAT URL
//final String baseUrl  = "http://india1digitalpack1-env.eba-bd5dres9.ap-south-1.elasticbeanstalk.com/";

class Apis
{

  // OnBoarding & login Api
  static String sendOtp = "auth/send-otp";
  static String verifyOtp = "auth/verify-otp";
  static String dashboard = "dashboards/home/";

  // Loyalty Program Api

  static String loyaltyDashBoard = "dashboards/loyalty-program";
  static String loyaltyHistory = "loyalty/loyalty-history";

  // Mobile Recharge Api
  static String operatorList = "loyalty/recharge/operator/list?isPrepaid=1";
  static String circleList = "loyalty/recharge/circle/list";
  static String plans = "loyalty/recharge/plans";
  static String recharge = "loyalty/recharge/mobile";

  // bank api

  static String banks = "loyalty/banks";
  static String cashBackToBank = "loyalty/cashback/bank";
  static String fetchCustomerBankAccounts = "loyalty/customer/bank/accounts";
  static String addCustomerBankAccount = "loyalty/customer/bank/account"; //post method
  static String deleteCustomerBankAccount = "loyalty/customer/bank/account"; // delete method

  // upi api

  static String cashBackToUpi = "loyalty/cashback/upi";
  static String upiVerify = "loyalty/cashback/upi/verify";
  static String fetchCustomerUpiAccounts = "loyalty/customer/upi/ids";
  static String addCustomerUpiAccount = "loyalty/customer/upi/id"; //post method
  static String deleteCustomerUpiAccount = "loyalty/customer/upi/id"; // delete method









  // profile section api's
  static String profile = "customers/profile";
  static String addPersonalDetails = "customers/profile/personal-details";
  static String additionalDetails = "customers/profile/additional-details";
  static String residentialAddress = "customers/profile/residential-address";
  static String getCityState = "city-state";
}