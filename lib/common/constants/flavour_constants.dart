import 'package:flutter_flavor/flutter_flavor.dart';
class FlavourConstants {
  static  String apiHost =  FlavorConfig.instance.variables["baseUrl"] ;
  static  bool enableTesting =  FlavorConfig.instance.variables["enableUnitTesting"];
  static  String appName =  FlavorConfig.instance.variables["appName"];
  static  String appLogo =  FlavorConfig.instance.variables["appLogo"];
  static  String splashLogo =  FlavorConfig.instance.variables["splashLogo"];
  static  String svgLogo =  FlavorConfig.instance.variables["svgLogo"];
  static  String poweredBy =  FlavorConfig.instance.variables["poweredBy"];
  static  String flavour =  FlavorConfig.instance.name.toString();

}