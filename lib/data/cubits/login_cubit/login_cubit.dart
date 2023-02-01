import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:travelgrid/data/datsources/login_response.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoggedIn(loginResponse: MetaLoginResponse()));

  setLoginResponse(MetaLoginResponse loginResponse) {
    if(state is LoggedIn) {
      emit(LoggedIn(loginResponse: loginResponse));
    }
  }

  String? getLoginID() {
    if(state is LoggedIn) {
      final current = state as LoggedIn;
      return current.loginResponse.data!.employeecode;
    }
    return "";
  }

 String? getLoginToken() {
    if(state is LoggedIn) {
      final current = state as LoggedIn;
      return current.loginResponse.token;
    }
    return "no";
  }

  MetaLoginResponse getLoginResponse() {
    MetaLoginResponse loginResponse = MetaLoginResponse();
    if(state is LoggedIn) {
      final current = state as LoggedIn;
      return current.loginResponse;
    }
    return loginResponse;
  }

}
