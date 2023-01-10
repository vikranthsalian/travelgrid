import 'dart:ui';

import 'package:flutter_flavor/flutter_flavor.dart';
class FlavourConstants {
  static  String apiHost =  FlavorConfig.instance.variables["base_url"] ;

  static  String appName =  FlavorConfig.instance.variables["app_title"];
 // static  String appLogo =  FlavorConfig.instance.variables["appLogo"];
  static  String path =  FlavorConfig.instance.variables["image_path"];
  static  bool showNetworkLogs =  FlavorConfig.instance.variables["showNetworkLogs"];

  //splash details
  static  Map<String,dynamic> appThemeData = FlavorConfig.instance.variables["app_theme"];
  static  Map<String,dynamic> splashData = FlavorConfig.instance.variables["splash_screen_data"];
  static  Map<String,dynamic> loginData = FlavorConfig.instance.variables["login_screen_data"];
  static  Map<String,dynamic> homeData = FlavorConfig.instance.variables["home_screen_data"];

//  static  String flavour =  FlavorConfig.instance.name.toString();
//  static  bool enableTesting =  FlavorConfig.instance.variables["enableUnitTesting"];
}