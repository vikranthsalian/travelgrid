import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/utils/validators.dart';


class GEFormBloc extends FormBloc<String, String> {



  final lvMisc = ListFieldBloc();


  final tfDescription = TextFieldBloc(validators: [emptyValidator]);
  final tfMiscTotal = TextFieldBloc(validators: [emptyValidator]);
  final tfConvTotal = TextFieldBloc(validators: [emptyValidator]);
  final tfAccomTotal = TextFieldBloc(validators: [emptyValidator]);
  final tfTotal = TextFieldBloc(validators: [emptyValidator]);

  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }


  GEFormBloc(Map<String, dynamic> data):super(autoValidate: true) {
    Map emptyValidator = {
      "validators" : [
        {
          "type" : "empty"
        }
      ]
    };

      if(data!=null && data.isNotEmpty){
        tfDescription.addValidators(Validators().getValidators(data['text_field_desc']));
      }

    addFieldBlocs(fieldBlocs: [
      tfDescription
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {

    Map<String, dynamic> mapData ={
      "employeeName":"Abhilash",
      "maGeAccomodationExpense":[],
      "maGeConveyanceExpense":[],
      "maGeMiscellaneousExpense":[
        {
          "amount": 500,
          "description": "",
          "voucherNumber": "66778",
          "withBill": false,
          "violated": false,
          "voilationMessage": "Exception due to manual creation of Miscellaneous",
          "miscellaneousType": 213,
          "startDate": "05-01-2023",
          "endDate": "06-01-2023",
          "voucherPath": "",
          "voucherFile": null,
          "city": 1751,
          "cityName": "hyderabad",
          "miscellaneousTypeName": "Incidental",
          "hsnCode": "",
          "gstNumber": "",
          "tax": 0.0,
          "cgst": 0.0,
          "sgst": 0.0,
          "igst": 0.0,
          "totalAmt": 500.0,
          "vendorName": "",
          "invoiceDate": "",
          "cgstPrc": 0.0,
          "sgstPrc": 0.0,
          "igstPrc": 0.0
        }
      ],
      "accommodationSelf":0,
      "conveyanceSelf":0,
      "miscellaneousSelf":0,
      "totalExpense":0,
    //  "selfApprovals":false,
    };


  }



}