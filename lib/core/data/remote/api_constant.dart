

// DEV URL
 final String baseUrl  = "http://india1digital-env.eba-5k3w2wxz.ap-south-1.elasticbeanstalk.com/";

// UAT URL
//final String baseUrl  = "http://india1digitalpack1-env.eba-bd5dres9.ap-south-1.elasticbeanstalk.com/";

class Apis
{
  static String sendOtp = "auth/send-otp";
  static String verifyOtp = "auth/verify-otp";
  static String dashboard = "dashboards/home/";
  static String profile = "customers/profile";
  static String addPersonalDetails = "customers/profile/personal-details";
  static String additionalDetails = "customers/profile/additional-details";
  static String residentialAddress = "customers/profile/residential-address";
  static String getCityState = "city-state";
}