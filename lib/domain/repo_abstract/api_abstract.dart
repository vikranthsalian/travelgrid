import 'package:travelgrid/data/datasources/accom_type_list.dart';
import 'package:travelgrid/data/datasources/approver_list.dart';
import 'package:travelgrid/data/datasources/cities_list.dart';
import 'package:travelgrid/data/datasources/currency_list.dart';
import 'package:travelgrid/data/datasources/fare_class_list.dart';
import 'package:travelgrid/data/datasources/ge_summary_response.dart';
import 'package:travelgrid/data/datasources/list/ge_list_response.dart';
import 'package:travelgrid/data/datasources/lat_long_distance_model.dart';
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/datasources/misc_type_list.dart';
import 'package:travelgrid/data/datasources/te_approval_list.dart';
import 'package:travelgrid/data/datasources/te_summary_response.dart';
import 'package:travelgrid/data/datasources/list/tr_list_response.dart';
import 'package:travelgrid/data/datasources/list/te_list_response.dart';
import 'package:travelgrid/data/datasources/tr_summary_response.dart';
import 'package:travelgrid/data/datasources/travel_mode_list.dart';
import 'package:travelgrid/data/datasources/travel_purpose_list.dart';
import 'package:travelgrid/data/models/success_model.dart';

abstract class LoginAPIAbstract {
  Future<MetaLoginResponse> callLogin(input);
}

abstract class TrAPIAbstract {
  Future<TRListResponse> callList();
  Future<TRSummaryResponse> getTR(id);
  Future<SuccessModel> createTR(data,body);
  Future<SuccessModel> approveTR(id,comment);
}


abstract class GeAPIAbstract {
  Future<GEListResponse> callList();
  Future<GESummaryResponse> getGE(id);
  Future<SuccessModel> createGE(data,body);
  Future<SuccessModel> approveGE(id,comment);
}

abstract class TeAPIAbstract {
  Future<TEListResponse> callList();
  Future<TESummaryResponse> getTE(id);
  Future<SuccessModel> createTE(data,body);
  Future<SuccessModel> approveTE(id,comment);
}

abstract class AeAPIAbstract {
  Future<TRListResponse> callTRList(path);
  Future<GEListResponse> callGEList(path);
  Future<TEApprovalList> callTEList(path);
}


abstract class CommonAPIAbstract {
  Future<MetaCityListResponse> getCities(countryCode,tripType);

  Future<MetaCityListResponse> getCountriesList();

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
