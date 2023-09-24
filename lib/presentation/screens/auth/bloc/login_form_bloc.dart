import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/validators.dart';
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/domain/usecases/login_usecase.dart';

class LoginFormBloc extends FormBloc<String, String> {
  final tfUsername = TextFieldBloc();
  final tfPassword = TextFieldBloc();


  LoginFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

      if(data.isNotEmpty){
        tfUsername.addValidators(Validators().getValidators(data['text_field_username']));
        tfPassword.addValidators(Validators().getValidators(data['text_field_password']));

      }

    addFieldBlocs(fieldBlocs: [
      tfUsername,
      tfPassword,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {

    MetaLoginResponse? response = await Injector.resolve<LoginUseCase>()
        .callApi(
            {
              "loginId" :tfUsername.value,
              "password" :tfPassword.value,
              "domain" :FlavourConstants.domain,
              "enterpriseName" :FlavourConstants.enterpriseName,
            }
        );
   if(response!=null && response.status==true){
     emitSuccess(successResponse: jsonEncode(response));
   }else{
     emitSuccess(successResponse: "",canSubmitAgain: true);
   }

  }



}