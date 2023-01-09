import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';

class LoginUseCase {
  final LoginAPIAbstract apiAbstract;
  LoginUseCase(this.apiAbstract);
  Future<dynamic> callApi(input) async => apiAbstract.callLogin(input);
}