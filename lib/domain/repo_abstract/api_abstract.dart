import 'package:travelgrid/data/datasources/list/tr_upcoming_response.dart';
import 'package:travelgrid/data/datasources/others/accom_type_list.dart';
import 'package:travelgrid/data/datasources/list/approver_list.dart';
import 'package:travelgrid/data/datasources/others/cities_list.dart';
import 'package:travelgrid/data/datasources/others/countries_list.dart';
import 'package:travelgrid/data/datasources/others/currency_list.dart';
import 'package:travelgrid/data/datasources/others/employee_list.dart';
import 'package:travelgrid/data/datasources/others/fare_class_list.dart';
import 'package:travelgrid/data/datasources/others/non_employee_list.dart';
import 'package:travelgrid/data/datasources/summary/ge_summary_response.dart';
import 'package:travelgrid/data/datasources/list/ge_list_response.dart';
import 'package:travelgrid/data/datasources/others/lat_long_distance_model.dart';
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/datasources/others/misc_type_list.dart';
import 'package:travelgrid/data/datasources/list/te_approval_list.dart';
import 'package:travelgrid/data/datasources/summary/te_summary_response.dart';
import 'package:travelgrid/data/datasources/list/tr_list_response.dart';
import 'package:travelgrid/data/datasources/list/te_list_response.dart';
import 'package:travelgrid/data/datasources/summary/tr_summary_response.dart';
import 'package:travelgrid/data/datasources/others/travel_mode_list.dart';
import 'package:travelgrid/data/datasources/others/travel_purpose_list.dart';
import 'package:travelgrid/data/models/success_model.dart';

abstract class LoginAPIAbstract {
  Future<MetaLoginResponse> callLogin(input);
}

abstract class TrAPIAbstract {
  Future<TRListResponse> callList();
  Future<MetaUpcomingTRResponse> upcomingApi();
  Future<TRSummaryResponse> getTR(id);
  Future<SuccessModel> createTR(data,body);
  Future<SuccessModel> updateTR(data,body);
  Future<SuccessModel> checkOverlapped(data);
  Future<SuccessModel> checkFireFareClassRule(data);
  Future<SuccessModel> approveTR(id,comment);
  Future<SuccessModel> rejectTR(id,comment);
  Future<SuccessModel> takeBackTR(data);
}


abstract class GeAPIAbstract {
  Future<GEListResponse> callList();
  Future<GESummaryResponse> getGE(id);
  Future<SuccessModel> createGE(data,body);
  Future<SuccessModel> takeBackGE(data);
  Future<SuccessModel> approveGE(id,comment);
  Future<SuccessModel> rejectGE(id,comment);
}

abstract class TeAPIAbstract {
  Future<TEListResponse> callList();
  Future<TESummaryResponse> getTE(id);
  Future<SuccessModel> createTE(data,body);
  Future<SuccessModel> takeBackTE(data);
  Future<SuccessModel> approveTE(id,comment);
  Future<SuccessModel> rejectTE(id,comment);
}

abstract class AeAPIAbstract {
  Future<TRListResponse> callTRList(path);
  Future<GEListResponse> callGEList(path);
  Future<TEApprovalList> callTEList(path);
}


abstract class CommonAPIAbstract {
  Future<MetaCityListResponse> getCities(countryCode,tripType);

  Future<MetaEmployeeListResponse> getEmployeesList();

  Future<SuccessModel> logOut();

  Future<MetaNonEmployeeListResponse> getNonEmployeesList();

  Future<MetaCountryListResponse> getCountriesList();

  Future<MetaAccomTypeListResponse> getAccomTypesList();

  Future<MetaCurrencyListResponse> getCurrencyList();

  Future<SuccessModel> getExchangeRate(currency,date);

  Future<MetaFareClassListResponse> getFareClassList(mode);

  Future<MetaTravelModeListResponse> getTravelModeList();

  Future<MetaMiscTypeListResponse> getMiscTypeList();

  Future<MetaTravelPurposeListResponse> getTravelPurposeList();

  Future<MetaApproverListResponse> getApproverTypeList();

  Future<SuccessModel> uploadFile(formData,type);

  Future<MetaLatLongDistanceModel> getDistance(origin,dest);

}
