import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelex/common/utils/show_alert.dart';
import 'package:travelex/data/models/tr/tr_traveller_details.dart';

class ApprovalTrFormBloc extends FormBloc<String, String> {

  final swBillable = BooleanFieldBloc(initialValue: false);
  final requestType = TextFieldBloc(validators: [emptyValidator]);
  final requestTypeID = SelectFieldBloc<String, dynamic>(initialValue: "");
  final purposeOfTravelID = SelectFieldBloc();
  final travellerDetails = SelectFieldBloc<TRTravellerDetails,dynamic>(initialValue: null);
  final purposeOfTravel = TextFieldBloc(validators: [emptyValidator]);
  final purposeDetails = TextFieldBloc(validators: [emptyValidator]);

  final employeeType = SelectFieldBloc<String, dynamic>(initialValue: "");


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


    if(requestTypeID.value!="self"){
      if(employeeType.value.toString().isEmpty){
        MetaAlert.showErrorAlert(message: "Please Select Employee Type");
        return;
      }
      if(travellerDetails.value == null){
        MetaAlert.showErrorAlert(message: "Please Select Employee");
        return;
      }
    }

    try {

      Map<String, dynamic> save = {
        "purposeOfTravel": purposeDetails.value,
        "tripBillable": swBillable.value ? 35 : 34,
        "purposeOfVisit": int.parse(purposeOfTravelID.value.toString()),
        "requestType": requestTypeID.value,
        "maTravelerDetails": [travellerDetails.value],
      };

      emitSuccess(successResponse: jsonEncode(save));
    }catch(e){
      print(e);

    }



  }

}