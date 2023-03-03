import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class DeliveryTrFormBloc extends FormBloc<String, String> {

  final noteAgent = TextFieldBloc(validators: [emptyValidator]);
  final noteApprover = TextFieldBloc(validators: [emptyValidator]);
  final voucherPath = TextFieldBloc();

  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  DeliveryTrFormBloc(Map<String, dynamic> data):super(autoValidate: true) {


    addFieldBlocs(fieldBlocs: [
      noteAgent,
      noteApprover,
      voucherPath,
    ]);

  }

  @override
  FutureOr<void> onSubmitting() async {
    Map<String,dynamic> map = {
    "comments": noteApprover.value,
    "commentToAgent": noteAgent.value,
    "uploadPath": voucherPath.value,
    };


    emitSuccess(successResponse: jsonEncode(map));

  }

}