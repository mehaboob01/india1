// DEV URL
final String baseUrl = "http://api-dev.india1-digital.hummingwavetech.com/v1/";

// UAT URL
//final String baseUrl  = "http://india1digitalpack1-env.eba-bd5dres9.ap-south-1.elasticbeanstalk.com/";

class Apis {
  // OnBoarding & login Api
  static String sendOtp = "auth/send-otp";
  static String verifyOtp = "auth/verify-otp";
  static String dashboard = "dashboards/home/";

  // Loyalty Program Api

  static String loyaltyDashBoard = "dashboards/loyalty-program";
  static String loyaltyHistory = "loyalty/loyalty-history";

  // Mobile Recharge Api
  static String operatorList = "loyalty/recharge/operator/list";
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

  static String profile = "customers/profile";
  static String addPersonalDetails = "customers/profile/personal-details";
  static String additionalDetails = "customers/profile/additional-details";
  static String residentialAddress = "customers/profile/residential-address";
  static String getCityState = "city-state";
  static String addBankAccount = "loyalty/customer/bank/account";
  static String getBankAccount = "loyalty/customer/bank/accounts";
  static String getUpiIds = "loyalty/customer/upi/id";
  static String recentTransactionLoan = "dashboards/loans";
  static String createLoanApplication = "loans/application";
  static String updateAmountLoan = "loans/application/update-amount";
  static String getProviders = "loans/providers";
  static String getLenders = "loans/lenders";
  static String applyLoan = "loans/apply";
}
