
import 'package:flutter_flavor/flutter_flavor.dart';
class FlavourConstants {
  static  String apiHost =  FlavorConfig.instance.variables["base_url"] ;

  static  String appName =  FlavorConfig.instance.variables["app_title"];
 // static  String appLogo =  FlavorConfig.instance.variables["appLogo"];
  static  String path =  FlavorConfig.instance.variables["asset_path"];
  static  bool showNetworkLogs =  FlavorConfig.instance.variables["showNetworkLogs"];

  //splash details
  static  Map<String,dynamic> appThemeData = FlavorConfig.instance.variables["app_theme"];
  static  Map<String,dynamic> splashData = FlavorConfig.instance.variables["splash_screen_data"];
  static  Map<String,dynamic> loginData = FlavorConfig.instance.variables["login_screen_data"];
  static  Map<String,dynamic> homeData = FlavorConfig.instance.variables["home_screen_data"];

  //List Data
  static  Map<String,dynamic> trData = FlavorConfig.instance.variables["tr_screen_data"];
  static  Map<String,dynamic> teData = FlavorConfig.instance.variables["te_screen_data"];
  static  Map<String,dynamic> geData = FlavorConfig.instance.variables["ge_screen_data"];
  static  Map<String,dynamic> approvalData = FlavorConfig.instance.variables["approval_screen_data"];


  static  Map<String,dynamic> policyData = FlavorConfig.instance.variables["policy_screen_data"];
  static  Map<String,dynamic> pdfData = FlavorConfig.instance.variables["pdf_screen_data"];
  static  Map<String,dynamic> cityData = FlavorConfig.instance.variables["city_screen_data"];

  //Dialogs
  static  Map<String,dynamic> accomTypeData = FlavorConfig.instance.variables["accom_type_screen_data"];
  static  Map<String,dynamic> miscTypeData = FlavorConfig.instance.variables["misc_type_screen_data"];
  static  Map<String,dynamic> travelModeData = FlavorConfig.instance.variables["travel_mode_screen_data"];
  static  Map<String,dynamic> uploadData = FlavorConfig.instance.variables["upload_screen_data"];
  static  Map<String,dynamic> yesNoData = FlavorConfig.instance.variables["dialog_yes_no_data"];

  //Create GE Data
  static  Map<String,dynamic> geCreateData = FlavorConfig.instance.variables["ge_create_data"];
  static  Map<String,dynamic> accomCreateData = FlavorConfig.instance.variables["accom_create_data"];
  static  Map<String,dynamic> conveyanceCreateData = FlavorConfig.instance.variables["conveyance_create_data"];
  static  Map<String,dynamic> miscCreateData = FlavorConfig.instance.variables["misc_create_data"];

  //Create TE Data
  static  Map<String,dynamic> teCreateData = FlavorConfig.instance.variables["te_create_data"];
  static  Map<String,dynamic> teAddVisitData = FlavorConfig.instance.variables["add_visit_data"];

//  static  String flavour =  FlavorConfig.instance.name.toString();
//  static  bool enableTesting =  FlavorConfig.instance.variables["enableUnitTesting"];
}