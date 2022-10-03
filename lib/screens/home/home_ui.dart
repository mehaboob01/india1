import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/theme_manager.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final tabs = [UserHistory(), UserService(), ProfilePage()];
  // int currentIndexValue = 1;
  // String _title = 'Services';
  // String? userName;
  // String? userEmail;
  // String? userMobile;
  // String? userCity;
  //
  // final Uri _url = Uri.parse('https://agents.bugsbon.com/privacy.html');
  // final Uri _uri2 =
  // Uri.parse('https://agents.bugsbon.com/terms-and-condition.html');
  // final Uri _uri3 =
  // Uri.parse('https://agents.bugsbon.com/return-and-refund-policy.html');
  // final Uri _uri4 = Uri.parse('https://agents.bugsbon.com/about-us.html');
  // final Uri _uri5 =
  // Uri.parse('https://merchant.razorpay.com/policy/KJnxHHdbO3wOu0/shipping');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("Home Screen"));
  }
}
