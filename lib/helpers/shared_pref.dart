import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SpHelper {
  SpHelper._();
  static SpHelper spHelper = SpHelper._();
  SharedPreferences sharedPreferences;
  bool firstTime;

  initSharedPreferences()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  saveUser(bool firstTime){
    sharedPreferences.setBool('firstTime',firstTime);
    print('login firstTime $firstTime');

  }
  bool getUser(){
    firstTime = sharedPreferences.getBool('firstTime');
    if (firstTime == null){
      print('get login firstTime == null');
      return null;
    }
    print('get login firstTime');
    return firstTime;
  }

}