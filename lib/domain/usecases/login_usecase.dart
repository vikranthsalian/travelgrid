import 'package:travelex/data/datasources/login_response.dart';
import 'package:travelex/domain/repo_abstract/api_abstract.dart';

class LoginUseCase {
  final LoginAPIAbstract apiAbstract;
  LoginUseCase(this.apiAbstract);
  Future<MetaLoginResponse> callApi(input) async => apiAbstract.callLogin(input);
}