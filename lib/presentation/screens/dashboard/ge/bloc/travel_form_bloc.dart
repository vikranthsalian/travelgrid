import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelex/common/utils/validators.dart';
import 'package:travelex/data/models/ge/ge_conveyance_model.dart';
class TravelFormBloc extends FormBloc<String, String> {

  final selectModeID = SelectFieldBloc<String, dynamic>();
  final selectWithBill = SelectFieldBloc<String, dynamic>();
  final checkInDate =  TextFieldBloc(validators: [emptyValidator]);

  final checkInTime =  TextFieldBloc(validators: [emptyValidator]);
  final checkOutTime =  TextFieldBloc(validators: [emptyValidator]);
  final distance =  TextFieldBloc(validators: [emptyValidator]);


  final modeName =  TextFieldBloc(validators: [emptyValidator]);

  final VehicleTypeName =  TextFieldBloc(validators: [emptyValidator]);

  final swWithBill = BooleanFieldBloc(initialValue: false);

  final tfDestination =  TextFieldBloc(validators: [emptyValidator]);
  final tfOrigin =  TextFieldBloc(validators: [emptyValidator]);

  final tfVoucher = TextFieldBloc(initialValue: "nill");
  final tfAmount = TextFieldBloc();
  final tfDescription = TextFieldBloc();

  final voucherPath = TextFieldBloc();
  final onCityPairAdded = SelectFieldBloc<List<MaGeConveyanceCityPair>,dynamic>(initialValue: []);
  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  TravelFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

      if(data.isNotEmpty){

        tfVoucher.addValidators(Validators().getValidators(data['text_field_voucher']));
        tfAmount.addValidators(Validators().getValidators(data['text_field_amount']));
        tfDescription.addValidators(Validators().getValidators(data['text_field_desc']));
      }

    addFieldBlocs(fieldBlocs: [
      checkInDate,
    //  checkInTime,
    //  checkOutTime,
      tfOrigin,
      tfDestination,
      selectModeID,
      modeName,
   //   VehicleTypeName,
      tfVoucher,
      tfAmount,
      tfDescription,
   //   selectWithBill,
      swWithBill,
      voucherPath
    ]);

      swWithBill.onValueChanges(onData: (previous, current) async* {
        if(current.value == true) {
          tfVoucher.updateValue("");
        } else {
          tfVoucher.updateValue("nill");
        }
      });

      selectModeID.onValueChanges(onData: (previous, current) async* {
        if(current.value == "250") {
       //   tfHotelName.updateValue("");
        } else {
      //    tfHotelName.updateValue("nill");
        }
      });
  }

  @override
  FutureOr<void> onSubmitting() async {
    print("dasdkak");

    String amount =  double.parse(tfAmount.value).toStringAsFixed(2);

    try {
      Map<String, dynamic> saveConvMap = {
        "conveyanceDate": checkInDate.value,
        "origin": tfOrigin.value,
        "destination": tfDestination.value,

        "startTime": selectModeID.value.toString() == "193" ? checkInTime.value : "00:00",
        "endTime": selectModeID.value.toString() == "193" ? checkOutTime.value  : "00:00",
        "distance":selectModeID.value.toString() == "193" ? double.parse(distance.value.toString()) : 0.0,

        "violated": true,
        "vehicleType": 271,

        "travelMode": int.parse(selectModeID.value.toString()),
        "travelModeName": modeName.value,
        "amount": double.parse(amount),
        "maGeConveyanceCityPair": onCityPairAdded.value,
        "description": tfDescription.value,
        "voucherNumber": swWithBill.value ? tfVoucher.value : "",
        // "withBill": false,
        //
        // "voucherPath": voucherPath.value,

        "voilationMessage": ""
      };
      emitSuccess(successResponse: jsonEncode(saveConvMap),canSubmitAgain: true);
    }catch(e){
      print(e);
    }



  }



}