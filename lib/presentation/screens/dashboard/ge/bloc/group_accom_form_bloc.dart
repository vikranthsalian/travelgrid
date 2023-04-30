import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class GroupAccomFormBloc extends FormBloc<String, String> {

  final checkInDate =  TextFieldBloc(validators: [emptyValidator]);
  final checkInTime =  TextFieldBloc(validators: [emptyValidator]);
  final checkOutDate =  TextFieldBloc(validators: [emptyValidator]);
  final checkOutTime =  TextFieldBloc(validators: [emptyValidator]);
  final empCode =  SelectFieldBloc(initialValue: "");
  final empName =  SelectFieldBloc(initialValue: "");


  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  GroupAccomFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

    addFieldBlocs(fieldBlocs: [
      checkInDate,
      checkInTime,
      checkOutDate,
      checkOutTime,
      empCode,
      empName,
    ]);

  }

  @override
  FutureOr<void> onSubmitting() async {

  try {
  Map<String, dynamic> saveAccomMap = {
    "checkInDate": checkInDate.value,
    "checkInTime": checkInTime.value,

    "checkOutDate": checkOutDate.value,
    "checkOutTime": checkOutTime.value,
    "employeeCode": empCode.value,
    "employeeName": empName.value,

  };
  emitSuccess(successResponse: jsonEncode(saveAccomMap));
  }catch(e){
    print(e);
  }
  }

}