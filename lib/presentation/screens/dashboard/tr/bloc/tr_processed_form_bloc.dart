import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/data/datasources/summary/tr_summary_response.dart';
import 'package:travelgrid/data/models/tr/tr_city_pair_model.dart';
import 'package:travelgrid/data/models/tr/tr_forex_model.dart';
import 'package:travelgrid/data/models/tr/tr_insurance_model.dart';
import 'package:travelgrid/data/models/tr/tr_visa_model.dart';

class ProcessedTrFormBloc extends FormBloc<String, String> {

  final segmentType =  TextFieldBloc(validators: [emptyValidator]);

  final cashList =  SelectFieldBloc<List<MaCashAdvance>,dynamic>(initialValue: []);
  final forexList =  SelectFieldBloc<List<TrForexAdvance>,dynamic>(initialValue: []);
  final visaList =  SelectFieldBloc<List<TRTravelVisas>,dynamic>(initialValue: []);
  final insuranceList =  SelectFieldBloc<List<TRTravelInsurance>,dynamic>(initialValue: []);
  final cityList =  SelectFieldBloc<List<TRCityPairModel>,dynamic>(initialValue: []);
  final segmentTypeID =  SelectFieldBloc();



  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  ProcessedTrFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

    addFieldBlocs(fieldBlocs: [
      segmentType,
      cashList,
      cityList,
      forexList,
      visaList,
      insuranceList,
    ]);

  }

  @override
  FutureOr<void> onSubmitting() async {
    try {
      Map<String, dynamic> save = {
        "maCashAdvance": cashList.value,
        "maForexAdvance": forexList.value,
        "maTravelVisas": visaList.value,
        "maTravelInsurance": insuranceList.value,
        "segmentType": segmentType.value,
        "maTravelRequestCityPair": cityList.value
      };

      print(save);

      emitSuccess(successResponse: jsonEncode(save));
    }catch(e){
      print("e");
      print(e);
    }

  }

}