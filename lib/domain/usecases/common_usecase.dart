import 'package:travelgrid/data/datsources/cities_list.dart';
import 'package:travelgrid/data/datsources/login_response.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class CommonUseCase {
  final CommonAPIAbstract apiAbstract;
  CommonUseCase(this.apiAbstract);
  Future<MetaCityListResponse> getCities(countryCode,tripType) async => apiAbstract.getCities(countryCode,tripType);
}