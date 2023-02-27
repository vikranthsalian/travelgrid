import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/utils/validators.dart';


class VisitFormBloc extends FormBloc<String, String> {

  final checkInDate =  TextFieldBloc(validators: [emptyValidator]);
  final checkInTime =  TextFieldBloc(validators: [emptyValidator]);
  final checkOutDate =  TextFieldBloc(validators: [emptyValidator]);
  final checkOutTime =  TextFieldBloc(validators: [emptyValidator]);
  final cityName =  TextFieldBloc(validators: [emptyValidator]);
  final cityID =  TextFieldBloc(validators: [emptyValidator]);


  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }


  VisitFormBloc():super(autoValidate: true) {

    addFieldBlocs(fieldBlocs: [
      checkInDate,
      checkInTime,
      checkOutDate,
      checkOutTime,
      cityID,
      cityName,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {

    Map<String,dynamic> saveVisitData = {
      "evdStartDate": checkInDate.value,
      "evdEndDate": checkOutDate.value,
      "evdStartTime": checkInTime.value,
      "evdEndTime": checkOutTime.value,
      "city":cityID.value

    };
     emitSuccess(successResponse: jsonEncode(saveVisitData));

  }



}