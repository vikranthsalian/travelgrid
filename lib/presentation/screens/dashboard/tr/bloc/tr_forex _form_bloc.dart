import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ForexFormBloc extends FormBloc<String, String> {

  final currencyID =  TextFieldBloc(validators: [emptyValidator]);

  final tfCash = TextFieldBloc(validators: [emptyValidator]);
  final tfCard= TextFieldBloc(validators: [emptyValidator]);
  final tfForex= TextFieldBloc(validators: [emptyValidator]);


  final tfComment= TextFieldBloc();




  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  ForexFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

    addFieldBlocs(fieldBlocs: [
      currencyID,
      tfCash,
      tfCard,
      tfComment,
      tfForex
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {
    try {
      Map<String, dynamic> save = {
        "cash": tfCash.valueToInt,
        "card": tfCard.valueToInt,
        "currency": currencyID.valueToInt,
        "violationMessage": "",
        "totalForexAmount": tfCash.valueToInt! + tfCash.valueToInt!,
        "address": tfComment.value,
      };

      emitSuccess(successResponse: jsonEncode(save));
    }catch(e){
      print(e);
    }

  }

}