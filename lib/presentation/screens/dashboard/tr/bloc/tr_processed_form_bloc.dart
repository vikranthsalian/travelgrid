import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/datasources/summary/tr_summary_response.dart';
import 'package:travelgrid/data/models/tr/tr_city_pair_model.dart';
import 'package:travelgrid/data/models/tr/tr_forex_model.dart';
import 'package:travelgrid/data/models/tr/tr_insurance_model.dart';
import 'package:travelgrid/data/models/tr/tr_traveller_details.dart';
import 'package:travelgrid/data/models/tr/tr_visa_model.dart';

class ProcessedTrFormBloc extends FormBloc<String, String> {


  final swBillable = BooleanFieldBloc(initialValue: false);
  final requestType = TextFieldBloc(validators: [emptyValidator]);
  final requestTypeID = SelectFieldBloc<String, dynamic>(initialValue: "");

  final travellerDetails = SelectFieldBloc<List<TRTravellerDetails>,dynamic>(initialValue: []);
  final purposeOfTravelID = SelectFieldBloc();
  final purposeOfTravel = TextFieldBloc(validators: [emptyValidator]);


  final purposeDetails = TextFieldBloc(validators: [emptyValidator]);

  final employeeType = SelectFieldBloc<String, dynamic>(initialValue: "");



  final segmentType =  TextFieldBloc(validators: [emptyValidator]);

  final cashList =  SelectFieldBloc<List<MaCashAdvance>,dynamic>(initialValue: []);
  final forexList =  SelectFieldBloc<List<TrForexAdvance>,dynamic>(initialValue: []);
  final visaList =  SelectFieldBloc<List<TRTravelVisas>,dynamic>(initialValue: []);
  final insuranceList =  SelectFieldBloc<List<TRTravelInsurance>,dynamic>(initialValue: []);
  final cityList =  SelectFieldBloc<List<TRCityPairModel>,dynamic>(initialValue: []);
  final segmentTypeID =  SelectFieldBloc();


  final noteAgent = TextFieldBloc();
  final noteApprover = TextFieldBloc();
  final voucherPath = TextFieldBloc();



  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  ProcessedTrFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

    addFieldBlocs(fieldBlocs: [
      swBillable,
      requestType,
      purposeOfTravelID,
      purposeOfTravel,
      purposeDetails,

      segmentType,
      cashList,
      cityList,
      forexList,
      visaList,
      insuranceList,

      noteAgent,
      noteApprover,
      voucherPath,
    ]);

  }

  @override
  FutureOr<void> onSubmitting() async {

    String reqType="self";

    if(requestTypeID.value!="self"){
      if(employeeType.value.toString().isEmpty){
        MetaAlert.showErrorAlert(message: "Please Select Employee Type");
        return;
      }
      if(travellerDetails.value == null){
        MetaAlert.showErrorAlert(message: "Please Select Employee");
        return;
      }
      reqType= "onBehalf - "+employeeType.value!;
    }

    if(cityList.value!.isEmpty){
      MetaAlert.showErrorAlert(message: "Please Add City Pairs");
      return;
    }

    try {
      Map<String, dynamic> save = {
        "purposeOfTravel": purposeDetails.value,
        "tripBillable": swBillable.value ? 35 : 34,
        "purposeOfVisit": int.parse(purposeOfTravelID.value.toString()),
        "requestType": reqType,
        "maTravelerDetails":travellerDetails.value,

        if(requestTypeID.value=="onBehalf")
          "onbehalf": true,

        if(requestTypeID.value=="self")
          "self": true,

        if(requestTypeID.value=="group")
          "group": true,


        "maCashAdvance": cashList.value,
        "maForexAdvance": forexList.value,
        "maTravelVisas": visaList.value,
        "maTravelInsurance": insuranceList.value,
        "segmentType": segmentType.value,
        "maTravelRequestCityPair": cityList.value,

        "comments": noteApprover.value,
        "commentToAgent": noteAgent.value,
        "uploadPath": voucherPath.value,
      };

      print(save);

      emitSuccess(successResponse: jsonEncode(save));
    }catch(e){
      print("e");
      print(e);
    }

  }



}