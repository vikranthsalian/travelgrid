import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/utils/validators.dart';
class ConveyanceTeFormBloc extends FormBloc<String, String> {

  final selectModeID = SelectFieldBloc<String, dynamic>();
  final selectWithBill = SelectFieldBloc<String, dynamic>();
  final checkInDate =  TextFieldBloc(validators: [emptyValidator]);

  final modeName =  TextFieldBloc(validators: [emptyValidator]);

  final swWithBill = BooleanFieldBloc(initialValue: false);
  final swByCompany = BooleanFieldBloc(initialValue: false);

  final tfDestination =  TextFieldBloc(validators: [emptyValidator]);
  final tfOrigin =  TextFieldBloc(validators: [emptyValidator]);

  final tfVoucher = TextFieldBloc(initialValue: "nill");
  final tfAmount = TextFieldBloc();
  final tfDescription = TextFieldBloc();

  final voucherPath = TextFieldBloc();


  final currency =  TextFieldBloc(validators: [emptyValidator],initialValue: "48");
  final exchangeRate =  TextFieldBloc(validators: [emptyValidator],initialValue: "1");

  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  ConveyanceTeFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

      if(data.isNotEmpty){
        tfVoucher.addValidators(Validators().getValidators(data['text_field_voucher']));
        tfAmount.addValidators(Validators().getValidators(data['text_field_amount']));
        tfDescription.addValidators(Validators().getValidators(data['text_field_desc']));
      }

    addFieldBlocs(fieldBlocs: [
      checkInDate,
      tfOrigin,
      tfDestination,
      selectModeID,
      modeName,
      exchangeRate,
      currency,
      swByCompany,
      tfVoucher,
      tfAmount,
      tfDescription,
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
  }

  @override
  FutureOr<void> onSubmitting() async {
    try {

      Map<String, dynamic> saveConvMap = {
        "conveyanceDate": checkInDate.value,
        "fromPlace": tfOrigin.value,
        "toPlace": tfDestination.value,
        "travelMode": int.parse(selectModeID.value.toString()),
        "amount": tfAmount.valueToInt,
        "byCompany": swByCompany.value,
        "exchangeRate": exchangeRate.valueToInt,
        "currency": currency.value,
        "voucherPath": voucherPath.value,
        "voucherNumber": swWithBill.value ? tfVoucher.value : "",
        "description":  tfDescription.value,
        "voilationMessage": "",
        "requireApproval": false,
        "withBill": false,
        "modified": false,
      };
      emitSuccess(successResponse: jsonEncode(saveConvMap),canSubmitAgain: true);
    }catch(e){
      print(e);
    }



  }



}