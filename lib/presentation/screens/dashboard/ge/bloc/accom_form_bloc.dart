import 'dart:async';
import 'dart:convert';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/common/utils/validators.dart';
import 'package:travelgrid/data/models/ge/ge_group_accom_model.dart';

class AccomFormBloc extends FormBloc<String, String> {

  final showGroup =  SelectFieldBloc<bool,dynamic>(initialValue: false);
  final showAdd =  SelectFieldBloc<bool,dynamic>(initialValue: true);
  final groupIds =  SelectFieldBloc<List<GEGroupAccomModel>,dynamic>(initialValue: []);

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

  final voucherPath = TextFieldBloc();

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
    print("differenceInYears");
    DateTime dob1 = MetaDateTime().getDateTime(checkInDate.value);
    print(dob1);

    DateTime dob2 = MetaDateTime().getDateTime(checkOutDate.value);
    print(dob2);
    print("differenceInYears 2");
    Duration dur =  dob2.difference(dob1);

    int differenceInYears = (dur.inDays);

    print(differenceInYears);


    bool isGroupExpense=false;
    if(showGroup.value == true && groupIds.value!.isEmpty){
      MetaAlert.showErrorAlert(message: "Please add group employees");
    }
    isGroupExpense=true;
    String groupValues=groupIds.value!.join(",");


  try {
  Map<String, dynamic> saveAccomMap = {
    "checkInDate": checkInDate.value,
    "checkInTime": checkInTime.value,

    "checkOutDate": checkOutDate.value,
    "checkOutTime": checkOutTime.value,

    "noOfDays": dur.inDays,
    "city": int.parse(cityID.value),
    "cityName": cityName.value,
    "hotelName": selectAccomID.value == "250" ? tfHotelName.value : "",

    "accomodationType": int.parse(selectAccomID.value.toString()),
    "accomodationTypeName": accomName.value,

    "amount": tfAmount.valueToDouble,
    "tax": tfTax.value.isEmpty ? 0.0 : tfTax.valueToDouble,
    "description": tfDescription.value,
    "withBill": swWithBill.value,

    "voucherPath": voucherPath.value,

    "voucherNumber": swWithBill.value ? tfVoucher.value : "",
    "maGeAccomodationGroupExpense":groupIds.value,

  };
  emitSuccess(successResponse: jsonEncode(saveAccomMap));
  }catch(e){
    print(e);
  }
  }

}