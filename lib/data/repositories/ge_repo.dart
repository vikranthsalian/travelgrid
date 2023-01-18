import 'package:travelgrid/data/datsources/general_expense_list.dart';
import 'package:travelgrid/data/datsources/login_response.dart';
import 'package:travelgrid/data/remote/remote_datasource.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class GeRepository extends GeAPIAbstract {
  final APIRemoteDatasource apiRemoteDatasource;

  GeRepository({
    required this.apiRemoteDatasource,
  });


  @override
  Future<GEListResponse> callList() async {

    var response = await apiRemoteDatasource.getGeList("ge/gelist");
    if(response!=null) {
      GEListResponse modelResponse = GEListResponse.fromJson(response);
      return modelResponse;
    }

      return GEListResponse(status: false);
  }


}