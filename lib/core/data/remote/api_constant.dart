

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
}