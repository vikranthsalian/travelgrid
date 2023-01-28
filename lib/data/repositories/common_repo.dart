import 'package:travelgrid/data/datsources/accom_type_list.dart';
import 'package:travelgrid/data/datsources/cities_list.dart';
import 'package:travelgrid/data/datsources/login_response.dart';
import 'package:travelgrid/data/datsources/travel_mode_list.dart';
import 'package:travelgrid/data/remote/remote_datasource.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class CommonRepository extends CommonAPIAbstract {
  final APIRemoteDatasource apiRemoteDatasource;

  CommonRepository({
    required this.apiRemoteDatasource,
  });


  @override
  Future<MetaCityListResponse> getCities(countryCode,tripType) async {

    Map<String,dynamic> data= {
      "q":"ad",
      "tripType":tripType,
      "countryCode":countryCode,
    };

    var response = await apiRemoteDatasource.getAllCities("getCities",data);

    if(response!=null) {
      MetaCityListResponse modelResponse = MetaCityListResponse.fromJson(response);
      return modelResponse;
    }

      return MetaCityListResponse(status: false);
  }

  @override
  Future<MetaAccomTypeListResponse> getAccomTypesList() async {

    Map<String,dynamic> data= {};

    var response = await apiRemoteDatasource.getAccomTypes("getAccomodationType",data);

    if(response!=null) {
      MetaAccomTypeListResponse modelResponse = MetaAccomTypeListResponse.fromJson(response);
      return modelResponse;
    }

    return MetaAccomTypeListResponse(status: false);
  }

  @override
  Future<MetaTravelModeListResponse> getTravelModeList() async {

    Map<String,dynamic> data= {};

    var response = await apiRemoteDatasource.getAccomTypes("getModeOfTravel",data);

    if(response!=null) {
      MetaTravelModeListResponse modelResponse = MetaTravelModeListResponse.fromJson(response);
      return modelResponse;
    }

    return MetaTravelModeListResponse(status: false);
  }



}