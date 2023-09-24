import 'package:flutter_flavor/flutter_flavor.dart';

class FlavourConstants {
  static  String apiHost =  FlavorConfig.instance.variables["prod_url"] ;

  static  String appName =  FlavorConfig.instance.variables["app_title"];
  static  String appAndroidUrl =  FlavorConfig.instance.variables["app_android_url"];
  static  String appIosUrl =  FlavorConfig.instance.variables["app_ios_url"];
  static  String shareMsg =  FlavorConfig.instance.variables["app_share_msg"];
 // static  String appLogo =  FlavorConfig.instance.variables["appLogo"];
  static  String path =  FlavorConfig.instance.variables["asset_path"];
  static  bool showNetworkLogs =  FlavorConfig.instance.variables["showNetworkLogs"];

  //splash details
  static  Map<String,dynamic> appThemeData = FlavorConfig.instance.variables["app_theme"];
  static  Map<String,dynamic> splashData = FlavorConfig.instance.variables["splash_screen_data"];
  static  Map<String,dynamic> loginData = FlavorConfig.instance.variables["login_screen_data"];
  static  Map<String,dynamic> homeData = FlavorConfig.instance.variables["home_screen_data"];

  //List Data
  static  Map<String,dynamic> flightData = FlavorConfig.instance.variables["flight_screen_data"];
  static  Map<String,dynamic> trData = FlavorConfig.instance.variables["tr_screen_data"];
  static  Map<String,dynamic> teData = FlavorConfig.instance.variables["te_screen_data"];
  static  Map<String,dynamic> geData = FlavorConfig.instance.variables["ge_screen_data"];
  static  Map<String,dynamic> aeData = FlavorConfig.instance.variables["ae_screen_data"];
  static  Map<String,dynamic> upcomingTRData = FlavorConfig.instance.variables["upcoming_tr_screen_data"];


  static  Map<String,dynamic> profileData = FlavorConfig.instance.variables["profile_screen_data"];
  static  Map<String,dynamic> policyData = FlavorConfig.instance.variables["policy_screen_data"];
  static  Map<String,dynamic> walletData = FlavorConfig.instance.variables["wallet_screen_data"];
  static  Map<String,dynamic> imageData = FlavorConfig.instance.variables["image_screen_data"];
  static  Map<String,dynamic> pdfData = FlavorConfig.instance.variables["pdf_screen_data"];
  static  Map<String,dynamic> cityData = FlavorConfig.instance.variables["city_screen_data"];
  static  Map<String,dynamic> employeeData = FlavorConfig.instance.variables["employee_screen_data"];
  static  Map<String,dynamic> countryData = FlavorConfig.instance.variables["country_screen_data"];

  //Dialogs
  static  Map<String,dynamic> accomTypeData = FlavorConfig.instance.variables["accom_type_screen_data"];
  static  Map<String,dynamic> miscTypeData = FlavorConfig.instance.variables["misc_type_screen_data"];
  static  Map<String,dynamic> travelModeData = FlavorConfig.instance.variables["travel_mode_screen_data"];
  static  Map<String,dynamic> currencyData = FlavorConfig.instance.variables["currency_screen_data"];
  static  Map<String,dynamic> fareClassData = FlavorConfig.instance.variables["fare_class_screen_data"];
  static  Map<String,dynamic> travelPurposeData = FlavorConfig.instance.variables["travel_purpose_screen_data"];
  static  Map<String,dynamic> uploadData = FlavorConfig.instance.variables["upload_screen_data"];
  static  Map<String,dynamic> yesNoData = FlavorConfig.instance.variables["dialog_yes_no_data"];
  static  Map<String,dynamic> tripTypeData = FlavorConfig.instance.variables["dialog_trip_type_data"];
  static  Map<String,dynamic> cashData = FlavorConfig.instance.variables["dialog_cash_data"];
  static  Map<String,dynamic> expensePickerData = FlavorConfig.instance.variables["dialog_expense_picker_data"];
  static  Map<String,dynamic> groupPickerData = FlavorConfig.instance.variables["dialog_group_picker_data"];


  //bottomsheet
  static  Map<String,dynamic> sortData = FlavorConfig.instance.variables["bottomsheet_sort_data"];
  static  Map<String,dynamic> filterData = FlavorConfig.instance.variables["bottomsheet_filter_data"];


  //Create TR Data
  static  Map<String,dynamic> trCreateData = FlavorConfig.instance.variables["tr_create_data"];
  static  Map<String,dynamic> trViewData = FlavorConfig.instance.variables["tr_view_data"];
  static  Map<String,dynamic> trAddProcessed = FlavorConfig.instance.variables["tr_processed_add_data"];
  static  Map<String,dynamic> trAddTraveller = FlavorConfig.instance.variables["tr_traveller_data"];

  //Create GE Data
  static  Map<String,dynamic> geCreateData = FlavorConfig.instance.variables["ge_create_data"];
  static  Map<String,dynamic> accomCreateData = FlavorConfig.instance.variables["accom_create_data"];
  static  Map<String,dynamic> conveyanceCreateData = FlavorConfig.instance.variables["conveyance_create_data"];
  static  Map<String,dynamic> miscCreateData = FlavorConfig.instance.variables["misc_create_data"];
  static  Map<String,dynamic> addGroupAccom = FlavorConfig.instance.variables["group_accom_data"];

  //Create TE Data
  static  Map<String,dynamic> teCreateData = FlavorConfig.instance.variables["te_create_data"];
  static  Map<String,dynamic> teAddVisitData = FlavorConfig.instance.variables["te_visit_add_data"];
  static  Map<String,dynamic> teAccomAddData = FlavorConfig.instance.variables["te_accom_add_data"];
  static  Map<String,dynamic> teTicketAddData = FlavorConfig.instance.variables["te_ticket_add_data"];
  static  Map<String,dynamic> teMiscAddData = FlavorConfig.instance.variables["te_misc_add_data"];
  static  Map<String,dynamic> teConvAddData = FlavorConfig.instance.variables["te_conveyance_add_data"];

//  static  String flavour =  FlavorConfig.instance.name.toString();
//  static  bool enableTesting =  FlavorConfig.instance.variables["enableUnitTesting"];
}