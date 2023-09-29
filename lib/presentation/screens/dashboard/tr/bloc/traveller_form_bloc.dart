import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelex/common/utils/validators.dart';


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


  TravellerFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

    if(data.isNotEmpty){

      fname.addValidators(Validators().getValidators(data['text_field_fname']));
      lname.addValidators(Validators().getValidators(data['text_field_lname']));
      contact.addValidators(Validators().getValidators(data['text_field_contact']));

      email.addValidators(Validators().getValidators(data['text_field_email']));

      address.addValidators(Validators().getValidators(data['text_field_address']));
      pincode.addValidators(Validators().getValidators(data['text_field_pincode']));
    }

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
      'employeeName': this.fname.value+" "+lname.value,
      'gender': this.gender.value,
      'location': this.address.value,
      'mobileNumber': this.contact.value,
      'primary': false,
    };
     emitSuccess(successResponse: jsonEncode(saveVisitData));

  }



}