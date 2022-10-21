import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:india_one/screens/onboarding_login/user_login/user_login_ui.dart';



import '../screens/home/bottom_navigation/bottom_tabs_main_io.dart';

import '../screens/loyality_points/loyalty_page.dart';
import '../screens/onboarding_login/finger_print/finger_print_io.dart';
import '../screens/onboarding_login/otp_verified/otp_verified_ui.dart';

import '../screens/onboarding_login/splash/splash_ui.dart';

class MRouter {
  static const String splashRoute = 'SplashWidget';
  static const String homeScreen = 'HomeWidget';
  static const String userLogin = 'UserLogin';
  static const String verifiedScreen = 'VerifiedScreen';
  static const String languageSelectionIO = 'LanguageSelectionIO';
  static const String fingerPrintIO = 'FingerPrintIO';
  static const String loyaltyPoints = 'LoyaltyPoints';






  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return CupertinoPageRoute(builder: (_) => SplashScreen());

      case homeScreen:
        return CupertinoPageRoute(builder: (_) => BottomTabsMainIO());

      case userLogin:
        return CupertinoPageRoute(builder: (_) => UserLogin());

      case verifiedScreen:
        return CupertinoPageRoute(builder: (_) => VerifiedScreen());

      // case languageSelectionIO:
      //   return CupertinoPageRoute(builder: (_) => LanguageSelectionIO());

      case fingerPrintIO:
        return CupertinoPageRoute(builder: (_) => FingerPrintIO());

      case loyaltyPoints:
        return CupertinoPageRoute(builder: (_) => LoyaltyScreen());

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
      body: Center(child: Text('${'no_route_defined'} "$screenName"')),
    );
  }
}
