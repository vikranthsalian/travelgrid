import 'package:travelgrid/data/datsources/general_expense_list.dart';
import 'package:travelgrid/data/datsources/login_response.dart';

abstract class LoginAPIAbstract {
  Future<MetaLoginResponse> callLogin(input);
}

abstract class GeAPIAbstract {
  Future<GEListResponse> callList();
}