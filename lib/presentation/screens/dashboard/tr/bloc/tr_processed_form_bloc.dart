import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/data/datasources/tr_summary_response.dart';
import 'package:travelgrid/data/models/tr/tr_city_pair_model.dart';

class ProcessedTrFormBloc extends FormBloc<String, String> {

  final segmentType =  TextFieldBloc(validators: [emptyValidator]);

  final cashList =  SelectFieldBloc<List<MaCashAdvance>,dynamic>(initialValue: []);
  final forexList =  SelectFieldBloc<List<MaForexAdvance>,dynamic>(initialValue: []);
  final visaList =  SelectFieldBloc<List<MaTravelVisas>,dynamic>(initialValue: []);
  final insuranceList =  SelectFieldBloc<List<MaTravelInsurance>,dynamic>(initialValue: []);
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
        "MaForexAdvance": forexList.value,
        "MaTravelVisas": visaList.value,
        "MaTravelInsurance": insuranceList.value,
        "segmentType": segmentType.value,
        "maTravelRequestCityPair": cityList.value
      };

      emitSuccess(successResponse: jsonEncode(save));
    }catch(e){
      print(e);
    }

  }

}