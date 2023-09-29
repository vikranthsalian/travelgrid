import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelex/common/utils/validators.dart';

class ItineraryFormBloc extends FormBloc<String, String> {

  final checkInDate =  TextFieldBloc(validators: [emptyValidator],initialValue: "00:00");
  final checkInTime =  TextFieldBloc(validators: [emptyValidator],initialValue: "00:00");
  final origin =  TextFieldBloc(validators: [emptyValidator]);
  final destination =  TextFieldBloc(validators: [emptyValidator]);

  final fareClass =  TextFieldBloc(validators: [emptyValidator]);
  final travelMode =  TextFieldBloc(validators: [emptyValidator]);
  final travelModeID =  SelectFieldBloc();

  final swByCompany = BooleanFieldBloc(initialValue: false);
  final swByCompanyID = SelectFieldBloc(initialValue: false);

  final tfAmount = TextFieldBloc();
  final tfPNR= TextFieldBloc();
  final tfTicket= TextFieldBloc();

  final showError = SelectFieldBloc<bool, dynamic>(initialValue: false);

  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  ItineraryFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

      if(data.isNotEmpty){
        tfPNR.addValidators(Validators().getValidators(data['text_field_pnr']));
        tfTicket.addValidators(Validators().getValidators(data['text_field_ticket']));
        tfAmount.addValidators(Validators().getValidators(data['text_field_amount']));
      }

    addFieldBlocs(fieldBlocs: [
      checkInDate,
      checkInTime,
      origin,
      destination,
      travelMode,
      fareClass,
      swByCompany,
      tfPNR,
      tfTicket,
      tfAmount,
    ]);

      swByCompany.onValueChanges(onData: (previous, current) async* {
        if(current.value == true) {
          tfPNR.updateValue("nill");
          tfTicket.updateValue("nill");
          tfAmount.updateValue("nill");
        } else {
          tfPNR.updateValue("");
          tfTicket.updateValue("");
          tfAmount.updateValue("");

        }
      });

  }

  @override
  FutureOr<void> onSubmitting() async {
    Map<String,dynamic> save ={
      "leavingFrom": origin.value,
      "goingTo": destination.value,
      "startDate": checkInDate.value,
      "startTime": checkInTime.value,
      "byCompany":swByCompany.value ? 42 : 41,
      "fareClass": fareClass.valueToInt,
      "travelMode": travelMode.value,
      "price":tfAmount.value == "nill" ? null: tfAmount.valueToDouble,
      "pnr": tfAmount.value == "nill" ? "":tfPNR.value,
      "ticket":tfAmount.value == "nill" ? "": tfTicket.value,
    };

    emitSuccess(successResponse: jsonEncode(save));

  }

}