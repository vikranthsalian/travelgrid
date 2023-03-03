import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/common/utils/validators.dart';

class ProcessedTrFormBloc extends FormBloc<String, String> {

  final selectWithBill = SelectFieldBloc<String, dynamic>();
  final checkInDate =  TextFieldBloc(validators: [emptyValidator]);
  final checkInTime =  TextFieldBloc(validators: [emptyValidator]);
  final origin =  TextFieldBloc(validators: [emptyValidator]);
  final destination =  TextFieldBloc(validators: [emptyValidator]);

  final fareClass =  TextFieldBloc(validators: [emptyValidator]);
  final travelMode =  TextFieldBloc(validators: [emptyValidator]);
  final travelModeID =  SelectFieldBloc();
  final segmentType =  TextFieldBloc(validators: [emptyValidator]);


  final swByCompany = BooleanFieldBloc(initialValue: false);

  final tfAmount = TextFieldBloc();
  final tfPNR= TextFieldBloc();
  final tfTicket= TextFieldBloc();



  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  ProcessedTrFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

      if(data.isNotEmpty){
        tfPNR.addValidators(Validators().getValidators(data['text_field_pnr']));
        tfTicket.addValidators(Validators().getValidators(data['text_field_ticket']));
        tfAmount.addValidators(Validators().getValidators(data['text_field_amount']));
      }

    addFieldBlocs(fieldBlocs: [
      segmentType,
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

  }

  @override
  FutureOr<void> onSubmitting() async {
    Map<String,dynamic> save ={
    "cash":[{
        "totalCashAmount":500.0,
        "violation":"",
        "currentStatus":"Pending"
      }],
    "segmentType" : segmentType.value,
    "pair":{
        "leavingFrom": origin.value,
        "goingTo": destination.value,
        "startDate": checkInDate.value,
        "startTime": checkInTime.value,
        "byCompany":swByCompany.value ? 42 : 41,
        "fareClass": fareClass.valueToInt,
        "travelMode": travelMode.value,
        "price": tfAmount.valueToInt,
        "pnr": tfPNR.value,
        "ticket": tfTicket.value,
    }
    };

    emitSuccess(successResponse: jsonEncode(save));

  }

}