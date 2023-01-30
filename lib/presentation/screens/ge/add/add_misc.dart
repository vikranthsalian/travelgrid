import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/enum/dropdown_types.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/ge_misc_model.dart';
import 'package:travelgrid/presentation/screens/ge/bloc/misc_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class CreateMiscExpense extends StatefulWidget {
  Function(Map)? onAdd;
  CreateMiscExpense({this.onAdd});
  @override
  _CreateMiscExpenseState createState() => _CreateMiscExpenseState();
}

class _CreateMiscExpenseState extends State<CreateMiscExpense> {
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;
  MiscFormBloc? formBloc;
  bool loaded=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.miscCreateData;
    prettyPrint(jsonData);

    createMap();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        elevation: 2.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MetaButton(mapData: jsonData['bottomButtonLeft'],
                onButtonPressed: (){
                Navigator.pop(context);
                }
            ),
            MetaButton(mapData: jsonData['bottomButtonRight'],
                onButtonPressed: (){


                formBloc!.submit();
                }
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 100.h,
            color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
            child:  Column(
              children: [
                SizedBox(height:40.h),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MetaIcon(mapData:jsonData['backBar'],
                          onButtonPressed: (){
                            Navigator.pop(context);
                          }),
                      Container(
                        child:MetaTextView(mapData: jsonData['title']),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: BlocProvider(
              create: (context) => MiscFormBloc(jsonData),
              child: Builder(
                  builder: (context) {

                   formBloc =  BlocProvider.of<MiscFormBloc>(context);
                   formBloc!.miscName.updateValue("Initial UD");
                   formBloc!.miscID.updateValue("21");

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: FormBlocListener<MiscFormBloc, String, String>(
                        onSubmissionFailed: (context, state) {
                          print(state);
                          MetaAlert.showErrorAlert(
                            message: "Please Select All Fields",
                          );

                        },
                        onSubmitting: (context, state) {
                          FocusScope.of(context).unfocus();
                        },
                        onSuccess: (context, state) {
                          print(state.successResponse);
                          GEMiscModel modelResponse = GEMiscModel.fromJson(jsonDecode(state.successResponse.toString()));

                          widget.onAdd!(
                              {
                                "data": modelResponse.toMap(),
                                "item" : ExpenseModel(type: GETypes.MISCELLANEOUS,amount: modelResponse.amount)
                              }
                          );
                          Navigator.pop(context);


                        },
                        onFailure: (context, state) {
                          print(state);

                        },
                        child: ScrollableFormBlocManager(
                          formBloc: formBloc!,
                          child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              children:[
                                Row(
                                  children: [
                                    Container(
                                      child: MetaDateTimeView(mapData: jsonData['checkInDateTime'],onChange: (value){
                                        formBloc!.checkInDate.updateValue(value.toString());
                                      }),
                                    ),
                                    Container(
                                      child: MetaDateTimeView(mapData: jsonData['checkOutDateTime'],onChange: (value){
                                        formBloc!.checkOutDate.updateValue(value.toString());
                                      }),
                                    ),
                                  ],
                                ),

                                Row(
                                    children: [
                                  Expanded(
                                    child: Container(
                                      child: MetaSearchSelectorView(mapData: jsonData['selectCity'],
                                        onChange:(value){
                                          formBloc!.cityName.updateValue(value.name);
                                          formBloc!.cityID.updateValue(value.id.toString());
                                        },),
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: MetaDialogSelectorView(mapData: jsonData['selectMiscType'],
                                        onChange:(value){
                                          formBloc!.miscName.updateValue(value.name);
                                          formBloc!.miscID.updateValue(value.id.toString());
                                        },),
                                    ),
                                  ),
                                ]),

                                Container(
                                  child: MetaSwitchBloc(
                                      mapData:  jsonData['unitType'],
                                      bloc:  formBloc!.swUnitType,
                                      onSwitchPressed: (value){
                                        formBloc!.swUnitType.updateValue(value);
                                      }),
                                ),

                                MetaTextFieldBlocView(mapData: jsonData['text_field_voucher'],
                                    textFieldBloc: formBloc!.tfVoucher,
                                    onChanged:(value){
                                      formBloc!.tfVoucher.updateValue(value);
                                    }),
                                Container(
                                  child: Row(
                                    children: [
                                          Expanded(
                                            child: MetaTextFieldBlocView(mapData: jsonData['text_field_amount'],
                                            textFieldBloc: formBloc!.tfAmount,
                                            onChanged:(value){
                                              formBloc!.tfAmount.updateValue(value);
                                            }),
                                          ),
                                        ],
                                  ),
                                ),
                                MetaTextFieldBlocView(mapData: jsonData['text_field_desc'],
                                    textFieldBloc: formBloc!.tfDescription,
                                    onChanged:(value){
                                      formBloc!.tfDescription.updateValue(value);
                                    }),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
                                  width: 180.w,
                                  child: MetaButton(mapData: jsonData['uploadButton'],
                                      onButtonPressed: (){

                                      }
                                  ),
                                )

                              ]
                          ),
                        )
                    ),
                  );
                }
              ),
            ),
          )

        ],
      ),
    );
  }

  void createMap() {
    Map<String,dynamic> saveMiscData = {
      "miscellaneousTypeName": "Incidental",
      "miscellaneousType": 213,
      "startDate": "05-01-2023",
      "endDate": "06-01-2023",
      "city": 1751,
      "cityName": "hyderabad",
      "amount": 500.0,
      "description": "",
      "voucherPath": "",
    };
    //  "id": 6,
    //  "withBill": false,
     // "violated": true,
     // "voilationMessage": "Expense will be sent for exceptional approval",


     // "voucherFile": null,


    //  "hsnCode": "",
    //  "gstNumber": "",
    //  "tax": 0.0,
    //  "cgst": 0.0,
    //  "sgst": 0.0,
    //  "igst": 0.0,
    //  "totalAmt": 500.0,
    //  "vendorName": "",
    //  "invoiceDate": "",
     // "cgstPrc": 0.0,
     // "sgstPrc": 0.0,
    //  "igstPrc": 0.0
  //  };
  }

  void otherValidations(json) {
    print(json);




  }


}
