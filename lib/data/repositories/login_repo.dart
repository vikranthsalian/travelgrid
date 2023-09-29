import 'package:travelex/data/datasources/login_response.dart';
import 'package:travelex/data/remote/remote_datasource.dart';
import 'package:travelex/domain/repo_abstract/api_abstract.dart';

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