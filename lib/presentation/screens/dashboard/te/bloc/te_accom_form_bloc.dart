import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelex/common/utils/validators.dart';

class AccomTeFormBloc extends FormBloc<String, String> {

  final selectAccomID = SelectFieldBloc<String, dynamic>();
  final selectWithBill = SelectFieldBloc<String, dynamic>();
  final checkInDate =  TextFieldBloc(validators: [emptyValidator],initialValue: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  final checkInTime =  TextFieldBloc(validators: [emptyValidator],initialValue: "00:00");
  final checkOutDate =  TextFieldBloc(validators: [emptyValidator],initialValue: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  final checkOutTime =  TextFieldBloc(validators: [emptyValidator],initialValue: "00:00");
  final cityName =  TextFieldBloc(validators: [emptyValidator]);
  final cityID =  TextFieldBloc(validators: [emptyValidator]);
  final accomName =  TextFieldBloc(validators: [emptyValidator]);

  final tfHotelName =  TextFieldBloc(validators: [emptyValidator],initialValue: "nill");

  final swWithBill = BooleanFieldBloc(initialValue: false);
  final swByCompany = BooleanFieldBloc(initialValue: false);
  final tfVoucher = TextFieldBloc(initialValue: "nill");
  final tfAmount = TextFieldBloc();
  final tfTax= TextFieldBloc();
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

  AccomTeFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

      if(data.isNotEmpty){

        tfVoucher.addValidators(Validators().getValidators(data['text_field_voucher']));
        tfHotelName.addValidators(Validators().getValidators(data['text_field_hotel']));

        tfAmount.addValidators(Validators().getValidators(data['text_field_amount']));
        tfTax.addValidators(Validators().getValidators(data['text_field_tax']));
        tfDescription.addValidators(Validators().getValidators(data['text_field_desc']));
      }

    addFieldBlocs(fieldBlocs: [
      checkInDate,
      checkInTime,
      checkOutDate,
      checkOutTime,
      cityName,
      cityID,
      selectAccomID,
      swByCompany,
      exchangeRate,
      currency,
      accomName,
      tfHotelName,
      tfVoucher,
      tfAmount,
      tfTax,
      tfDescription,
      selectWithBill,
      swWithBill,
      voucherPath
    ]);

      swWithBill.onValueChanges(onData: (previous, current) async* {
        if(current.value == true) {
          if(tfVoucher.value=="nill"){
            tfVoucher.updateValue("");
          }
        } else {
          tfVoucher.updateValue("nill");
        }
      });

      selectAccomID.onValueChanges(onData: (previous, current) async* {
        if(current.value == "250") {
          if(tfHotelName.value=="nill"){
            tfHotelName.updateValue("");
          }
        } else {
          tfHotelName.updateValue("nill");
        }
      });
  }

  @override
  FutureOr<void> onSubmitting() async {
    Map<String,dynamic> saveAccomMap = {
    "checkInDate": checkInDate.value,
    "checkInTime": checkInTime.value,
    "checkOutDate": checkOutDate.value,
    "checkOutTime": checkOutTime.value,
    "accomodationType": int.parse(selectAccomID.value.toString()),
    "hotelName": selectAccomID.value == "250" ? tfHotelName.value :"",
    "city": cityID.valueToInt,
    "amount": tfAmount.valueToInt,
    "tax": tfTax.valueToInt,
    "byCompany": swByCompany.value,
    "exchangeRate": exchangeRate.valueToInt,
    "currency": currency.value,
    "voucherNumber": swWithBill.value ? tfVoucher.value : "",
    "voucherPath":  voucherPath.value,
    "eligibleAmount": 1600.0,
    "withBill": swWithBill.value,
    "description": tfDescription.value,
    "voilationMessage": "",
    "receivedApproval": false,
    "requireApproval": false,
    "modified": false,
    };
    emitSuccess(successResponse: jsonEncode(saveAccomMap));

  }

}