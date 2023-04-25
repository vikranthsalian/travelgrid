import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';


class TravellerFormBloc extends FormBloc<String, String> {

  final gender =  TextFieldBloc(validators: [emptyValidator]);
  final fname =  TextFieldBloc(validators: [emptyValidator]);
  final lname =  TextFieldBloc(validators: [emptyValidator]);
  final contact =  TextFieldBloc(validators: [emptyValidator]);
  final email =  TextFieldBloc(validators: [emptyValidator]);
  final address =  TextFieldBloc(validators: [emptyValidator]);
  final pincode =  TextFieldBloc(validators: [emptyValidator]);

  final cityName =  TextFieldBloc(validators: [emptyValidator]);
  final cityID =  TextFieldBloc(validators: [emptyValidator]);


  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }


  TravellerFormBloc():super(autoValidate: true) {

    addFieldBlocs(fieldBlocs: [
      gender,
      fname,
      lname,
      contact,
      email,
      address,
      pincode,
      cityName,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {

    Map<String,dynamic> saveVisitData = {
      'employeeType': "Non-Employee",
      'email': this.email.value,
      'name': this.fname.value+" "+lname.value,
      'gender': this.gender.value,
      'location': this.address.value,
    };
     emitSuccess(successResponse: jsonEncode(saveVisitData));

  }



}