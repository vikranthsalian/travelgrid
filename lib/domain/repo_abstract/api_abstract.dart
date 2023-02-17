import 'package:travelgrid/data/datsources/accom_type_list.dart';
import 'package:travelgrid/data/datsources/approver_list.dart';
import 'package:travelgrid/data/datsources/cities_list.dart';
import 'package:travelgrid/data/datsources/ge_summary_response.dart';
import 'package:travelgrid/data/datsources/general_expense_list.dart';
import 'package:travelgrid/data/datsources/lat_long_distance_model.dart';
import 'package:travelgrid/data/datsources/login_response.dart';
import 'package:travelgrid/data/datsources/misc_type_list.dart';
import 'package:travelgrid/data/datsources/travel_mode_list.dart';
import 'package:travelgrid/data/models/success_model.dart';

abstract class LoginAPIAbstract {
  Future<MetaLoginResponse> callLogin(input);
}

abstract class GeAPIAbstract {
  Future<GEListResponse> callList();
  Future<GESummaryResponse> getGE(id);
  Future<SuccessModel> createGE(data,body);
}
abstract class CommonAPIAbstract {
  Future<MetaCityListResponse> getCities(countryCode,tripType);

  Future<MetaAccomTypeListResponse> getAccomTypesList();

  Future<MetaTravelModeListResponse> getTravelModeList();

  Future<MetaMiscTypeListResponse> getMiscTypeList();

  Future<MetaApproverListResponse> getApproverTypeList();

  Future<SuccessModel> uploadFile(formData,type);

  Future<MetaLatLongDistanceModel> getDistance(origin,dest);

}
