import 'dart:ui';

import 'package:flutter_flavor/flutter_flavor.dart';
class FlavourConstants {
  static  String apiHost =  FlavorConfig.instance.variables["base_url"] ;

  static  String appName =  FlavorConfig.instance.variables["app_title"];
 // static  String appLogo =  FlavorConfig.instance.variables["appLogo"];

  //splash details
  static  String path =  FlavorConfig.instance.variables["image_path"];
  static  String splashLogo =  FlavorConfig.instance.variables["splash_screen_data"]["splash_logo"];
  static  int splashTimer =  FlavorConfig.instance.variables["splash_screen_data"]["splash_duration"];
  static  String poweredBy =  FlavorConfig.instance.variables["splash_screen_data"]["splash_legal_name"];
  static  Color splashBgColor = Color(int.parse(FlavorConfig.instance.variables["splash_screen_data"]["splash_bg_color"]));
  static  Color splashTextColor = Color(int.parse(FlavorConfig.instance.variables["splash_screen_data"]["splash_text_color"]));

//  static  String flavour =  FlavorConfig.instance.name.toString();
//  static  bool enableTesting =  FlavorConfig.instance.variables["enableUnitTesting"];
}