import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/remote/remote_datasource.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class LoginRepository extends LoginAPIAbstract {
  final APIRemoteDatasource apiRemoteDatasource;

  LoginRepository({
    required this.apiRemoteDatasource,
  });


  @override
  Future<MetaLoginResponse> callLogin(input) async {

    var response = await apiRemoteDatasource.loginRequest(input,"authenticate");
    if(response!=null) {

        MetaLoginResponse modelResponse = MetaLoginResponse.fromJson(response);
        return modelResponse;

    }

    return MetaLoginResponse(status: false);
  }


}