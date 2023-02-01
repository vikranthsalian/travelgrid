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

class AccomFormBloc extends FormBloc<String, String> {

  final selectAccomID = SelectFieldBloc<String, dynamic>();
  final selectWithBill = SelectFieldBloc<String, dynamic>();
  final checkInDate =  TextFieldBloc(validators: [emptyValidator]);
  final checkInTime =  TextFieldBloc(validators: [emptyValidator]);
  final checkOutDate =  TextFieldBloc(validators: [emptyValidator]);
  final checkOutTime =  TextFieldBloc(validators: [emptyValidator]);
  final cityName =  TextFieldBloc(validators: [emptyValidator]);
  final cityID =  TextFieldBloc(validators: [emptyValidator]);
  final accomName =  TextFieldBloc(validators: [emptyValidator]);

  final tfHotelName =  TextFieldBloc(validators: [emptyValidator],initialValue: "nill");

  final swWithBill = BooleanFieldBloc(initialValue: false);
  final tfVoucher = TextFieldBloc(initialValue: "nill");
  final tfAmount = TextFieldBloc();
  final tfTax= TextFieldBloc();
  final tfDescription = TextFieldBloc();

  final flUpload = SelectFieldBloc();

  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  AccomFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

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
      accomName,
      tfHotelName,
      tfVoucher,
      tfAmount,
      tfTax,
      tfDescription,
      selectWithBill,
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

      selectAccomID.onValueChanges(onData: (previous, current) async* {
        if(current.value == "250") {
          tfHotelName.updateValue("");
        } else {
          tfHotelName..updateValue("nill");
        }
      });
  }

  @override
  FutureOr<void> onSubmitting() async {
    print("differenceInYears");
    DateTime dob1 = MetaDateTime().getDateTime(checkInDate.value);
    print(dob1);

    DateTime dob2 = MetaDateTime().getDateTime(checkOutDate.value);
    print(dob2);
    print("differenceInYears 2");
    Duration dur =  dob2.difference(dob1);

    int differenceInYears = (dur.inDays);

    print(differenceInYears);

    Map<String,dynamic> saveAccomMap = {
      "checkInDate": checkInDate.value,
      "checkInTime": checkInTime.value,
      "checkOutDate": checkOutDate.value,
      "checkOutTime": checkInTime.value,

      "noOfDays":dur.inDays,
      "city": int.parse(cityID.value),
      "cityName": cityName.value,

      "accomodationType": int.parse(selectAccomID.value.toString()),
      "accomodationTypeName": accomName.value,

      "amount": int.parse(tfAmount.value),
      "tax": int.parse(tfTax.value.isEmpty ? "0.0" : tfTax.value),
      "description": tfDescription.value,
      "withBill":swWithBill.value,
      "voucherPath": "",
      "voucherNumber": tfVoucher.value
    };
    emitSuccess(successResponse: jsonEncode(saveAccomMap));

  }



}