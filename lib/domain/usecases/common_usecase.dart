import 'package:travelgrid/data/datasources/accom_type_list.dart';
import 'package:travelgrid/data/datasources/approver_list.dart';
import 'package:travelgrid/data/datasources/cities_list.dart';
import 'package:travelgrid/data/datasources/fare_class_list.dart';
import 'package:travelgrid/data/datasources/lat_long_distance_model.dart';
import 'package:travelgrid/data/datasources/misc_type_list.dart';
import 'package:travelgrid/data/datasources/travel_mode_list.dart';
import 'package:travelgrid/data/datasources/travel_purpose_list.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class CommonUseCase {
  final CommonAPIAbstract apiAbstract;
  CommonUseCase(this.apiAbstract);
  Future<MetaCityListResponse> getCities(countryCode,tripType) async => apiAbstract.getCities(countryCode,tripType);

  Future<MetaAccomTypeListResponse> getAccomTypesList() async => apiAbstract.getAccomTypesList();

  Future<MetaFareClassListResponse> getFareClassList(mode) async => apiAbstract.getFareClassList(mode);

  Future<MetaTravelModeListResponse> getTravelModeList() async => apiAbstract.getTravelModeList();

  Future<MetaMiscTypeListResponse> getMiscTypeList() async => apiAbstract.getMiscTypeList();

  Future<MetaTravelPurposeListResponse> getTravelPurposeList() async => apiAbstract.getTravelPurposeList();

  Future<MetaApproverListResponse> getApproverTypeList() async => apiAbstract.getApproverTypeList();

  Future<SuccessModel> uploadFile(formData,type) async => apiAbstract.uploadFile(formData,type);

  Future<MetaLatLongDistanceModel> getDistance(origin,dest) async => apiAbstract.getDistance(origin,dest);
}