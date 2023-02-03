import 'package:travelgrid/data/datsources/accom_type_list.dart';
import 'package:travelgrid/data/datsources/approver_list.dart';
import 'package:travelgrid/data/datsources/cities_list.dart';
import 'package:travelgrid/data/datsources/login_response.dart';
import 'package:travelgrid/data/datsources/misc_type_list.dart';
import 'package:travelgrid/data/datsources/travel_mode_list.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class CommonUseCase {
  final CommonAPIAbstract apiAbstract;
  CommonUseCase(this.apiAbstract);
  Future<MetaCityListResponse> getCities(countryCode,tripType) async => apiAbstract.getCities(countryCode,tripType);

  Future<MetaAccomTypeListResponse> getAccomTypesList() async => apiAbstract.getAccomTypesList();

  Future<MetaTravelModeListResponse> getTravelModeList() async => apiAbstract.getTravelModeList();

  Future<MetaMiscTypeListResponse> getMiscTypeList() async => apiAbstract.getMiscTypeList();

  Future<MetaApproverListResponse> getApproverTypeList() async => apiAbstract.getApproverTypeList();

  Future<SuccessModel> uploadFile(formData,type) async => apiAbstract.uploadFile(formData,type);
}