import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ApprovalTrFormBloc extends FormBloc<String, String> {

  final swBillable = BooleanFieldBloc(initialValue: false);
  final requestType = TextFieldBloc(validators: [emptyValidator]);
  final purposeOfTravelID = SelectFieldBloc();
  final purposeOfTravel = TextFieldBloc(validators: [emptyValidator]);
  final purposeDetails = TextFieldBloc(validators: [emptyValidator]);


  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  ApprovalTrFormBloc(Map<String, dynamic> data):super(autoValidate: true) {


    addFieldBlocs(fieldBlocs: [
      swBillable,
      requestType,
      purposeOfTravelID,
      purposeOfTravel,
      purposeDetails
    ]);

  }

  @override
  FutureOr<void> onSubmitting() async {
    try {



      Map<String, dynamic> save = {
        "purposeOfTravel": purposeDetails.value,
        "tripBillable": swBillable.value ? 35 : 34,
        "purposeOfVisit": int.parse(purposeOfTravelID.value.toString()),
        "requestType": requestType.value.toLowerCase(),
      };

      emitSuccess(successResponse: jsonEncode(save));
    }catch(e){
      print(e);

    }



  }

}