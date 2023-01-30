import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/validators.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/domain/usecases/login_usecase.dart';

import '../../../../data/datsources/cities_list.dart';


class MiscFormBloc extends FormBloc<String, String> {


  final checkInDate = TextFieldBloc(validators: [emptyValidator]);
  final checkOutDate =  TextFieldBloc(validators: [emptyValidator]);
  final cityName =  TextFieldBloc(validators: [emptyValidator]);
  final cityID =  TextFieldBloc(validators: [emptyValidator]);
  final miscName =  TextFieldBloc(validators: [emptyValidator]);
  final miscID =  TextFieldBloc(validators: [emptyValidator]);

  final swUnitType = BooleanFieldBloc(initialValue: true);
  final tfVoucher = TextFieldBloc();
  final tfAmount = TextFieldBloc();
  final tfDescription = TextFieldBloc();
  final flUpload = SelectFieldBloc();

  static String? emptyValidator(dynamic value) {
    if (value.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }


  MiscFormBloc(Map<String, dynamic> data):super(autoValidate: true) {
    Map emptyValidator = {
      "validators" : [
        {
          "type" : "empty"
        }
      ]
    };

      if(data!=null && data.isNotEmpty){
        // checkInDate.addValidators([]);
        // checkOutDate.addValidators(Validators().getValidators(emptyValidator));
        // city.addValidators(Validators().getValidators(emptyValidator));
        // misc.addValidators(Validators().getValidators(emptyValidator));

        tfVoucher.addValidators(Validators().getValidators(data['text_field_voucher']));
        tfAmount.addValidators(Validators().getValidators(data['text_field_amount']));
        tfDescription.addValidators(Validators().getValidators(data['text_field_desc']));
      }

    addFieldBlocs(fieldBlocs: [
      checkInDate,
      checkOutDate,
      cityID,
      cityName,
      miscID,
      miscName,
      swUnitType,
      tfVoucher,
      tfAmount,
      tfDescription,
      flUpload,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {

    Map<String,dynamic> saveMiscData = {
      "miscellaneousTypeName": miscName.value,
      "miscellaneousType":miscID.value,

      "startDate": checkInDate.value,
      "endDate": checkOutDate.value,

      "city": cityID.value,
      "cityName":cityName.value,

      "voucher": tfVoucher.value,
      "amount": tfAmount.value,
      "description": tfDescription.value,

      "voucherPath": flUpload.value,
    };
     emitSuccess(successResponse: jsonEncode(saveMiscData));

  }



}