import 'package:travelgrid/data/datsources/login_response.dart';

abstract class LoginAPIAbstract {
  Future<MetaLoginResponse> callLogin(input);
}