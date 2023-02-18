import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class LoginUseCase {
  final LoginAPIAbstract apiAbstract;
  LoginUseCase(this.apiAbstract);
  Future<MetaLoginResponse> callApi(input) async => apiAbstract.callLogin(input);
}