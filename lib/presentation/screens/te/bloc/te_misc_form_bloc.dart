import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/utils/validators.dart';


class MiscTeFormBloc extends FormBloc<String, String> {

  final miscID =  SelectFieldBloc<String, dynamic>();
  final checkInDate = TextFieldBloc(validators: [emptyValidator]);
  final checkOutDate =  TextFieldBloc(validators: [emptyValidator]);
  final miscName =  TextFieldBloc(validators: [emptyValidator]);
  final currency =  TextFieldBloc(validators: [emptyValidator],initialValue: "48");
  final exchangeRate =  TextFieldBloc(validators: [emptyValidator],initialValue: "1");

  final unitTypeID =  TextFieldBloc(validators: [emptyValidator]);
  final unitTypeName =  TextFieldBloc(validators: [emptyValidator]);

  final tfVoucher = TextFieldBloc();
  final tfAmount = TextFieldBloc();
  final tfDescription = TextFieldBloc();
  final voucherPath = TextFieldBloc();

  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }


  MiscTeFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

      if(data!=null && data.isNotEmpty){

        tfVoucher.addValidators(Validators().getValidators(data['text_field_voucher']));
        tfAmount.addValidators(Validators().getValidators(data['text_field_amount']));
        tfDescription.addValidators(Validators().getValidators(data['text_field_desc']));

      }

    addFieldBlocs(fieldBlocs: [
      checkInDate,
      checkOutDate,
      miscID,
      miscName,
      unitTypeID,
      exchangeRate,
      currency,
      tfVoucher,
      tfAmount,
      tfDescription,
      voucherPath,
    ]);

      miscID.onValueChanges(onData: (previous, current) async* {
        if(current.value == "212") {
          if(current.value=="nill"){
            unitTypeID.updateValue("");
          }
        } else {
          unitTypeID.updateValue("nill");
        }
      });
  }

  @override
  FutureOr<void> onSubmitting() async {
    try {
      Map<String, dynamic> saveMiscData = {
        "miscellaneousExpenseDate": checkInDate.value,
        "miscellaneousExpenseEndDate": checkOutDate.value,

        "miscellaneousType":int.parse(miscID.value.toString()),
        "voucherNumber": tfVoucher.value,
        "amount": tfAmount.valueToInt,
        "byCompany": false,
        if(miscID.value == "212")
        "unitType": int.parse(unitTypeID.value),
        "exchangeRate": exchangeRate.valueToInt,
        "currency": currency.value,
        "voucherPath": voucherPath.value,
        "description": tfDescription.value,
        "voilationMessage": "",
        "requireApproval": false,
        "withBill": false,
        "modified": false,

      };

      //
      // Map<String,dynamic> saveMiscData = {
      //   "miscellaneousTypeName": miscName.value,
      //   "miscellaneousType":int.parse(miscID.value ?? "0"),
      //   "startDate": checkInDate.value,
      //   "endDate": checkOutDate.value,
      //   "city":int.parse(cityID.value),
      //   "cityName":cityName.value,
      //   if(miscID.value == "212")
      //   "unitType":int.parse(unitTypeID.value),
      //   "amount": int.parse(tfAmount.value),
      //   "voucherNumber": tfVoucher.value,
      //   "description": tfDescription.value,
      //
      //   "voucherPath": voucherPath.value,
      //   "voucherFile": null,
      //
      //   "voilationMessage": "Exception due to manual creation of Miscellaneous",
      // };
      emitSuccess(successResponse: jsonEncode(saveMiscData));
    }catch(e){
      print(e);
    }

  }



}