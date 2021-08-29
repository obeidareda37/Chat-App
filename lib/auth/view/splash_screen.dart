import 'dart:async';

import 'package:chat_app/auth/view/home_page.dart';
import 'package:chat_app/auth/view/welcome_page.dart';
import 'package:chat_app/helpers/shared_pref.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/service/routes_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Future.delayed(Duration(seconds: 2)).then((value) =>
        Provider.of<AuthProvider>(context, listen: false).checkLogin());
  }

  // firstTime() async {
  //   if (await SpHelper.spHelper.getUser() == false) {
  //     RouteHelper.routeHelper.goToPageReplacement(WelcomePage.routeName);
  //   }
  //   if (await SpHelper.spHelper.getUser() != true) {
  //     RouteHelper.routeHelper.goToPageReplacement(HomePage.routeName);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
    );
  }
}
