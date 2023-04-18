import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/data/models/ge/ge_conveyance_model.dart';
import 'package:travelgrid/data/models/location_model.dart';

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
          tfAmount.updateValue(((tfDistance.valueToInt ?? 0)* tfFuelPrice.valueToInt!).toString());
        } else if(current.value == "Four-Wheeler"){
          tfAmount.updateValue(((tfDistance.valueToInt ?? 0)* tfFuelPrice.valueToInt!).toString());
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
          tfAmount.updateValue(((tfDistance.valueToInt ?? 0) * tfFuelPrice.valueToInt!).toString());
        } else if(vehicleTypeName.value == "Four-Wheeler"){

          tfAmount.updateValue(((tfDistance.valueToInt ?? 0) * tfFuelPrice.valueToInt!).toString());
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

    print("catc 1h");
try {

  print("onListLoaded.value");
  print(onListLoaded.value);
  Map<String, dynamic> saveOVMap = {
    //  "checkInDate": checkInDate.value,
    "srcLatLog": onAutoSelected.value == "auto" ? onLocationAdded.value!.first
        .latitude!.toString() + "," + onLocationAdded.value!.first.longitude!.toString() : "",
    // "srcLatLog": "12.96643,77.58718",
    "desLatLog": onAutoSelected.value == "auto" ? onLocationAdded.value!.last
        .latitude!.toString()  + "," + onLocationAdded.value!.last.longitude.toString()  : "",
    // "desLatLog": "18.94017,72.83483",
    "travelMode": 193,
    // "vehicleType": int.parse(selectTypeID.value.toString()),

    "origin": tfOrigin.value,
    "destination": tfDestination.value,
    "distance": double.parse(tfDistance.value),
    "startTime": startTime.value,
    "endTime": endTime.value,
    "amount": double.parse(tfAmount.value),
  };

  emitSuccess(successResponse: jsonEncode(saveOVMap), canSubmitAgain: true);
}catch(e){
  print("catch");
  print(e);
  emitSuccess(successResponse: jsonEncode(""), canSubmitAgain: true);
}


  }



}