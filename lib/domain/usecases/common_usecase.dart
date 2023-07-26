import 'package:travelgrid/data/datasources/others/accom_type_list.dart';
import 'package:travelgrid/data/datasources/list/approver_list.dart';
import 'package:travelgrid/data/datasources/others/cities_list.dart';
import 'package:travelgrid/data/datasources/others/countries_list.dart';
import 'package:travelgrid/data/datasources/others/currency_list.dart';
import 'package:travelgrid/data/datasources/others/employee_list.dart';
import 'package:travelgrid/data/datasources/others/fare_class_list.dart';
import 'package:travelgrid/data/datasources/others/flight_list.dart';
import 'package:travelgrid/data/datasources/others/lat_long_distance_model.dart';
import 'package:travelgrid/data/datasources/others/misc_type_list.dart';
import 'package:travelgrid/data/datasources/others/non_employee_list.dart';
import 'package:travelgrid/data/datasources/others/travel_mode_list.dart';
import 'package:travelgrid/data/datasources/others/travel_purpose_list.dart';
import 'package:travelgrid/data/models/ge/ge_misc_model.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class CommonUseCase {
  final CommonAPIAbstract apiAbstract;
  CommonUseCase(this.apiAbstract);
  Future<MetaCityListResponse> getCities(countryCode,tripType) async => apiAbstract.getCities(countryCode,tripType);

  Future<MetaCountryListResponse> getCountriesList() async => apiAbstract.getCountriesList();

  Future<MetaEmployeeListResponse> getEmployeesList() async => apiAbstract.getEmployeesList();

  Future<SuccessModel> logOut() async => apiAbstract.logOut();

  Future<MetaNonEmployeeListResponse> getNonEmployeesList() async => apiAbstract.getNonEmployeesList();

  Future<MetaAccomTypeListResponse> getAccomTypesList() async => apiAbstract.getAccomTypesList();

  Future<MetaFlightListResponse> getFlightList(data) async => apiAbstract.getFlightList(data);

  Future<MetaCurrencyListResponse> getCurrencyList() async => apiAbstract.getCurrencyList();

  Future<SuccessModel> getExchangeRate(currency,date) async => apiAbstract.getExchangeRate(currency,date);

  Future<MetaFareClassListResponse> getFareClassList(mode) async => apiAbstract.getFareClassList(mode);

  Future<MetaTravelModeListResponse> getTravelModeList() async => apiAbstract.getTravelModeList();

  Future<MetaMiscTypeListResponse> getMiscTypeList() async => apiAbstract.getMiscTypeList();

  Future<MetaTravelPurposeListResponse> getTravelPurposeList() async => apiAbstract.getTravelPurposeList();

  Future<MetaApproverListResponse> getApproverTypeList() async => apiAbstract.getApproverTypeList();

  Future<SuccessModel> uploadFile(formData,type) async => apiAbstract.uploadFile(formData,type);

  Future<MetaLatLongDistanceModel> getDistance(origin,dest) async => apiAbstract.getDistance(origin,dest);

  Future<SuccessModel> getValidations(model) async => apiAbstract.getValidations(model);
}