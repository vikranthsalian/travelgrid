import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/common/utils/validators.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datsources/login_response.dart';
import 'package:travelgrid/data/models/ge_conveyance_model.dart';
import 'package:travelgrid/data/models/location_model.dart';
import 'package:travelgrid/domain/usecases/login_usecase.dart';

class TravelOVFormBloc extends FormBloc<String, String> {

  final vehicleTypeName =  TextFieldBloc(validators: [emptyValidator]);
  final checkInDate =  TextFieldBloc(validators: [emptyValidator]);
  final startTime =  TextFieldBloc(validators: [emptyValidator]);
  final endTime =  TextFieldBloc(validators: [emptyValidator]);

  final tfDestination =  TextFieldBloc(validators: [emptyValidator]);
  final tfOrigin =  TextFieldBloc(validators: [emptyValidator]);
  final tfDistance=  TextFieldBloc(validators: [emptyValidator]);
  final tfAmount = TextFieldBloc(validators: [emptyValidator]);
  final tfFuelPrice = TextFieldBloc(validators: [emptyValidator]);

  final selectModeID = SelectFieldBloc<String, dynamic>();
  final selectTypeID = SelectFieldBloc<String, dynamic>();
  final startTimeWidget = SelectFieldBloc<String, dynamic>();
  final endTimeWidget = SelectFieldBloc<String, dynamic>();
  final modeName =  TextFieldBloc(validators: [emptyValidator]);


  final onAutoSelected =  SelectFieldBloc(initialValue: "auto");
  final onLocationAdded =  SelectFieldBloc<List<LocationModel>,dynamic>(initialValue: []);
  final onDataAdded = SelectFieldBloc<String,dynamic>();
  final onListLoaded = SelectFieldBloc<List<MaGeConveyanceCityPair>,dynamic>(initialValue: []);


  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  TravelOVFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

    addFieldBlocs(fieldBlocs: [
      checkInDate,
      startTime,
      endTime,
      tfOrigin,
      vehicleTypeName,
      tfDestination,
      tfDistance,
      tfAmount,
    ]);

    vehicleTypeName.onValueChanges(onData: (previous, current) async* {

      if(tfDistance.value.isNotEmpty){
        if(current.value == "Two-Wheeler") {
          tfAmount.updateValue((tfDistance.valueToInt!* tfFuelPrice.valueToInt!).toString());
        } else if(current.value == "Four-Wheeler"){
          tfAmount.updateValue((tfDistance.valueToInt!* tfFuelPrice.valueToInt!).toString());
        }else{
          tfAmount.updateValue("0");
        }
      }else{
        tfAmount.updateValue("0");
      }


    });

    tfDistance.onValueChanges(onData: (previous, current) async* {

      if(tfDistance.value.isEmpty){
        tfAmount.updateValue("0");
      }


      if(vehicleTypeName.value.isNotEmpty){
        if(vehicleTypeName.value == "Two-Wheeler") {
          tfAmount.updateValue((tfDistance.valueToInt! * tfFuelPrice.valueToInt!).toString());
        } else if(vehicleTypeName.value == "Four-Wheeler"){
          tfAmount.updateValue((tfDistance.valueToInt! * tfFuelPrice.valueToInt!).toString());
        }else{
          tfAmount.updateValue("0");
        }
      }else{
        tfAmount.updateValue("0");
      }


    });


  }

  @override
  FutureOr<void> onSubmitting() async {

    try {
      Map<String, dynamic> saveOVMap = {
        //  "checkInDate": checkInDate.value,
        "srcLatLog": "12.96643,77.58718",
        "desLatLog": "18.94017,72.83483",
        "travelMode": 193,
       // "vehicleType": int.parse(selectTypeID.value.toString()),

        "origin": tfOrigin.value,
        "destination": tfDestination.value,
        "distance": double.parse(tfDistance.value),
        "startTime": startTime.value,
        "endTime": endTime.value,
        "amount": double.parse(tfAmount.value),
      };
      emitSuccess(successResponse: jsonEncode(saveOVMap),canSubmitAgain: true);
    }catch(e){
      print(e);
    }



  }



}