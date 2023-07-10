import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/utils/validators.dart';

class RoundItineraryFormBloc extends FormBloc<String, String> {

  final checkInDate =  TextFieldBloc(validators: [emptyValidator]);
  final checkInTime =  TextFieldBloc(validators: [emptyValidator]);
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





  final checkInDate2 =  TextFieldBloc(validators: [emptyValidator]);
  final checkInTime2 =  TextFieldBloc(validators: [emptyValidator]);
  final origin2 =  TextFieldBloc(validators: [emptyValidator]);
  final destination2=  TextFieldBloc(validators: [emptyValidator]);

  final fareClass2 =  TextFieldBloc(validators: [emptyValidator]);
  final travelMode2 =  TextFieldBloc(validators: [emptyValidator]);
  final travelModeID2 =  SelectFieldBloc();

  final swByCompany2 = BooleanFieldBloc(initialValue: false);
  final swByCompanyID2 = SelectFieldBloc(initialValue: false);

  final tfAmount2 = TextFieldBloc();
  final tfPNR2= TextFieldBloc();
  final tfTicket2= TextFieldBloc();
  final showError2 = SelectFieldBloc<bool, dynamic>(initialValue: false);


  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  RoundItineraryFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

    if(data.isNotEmpty){
      tfPNR.addValidators(Validators().getValidators(data['text_field_pnr']));
      tfTicket.addValidators(Validators().getValidators(data['text_field_ticket']));
      tfAmount.addValidators(Validators().getValidators(data['text_field_amount']));

      tfPNR2.addValidators(Validators().getValidators(data['text_field_pnr']));
      tfTicket2.addValidators(Validators().getValidators(data['text_field_ticket']));
      tfAmount2.addValidators(Validators().getValidators(data['text_field_amount']));
      tfAmount2.addValidators([]);
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

      checkInDate2,
      checkInTime2,
      origin2,
      destination2,
      travelMode2,
      fareClass2,
      swByCompany2,
      tfPNR2,
      tfTicket2,
      tfAmount2,
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

    swByCompany2.onValueChanges(onData: (previous, current) async* {
      if(current.value == true) {
        tfPNR2.updateValue("nill");
        tfTicket2.updateValue("nill");
        tfAmount2.updateValue("nill");
      } else {
        tfPNR2.updateValue("");
        tfTicket2.updateValue("");
        tfAmount2.updateValue("");

      }
    });

  }

  @override
  FutureOr<void> onSubmitting() async {
    Map<String,dynamic> save = {
      "pair1": {
        "leavingFrom": origin.value,
        "goingTo": destination.value,
        "startDate": checkInDate.value,
        "startTime": checkInTime.value,
        "byCompany": swByCompany.value ? 42 : 41,
        "fareClass": fareClass.valueToInt,
        "travelMode": travelMode.value,
        "price": tfAmount.value == "nill" ? 0.0 : tfAmount.valueToDouble,
        "pnr": tfPNR.value == "nill" ? "" : tfPNR.value,
        "ticket": tfTicket.value == "nill" ? "" : tfTicket.value,
      },
      "pair2": {
        "leavingFrom": origin2.value,
        "goingTo": destination2.value,
        "startDate": checkInDate2.value,
        "startTime": checkInTime2.value,
        "byCompany": swByCompany2.value ? 42 : 41,
        "fareClass": fareClass2.valueToInt,
        "travelMode": travelMode2.value,
        "price": tfAmount2.value == "nill" ? 0.0 : tfAmount2.valueToDouble,
        "pnr": tfPNR2.value == "nill" ? "" : tfPNR2.value,
        "ticket": tfTicket2.value == "nill" ? "" : tfTicket2.value,
      }
    };

    emitSuccess(successResponse: jsonEncode(save));

  }

}