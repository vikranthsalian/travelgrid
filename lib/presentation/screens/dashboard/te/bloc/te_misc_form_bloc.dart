import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/common/utils/validators.dart';


class MiscTeFormBloc extends FormBloc<String, String> {

  final miscID =  SelectFieldBloc<String, dynamic>(initialValue: "");
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

  final showGroup =  SelectFieldBloc<bool,dynamic>(initialValue: false);
  final showAdd =  SelectFieldBloc<bool,dynamic>(initialValue: false);
  final groupIds =  SelectFieldBloc<List<String>,dynamic>(initialValue: []);

  final showError = SelectFieldBloc<bool, dynamic>(initialValue: false);
  final count = SelectFieldBloc<int, int>(initialValue: 1);
  final days = SelectFieldBloc<int, int>(initialValue: 1);
  final showErrorValue = TextFieldBloc(initialValue: "0");

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

        onChanges();
      });



      unitTypeID.onValueChanges(onData: (previous, current) async* {
        onChanges();
      });

      tfAmount.onValueChanges(onData: (previous, current) async* {
        onChanges();
      });

      count.onValueChanges(onData: (previous, current) async* {
        onChanges();
      });

      days.onValueChanges(onData: (previous, current) async* {
        onChanges();
      });
  }

  @override
  FutureOr<void> onSubmitting() async {

    bool isGroupExpense = false;
    isGroupExpense = showGroup.value ?? false;
    String groupValues=groupIds.value!.join(",");

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

        "groupEmployees":groupValues,
        "groupExpense":isGroupExpense,
      };

      emitSuccess(successResponse: jsonEncode(saveMiscData));
    }catch(e){
      print(e);
    }

  }

  void onChanges() {

    //food
    if(miscID.value == "212"){
      showErrorValue.updateValue("");
      showError.updateValue(false);
      if(unitTypeID.value == "288") {
        if (tfAmount.valueToDouble! > (200 * days.value! * count.value!)) {
          showErrorValue.updateValue((200 * days.value! * count.value!).toString() );
          print("showErrorValue.value");
          print(showErrorValue.value);
          showError.updateValue(true);
          return;
        }
        showErrorValue.updateValue("0");
        showError.updateValue(false);
        return;
      }

      if(unitTypeID.value == "289") {
        if (tfAmount.valueToDouble! > (400 * days.value! * count.value!)) {
          showErrorValue.updateValue((400 * days.value! * count.value!).toString());
          showError.updateValue(true);
          return;
        }
        showErrorValue.updateValue("0");
        showError.updateValue(false);
        return;
      }
    }


    showErrorValue.updateValue("");
    showError.updateValue(false);
  }

}