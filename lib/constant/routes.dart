
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/home/home_ui.dart';
import '../screens/onboarding_login/splash/splash_ui.dart';


class MRouter {
  static const String splashRoute = 'SplashWidget';
  static const String homeScreen = 'HomeWidget';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return CupertinoPageRoute(builder: (_) => SplashScreen());

      case homeScreen:
        return CupertinoPageRoute(builder: (_) => HomeScreen());







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
