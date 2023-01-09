import 'package:travelgrid/data/remote/remote_datasource.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class LoginRepository extends LoginAPIAbstract {
  final APIRemoteDatasource apiRemoteDatasource;

  LoginRepository({
    required this.apiRemoteDatasource,
  });


  @override
  Future<String> callLogin(input) async {
      print("inside LoginRepository");
      return await apiRemoteDatasource.loginRequest(input,"authenticate");
  }


}