import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/common/utils/validators.dart';

class TicketTeFormBloc extends FormBloc<String, String> {

  final selectWithBill = SelectFieldBloc<String, dynamic>();
  final checkInDate =  TextFieldBloc(validators: [emptyValidator]);
  final checkInTime =  TextFieldBloc(validators: [emptyValidator]);
  final origin =  TextFieldBloc(validators: [emptyValidator]);
  final destination =  TextFieldBloc(validators: [emptyValidator]);

  final fareClass =  TextFieldBloc(validators: [emptyValidator]);
  final travelMode =  TextFieldBloc(validators: [emptyValidator]);



  final swWithBill = BooleanFieldBloc(initialValue: false);
  final swByCompany = BooleanFieldBloc(initialValue: false);

  final tfFlight = TextFieldBloc();
  final tfAmount = TextFieldBloc();
  final tfPNR= TextFieldBloc();
  final tfTicket= TextFieldBloc();
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

  TicketTeFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

      if(data.isNotEmpty){

        tfFlight.addValidators(Validators().getValidators(data['text_field_flight']));
        tfPNR.addValidators(Validators().getValidators(data['text_field_pnr']));
        tfTicket.addValidators(Validators().getValidators(data['text_field_ticket']));

        tfAmount.addValidators(Validators().getValidators(data['text_field_amount']));

        tfDescription.addValidators(Validators().getValidators(data['text_field_desc']));
      }

    addFieldBlocs(fieldBlocs: [
      checkInDate,
      checkInTime,
      origin,
      destination,
      travelMode,
      fareClass,
      swByCompany,
      exchangeRate,
      currency,
      tfFlight,
      tfPNR,
      tfTicket,
      tfAmount,
      tfDescription,
      selectWithBill,
      swWithBill,
      voucherPath
    ]);

  }

  @override
  FutureOr<void> onSubmitting() async {
    Map<String,dynamic> saveAccomMap = {
      "travelDate": checkInDate.value,
      "traveltime": checkInTime.value,
      "leavingFrom": origin.value,
      "goingTo": destination.value,
      "travelMode": travelMode.value,
      "byCompany": swByCompany.value,
      "fareClass": fareClass.value,
      "pnrNumber": tfPNR.value,
      "ticketNumber": tfTicket.value,
      "flightTrainBusNo": tfFlight.value,
      "amount": tfAmount.valueToDouble,
      "exchangeRate": exchangeRate.valueToInt,
      "currency": currency.value,
      "description": tfDescription.value,
      "voucherPath": voucherPath.value,
      "withBill": swWithBill.value,
      "voilationMessage": "",
      "receivedApproval": null,
      "requireApproval": null,
      "modified": null
    };




    // Map<String,dynamic> saveAccomMap = {
    //   "checkInDate": checkInDate.value,
    //   "checkInTime": checkInTime.value,
    //
    //   "checkOutDate": checkOutDate.value,
    //   "checkOutTime": checkOutTime.value,
    //
    //   "noOfDays":dur.inDays,
    //   "city": int.parse(cityID.value),
    //   "cityName": cityName.value,
    //   "hotelName": selectAccomID.value == "250" ? tfHotelName.value :"",
    //
    //   "accomodationType": int.parse(selectAccomID.value.toString()),
    //   "accomodationTypeName": accomName.value,
    //
    //   "amount": int.parse(tfAmount.value),
    //   "tax": int.parse(tfTax.value.isEmpty ? "0.0" : tfTax.value),
    //   "description": tfDescription.value,
    //   "withBill":swWithBill.value,
    //
    //   "voucherPath": voucherPath.value,
    //
    //   "voucherNumber":swWithBill.value ? tfVoucher.value : ""
    // };
    emitSuccess(successResponse: jsonEncode(saveAccomMap));

  }

}