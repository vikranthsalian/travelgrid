import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/utils/validators.dart';

class VisaFormBloc extends FormBloc<String, String> {

  final entriesID =  TextFieldBloc(validators: [emptyValidator]);
  final visaID =  TextFieldBloc(validators: [emptyValidator]);

  final tfDays = TextFieldBloc();
  final tfCountry= SelectFieldBloc<String,dynamic>(initialValue: "");




  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  VisaFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

      if(data.isNotEmpty){
        tfDays.addValidators(Validators().getValidators(data['text_field_days']));
      }

    addFieldBlocs(fieldBlocs: [
      tfDays,
      tfCountry,
      entriesID,
      visaID
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    try {
      Map<String, dynamic> save = {
        "serviceType": 139,
        "visitingCountry": tfCountry.value,
        "durationOfStay": tfDays.valueToInt,
        "visaRequirement": "Yes",
        "numberOfEntries": entriesID.valueToInt,
        "visaType": visaID.value,
      };

      emitSuccess(successResponse: jsonEncode(save));
    }catch(e){
      print(e);
    }

  }

}