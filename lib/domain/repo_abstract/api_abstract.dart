import 'package:travelgrid/data/datsources/accom_type_list.dart';
import 'package:travelgrid/data/datsources/cities_list.dart';
import 'package:travelgrid/data/datsources/general_expense_list.dart';
import 'package:travelgrid/data/datsources/login_response.dart';
import 'package:travelgrid/data/datsources/travel_mode_list.dart';

abstract class LoginAPIAbstract {
  Future<MetaLoginResponse> callLogin(input);
}

abstract class GeAPIAbstract {
  Future<GEListResponse> callList();
  Future<GEListResponse> getGE(id);
}
abstract class CommonAPIAbstract {
  Future<MetaCityListResponse> getCities(countryCode,tripType);

  Future<MetaAccomTypeListResponse> getAccomTypesList();

  Future<MetaTravelModeListResponse> getTravelModeList();

}
