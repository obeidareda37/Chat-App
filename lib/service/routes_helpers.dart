
import 'package:flutter/material.dart';

class RouteHelper {
  RouteHelper._();

  static RouteHelper routeHelper = RouteHelper._();
  GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  goToPage(String routeName) {
    navKey.currentState.pushNamed(routeName);
  }

  goToPageReplacement(String routeName) {
    navKey.currentState.pushReplacementNamed(routeName);
  }

  back(){
    navKey.currentState.pop();
  }
}
