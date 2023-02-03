import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/common/utils/validators.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datsources/login_response.dart';
import 'package:travelgrid/domain/usecases/login_usecase.dart';

class TravelFormBloc extends FormBloc<String, String> {

  final selectModeID = SelectFieldBloc<String, dynamic>();
  final selectWithBill = SelectFieldBloc<String, dynamic>();
  final checkInDate =  TextFieldBloc(validators: [emptyValidator]);
  final checkInTime =  TextFieldBloc(validators: [emptyValidator]);
  final checkOutTime =  TextFieldBloc(validators: [emptyValidator]);


  final modeName =  TextFieldBloc(validators: [emptyValidator]);
  final VehicleTypeName =  TextFieldBloc(validators: [emptyValidator]);

//  final tfHotelName =  TextFieldBloc(validators: [emptyValidator],initialValue: "nill");

  final swWithBill = BooleanFieldBloc(initialValue: false);
  final tfDestination =  TextFieldBloc(validators: [emptyValidator]);
  final tfOrigin =  TextFieldBloc(validators: [emptyValidator]);
  final tfVoucher = TextFieldBloc(initialValue: "nill");
  final tfAmount = TextFieldBloc();
  final tfDescription = TextFieldBloc();

  final flUpload = SelectFieldBloc();

  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  TravelFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

      if(data.isNotEmpty){

        tfVoucher.addValidators(Validators().getValidators(data['text_field_voucher']));
        tfVoucher.addValidators(Validators().getValidators(data['text_field_voucher']));
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
      flUpload
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

    Map<String,dynamic> saveConvMap = {
      "conveyanceDate":  checkInDate.value,
      "origin": tfOrigin.value,
      "destination":  tfDestination.value,

      "startTime": "00:00",
      "endTime": "00:00",
      "distance": 0,
      "fuelPricePerLitre": 0,
      "violated": true,

      "travelMode": int.parse(selectModeID.value.toString()),
      "travelModeName":  modeName.value,
      "amount": int.parse(tfAmount.value),
      "maGeConveyanceCityPair": [],
      "description": tfDescription.value,
      "voucherNumber": swWithBill.value ? tfVoucher.value : "",
      "withBill": swWithBill.value,
      "voucherPath": "",
      "voucherFile": null,
      "voilationMessage": "Exception due to manual creation of Conveyance",
    };

    emitSuccess(successResponse: jsonEncode(saveConvMap));

  }



}