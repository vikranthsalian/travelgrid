import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/validators.dart';
import 'package:travelgrid/domain/usecases/login_usecase.dart';

class LoginFormBloc extends FormBloc<String, String> {
  final tfUsername = TextFieldBloc();
  final tfPassword = TextFieldBloc();


  LoginFormBloc(Map<String, dynamic> data):super(autoValidate: true) {
    tfUsername.addValidators(Validators().getValidators(data['text_field_username']));
    tfPassword.addValidators(Validators().getValidators(data['text_field_password']));



    addFieldBlocs(fieldBlocs: [
      tfUsername,
      tfPassword,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    emitFailure(failureResponse:" e.toString()" );
    await Injector.resolve<LoginUseCase>()
        .callApi(
            {
              "loginId" :tfUsername.value,
              "password" :tfPassword.value,
              "domain" :'172.104.189.54',
              "enterpriseName" :'NH',
            }
        );
   // emitSuccess(canSubmitAgain: true);


   // http://172.104.189.54:8080/tems/rest/ma/authenticate?loginId=cm05&password=Test123#&domain=172.104.189.54&enterpriseName=NH

    // try {
    //   String data ="<Parameter><ProcessID>1001</ProcessID><MobileNo>${tfMobileNo.value}</MobileNo></Parameter>";
    //   jsonString = await CommonFunctions.handleApiCall(data);
    //   MobileValidBaseResponse mobileValidBaseResponse = MobileValidBaseResponse.fromJson(jsonDecode(jsonString));
    //   if((mobileValidBaseResponse.Result?.ErrorNo ?? 0) != "0") {
    //     throw "invalid";
    //   }
    //   PreferenceConfig.setString(PreferenceConstants.customerID, mobileValidBaseResponse.Result!.CustomerID ?? "");
    //   PreferenceConfig.setString(PreferenceConstants.mobileNumber, tfMobileNo.value);
    //   emitSuccess(successResponse: mobileValidBaseResponse.Result!.Message ?? "Valid");
    // } catch(e) {
    //   Response response = Response.fromJson(jsonDecode(jsonString));
    //   emitFailure(failureResponse: response.result?.message );
    // }
  }



}