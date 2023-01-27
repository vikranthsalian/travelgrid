import 'package:travelgrid/data/datsources/cities_list.dart';
import 'package:travelgrid/data/datsources/login_response.dart';
import 'package:travelgrid/data/remote/remote_datasource.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class CommonRepository extends CommonAPIAbstract {
  final APIRemoteDatasource apiRemoteDatasource;

  CommonRepository({
    required this.apiRemoteDatasource,
  });


  @override
  Future<MetaCityListResponse> getCities(countryCode,tripType) async {

    Map data= {
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


}