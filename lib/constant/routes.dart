import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:india_one/screens/loyality_points/general_history/general_history_ui.dart';
import 'package:india_one/screens/map/map_ui.dart';
import 'package:india_one/screens/notification/notification_screen.dart';
import 'package:india_one/screens/loans/bike_loan/bike_loan.dart';
import 'package:india_one/screens/loans/car_loan/car_loan.dart';
import 'package:india_one/screens/loans/farm_loan/farm_loan.dart';
import 'package:india_one/screens/loans/gold_loan/gold_loan.dart';
import 'package:india_one/screens/loans/tractor_loan/tractor_loan.dart';
import 'package:india_one/screens/onboarding_login/user_login/user_login_ui.dart';
import '../screens/Pages/loans.dart';
import '../screens/home/bottom_navigation/bottom_tabs_main_io.dart';

import '../screens/insurances/bike_insurance/bike_insurance_web_view.dart';
import '../screens/insurances/car_insurance/car_insurance_web_view.dart';
import '../screens/loans/credit_card/credit_card_web_view.dart';
import '../screens/loans/credit_score/credit_score_web_view.dart';
import '../screens/loans/emi_card/emi_card_web_view.dart';
import '../screens/loans/personal_loan_io/personal_loan.dart';
import '../screens/loyality_points/cashback_redeem/cashback_redeemption_screen.dart';
import '../screens/loyality_points/loyalty_page.dart';
import '../screens/loyality_points/mobile_recharge/mobile_recharge_ui.dart';
import '../screens/loyality_points/redeem_points/rp_ui.dart';
import '../screens/onboarding_login/otp_verified/otp_verified_ui.dart';
import '../screens/onboarding_login/splash/splash_ui.dart';
import '../screens/refer/refer_earn_ui.dart';

class MRouter {
  static const String splashRoute = 'SplashWidget';
  static const String homeScreen = 'HomeWidget';
  static const String userLogin = 'UserLogin';
  static const String verifiedScreen = 'VerifiedScreen';
  static const String languageSelectionIO = 'LanguageSelectionIO';
  static const String fingerPrintIO = 'FingerPrintIO';
  static const String loyaltyPoints = 'LoyaltyPoints';
  static const String personalLoan = 'PersonalLoan';
  static const String chooseAmountIO = 'ChooseAmountIO';
  static const String redeemPointsPage = 'RedeemPointsPage';
  static const String cashBackRedeemPage = 'CashBackRedeemPage';
  static const String mobileRechargeIO = 'MobileRechargeIO';
  static const String generalHistory = 'GeneralHistory';
  static const String map = 'Mapscreen';
  static const String notificationScreen = 'NotificationScreen';
  static const String bikeLoanIO = 'BikeLoanIO';
  static const String carLoanIO = 'CarLoanIO';
  static const String goldLoanIO = 'GoldLoanIO';
  static const String tractorLoanIO = 'TractorLoanIO';
  static const String creditScore = 'CreditScore';
  static const String creditCard = 'CreditCardWebView';
  static const String emiCard = 'EmiCard';
  static const String bikeInsurance = 'BikeInsurance';
  static const String carInsurance = 'CarInsurance';
  static const String loanPage = 'LoansPage';
  static const String referEarn = 'ReferEarn';

  static const String farmLoan = 'FarmLoan';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return CupertinoPageRoute(builder: (_) => SplashScreen());

      case homeScreen:
        return CupertinoPageRoute(builder: (_) => BottomTabsMainIO());
      case referEarn:
        return CupertinoPageRoute(builder: (_) => ReferEarn());

      case loanPage:
        return CupertinoPageRoute(builder: (_) => LoansPage());

      case userLogin:
        return CupertinoPageRoute(builder: (_) => UserLogin());

      case emiCard:
        return CupertinoPageRoute(builder: (_) => EmiCard());

      case carInsurance:
        return CupertinoPageRoute(builder: (_) => CarInsurance());

      case bikeInsurance:
        return CupertinoPageRoute(builder: (_) => BikeInsurance());

      case verifiedScreen:
        return CupertinoPageRoute(builder: (_) => VerifiedScreen());

      case creditCard:
        return CupertinoPageRoute(builder: (_) => CreditCardWebView());

      case mobileRechargeIO:
        return CupertinoPageRoute(builder: (_) => MobileRechargeIO());

      case personalLoan:
        return CupertinoPageRoute(builder: (_) => MobileRechargeIO());

      case chooseAmountIO:
        return CupertinoPageRoute(builder: (_) => PersonalLoan());

      case cashBackRedeemPage:
        return CupertinoPageRoute(builder: (_) => CashBackRedeemPage());

      case redeemPointsPage:
        return CupertinoPageRoute(builder: (_) => RedeemPointsPage());

      case loyaltyPoints:
        return CupertinoPageRoute(builder: (_) => LoyaltyScreen());
      case map:
        return CupertinoPageRoute(builder: (_) => Maps());
      case generalHistory:
        return CupertinoPageRoute(builder: (_) => GeneralHistory());

      case notificationScreen:
        return CupertinoPageRoute(builder: (_) => NotificationScreen());

      case bikeLoanIO:
        return CupertinoPageRoute(builder: (_) => BikeLoanIO());

      case carLoanIO:
        return CupertinoPageRoute(builder: (_) => CarLoanIO());

      case goldLoanIO:
        return CupertinoPageRoute(builder: (_) => GoldLoanIO());

      case tractorLoanIO:
        return CupertinoPageRoute(builder: (_) => TractorLoanIO());
      case creditScore:
        return CupertinoPageRoute(builder: (_) => CreditScore());

      case farmLoan:
        return CupertinoPageRoute(builder: (_) => FarmLoan());

      default:
        return CupertinoPageRoute(builder: (_) => NoRouteScreen(settings.name));
    }
  }

  static Future<dynamic> pushNamedAndRemoveUntil(
      BuildContext context, String named) {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil(named, (Route<dynamic> route) => false);
  }

  static Future<dynamic> pushReplacementNamed(
      BuildContext context, String route) {
    return Navigator.of(context).pushReplacementNamed(route);
  }

  static pop(BuildContext context) {
    return Navigator.pop(context);
  }
}

class NoRouteScreen extends StatelessWidget {
  final String? screenName;

  NoRouteScreen(this.screenName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(child: Text('${'no_route_defined'} "$screenName"')),
    );
  }
}
