import 'dart:async';
import 'dart:convert';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/utils/validators.dart';


class MiscFormBloc extends FormBloc<String, String> {

  final miscID =  SelectFieldBloc<String, dynamic>();
  final checkInDate = TextFieldBloc(validators: [emptyValidator]);
  final checkOutDate =  TextFieldBloc(validators: [emptyValidator]);
  final cityName =  TextFieldBloc(validators: [emptyValidator]);
  final cityID =  TextFieldBloc(validators: [emptyValidator]);
  final miscName =  TextFieldBloc(validators: [emptyValidator]);

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


  MiscFormBloc(Map<String, dynamic> data):super(autoValidate: true) {

      if(data!=null && data.isNotEmpty){

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
      unitTypeID,
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

    Map<String,dynamic> saveMiscData = {
      "miscellaneousTypeName": miscName.value,
      "miscellaneousType":int.parse(miscID.value ?? "0"),
      "startDate": checkInDate.value,
      "endDate": checkOutDate.value,
      "city":int.parse(cityID.value),
      "cityName":cityName.value,
      if(miscID.value == "212")
      "unitType":int.parse(unitTypeID.value),
    //  "unitName":unitTypeName.value,
      "amount": int.parse(tfAmount.value),
      "voucherNumber": tfVoucher.value,
      "description": tfDescription.value,

      "voucherPath": voucherPath.value,
      "voucherFile": null,

      "voilationMessage": "Exception due to manual creation of Miscellaneous",
    };
     emitSuccess(successResponse: jsonEncode(saveMiscData));

  }



}