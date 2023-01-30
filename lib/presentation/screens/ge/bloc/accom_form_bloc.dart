import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/validators.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datsources/login_response.dart';
import 'package:travelgrid/domain/usecases/login_usecase.dart';

class AccomFormBloc extends FormBloc<String, String> {


  final checkInDate = SelectFieldBloc();
  final checkOutDate = SelectFieldBloc();
  final city = SelectFieldBloc();
  final accom = SelectFieldBloc();
  final flUpload = SelectFieldBloc();

  final tfVoucher = TextFieldBloc();
  final tfAmount = TextFieldBloc();
  final tfTax= TextFieldBloc();
  final tfDescription = TextFieldBloc();

  final swWithBill = BooleanFieldBloc(initialValue: true);


  AccomFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

      if(data.isNotEmpty){
        tfVoucher.addValidators(Validators().getValidators(data['text_field_voucher']));
        tfAmount.addValidators(Validators().getValidators(data['text_field_amount']));
        tfTax.addValidators(Validators().getValidators(data['text_field_tax']));
        tfDescription.addValidators(Validators().getValidators(data['text_field_desc']));
      }

    addFieldBlocs(fieldBlocs: [
      tfVoucher,
      tfAmount,
      tfTax,
      tfDescription,
    ]);
  }

  @override
  FutureOr<void> onSubmitting() async {


     emitSuccess(successResponse: jsonEncode({}));

  }



}