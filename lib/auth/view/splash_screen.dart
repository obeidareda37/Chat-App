import 'dart:async';

import 'package:chat_app/auth/view/home_page.dart';
import 'package:chat_app/auth/view/welcome_page.dart';
import 'package:chat_app/helpers/shared_pref.dart';
import 'package:chat_app/service/routes_helpers.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static final routName = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(Duration(seconds: 2)).then((value) =>
    //     Provider.of<AuthProvider>(context, listen: false).checkLogin());
    Timer(
      Duration(seconds: 3),
      () => firstTime(),
    );
  }

  firstTime() async {
    if (await SpHelper.spHelper.getUser() == null) {
      RouteHelper.routeHelper.goToPageReplacement(WelcomePage.routeName);
    }
    if (await SpHelper.spHelper.getUser() != null) {
      RouteHelper.routeHelper.goToPageReplacement(HomePage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
    );
  }
}
