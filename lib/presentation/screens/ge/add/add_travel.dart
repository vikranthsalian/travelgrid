import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/enum/dropdown_types.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/data/models/expense_model.dart';
import 'package:travelgrid/data/models/ge_conveyance_model.dart';
import 'package:travelgrid/presentation/screens/ge/bloc/travel_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class CreateTravelExpense extends StatefulWidget {
  Function(Map)? onAdd;
  bool isEdit;
  GeConveyanceModel? conveyanceModel;
  CreateTravelExpense({this.onAdd,this.isEdit=false,this.conveyanceModel});
  @override
  _CreateTravelExpenseState createState() => _CreateTravelExpenseState();
}

class _CreateTravelExpenseState extends State<CreateTravelExpense> {
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;
  bool loaded=false;
  bool showWithBill=true;
  TravelFormBloc?  formBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.travelCreateData;
   // prettyPrint(jsonData);

   // createMapData();
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
              create: (context) => TravelFormBloc(jsonData),
              child: Builder(
                  builder: (context) {
                      formBloc =  BlocProvider.of<TravelFormBloc>(context);

                    if(widget.isEdit){

                      print(widget.conveyanceModel!.toJson());

                      formBloc!.checkInDate.updateValue(widget.conveyanceModel!.conveyanceDate.toString());
                    //  formBloc!.checkOutDate.updateValue(widget.conveyanceModel!.endDate.toString());

                      formBloc!.tfOrigin.updateValue(widget.conveyanceModel!.origin.toString());
                      formBloc!.tfDestination.updateValue(widget.conveyanceModel!.destination.toString());

                      formBloc!.selectModeID.updateValue(widget.conveyanceModel!.travelMode.toString());
                      formBloc!.modeName.updateValue(widget.conveyanceModel!.travelModeName.toString());


                    //  formBloc!.unitTypeName.updateValue("test");
                    //  formBloc!.unitTypeID.updateValue(widget.conveyanceModel!.unitType.toString());

                      formBloc!.tfVoucher.updateValue(widget.conveyanceModel!.voucherNumber.toString());
                      if(widget.conveyanceModel!.voucherNumber.toString().isEmpty){
                        formBloc!.tfVoucher.updateValue("nill");
                      }


                      formBloc!.tfAmount.updateValue(widget.conveyanceModel!.amount.toString());
                      formBloc!.tfDescription.updateValue(widget.conveyanceModel!.description.toString());
                    }else{

                      String  dateText = DateFormat('dd-MM-yyyy').format(DateTime.now());

                      formBloc!.checkInDate.updateValue(dateText);
                    }
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: FormBlocListener<TravelFormBloc, String, String>(
                        onSubmissionFailed: (context, state) {
                          print(state);
                        },
                        onSubmitting: (context, state) {
                          FocusScope.of(context).unfocus();
                        },
                        onSuccess: (context, state) {

                          print(state.successResponse);
                          GeConveyanceModel modelResponse = GeConveyanceModel.fromJson(jsonDecode(state.successResponse.toString()));

                          widget.onAdd!(
                              {
                                "data": jsonDecode(state.successResponse.toString()),
                                "item" : ExpenseModel(type: GETypes.CONVEYANCE,amount: modelResponse.amount.toString())
                              }
                          );
                          Navigator.pop(context);
                        },
                        onFailure: (context, state) {


                        },
                        child: ScrollableFormBlocManager(
                          formBloc: formBloc!,
                          child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              children:[
                                Container(
                                  child: MetaDateTimeView(mapData: jsonData['checkInDateTime'],
                                    value: {
                                      "date": formBloc!.checkInDate.value,
                                      "time": formBloc!.checkInTime.value,
                                    },
                                    onChange: (value){
                                      print(value);
                                      formBloc!.checkInDate.updateValue(value['date'].toString());
                                      formBloc!.checkInTime.updateValue(value['time'].toString());
                                    },),
                                ),
                                Container(
                                  child:MetaTextFieldBlocView(mapData: jsonData['text_field_origin'],
                                      textFieldBloc: formBloc!.tfOrigin,
                                      onChanged:(value){
                                        formBloc!.tfOrigin.updateValue(value);
                                      }),
                                  alignment: Alignment.centerLeft,
                                ),
                                Container(
                                  child:MetaTextFieldBlocView(mapData: jsonData['text_field_destination'],
                                      textFieldBloc: formBloc!.tfDestination,
                                      onChanged:(value){
                                        formBloc!.tfDestination.updateValue(value);
                                      }),
                                  alignment: Alignment.centerLeft,
                                ),

                                Container(
                                  child:Container(
                                    child: MetaDialogSelectorView(mapData: jsonData['selectMode'],
                                      text :getInitialText(formBloc!.modeName.value),
                                      onChange:(value){
                                        print(value);
                                        formBloc!.selectModeID.updateValue(value['id'].toString());
                                        formBloc!.modeName.updateValue(value['label']);
                                      },),
                                  ) ,
                                ),
                                BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                    bloc: formBloc!.selectModeID,
                                    builder: (context, state) {
                                      return Visibility(
                                        visible: state.value == "212" ? true : false,
                                        child:MetaDialogSelectorView(mapData: jsonData['selectVehicleType'],
                                          text :getInitialText(formBloc!.VehicleTypeName.value),
                                          onChange:(value){
                                            print(value);
                                            formBloc!.VehicleTypeName.updateValue(value['text']);

                                          },),
                                      );
                                    }
                                ),
                                BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                    bloc: formBloc!.selectWithBill,
                                    builder: (context, state) {
                                      return
                                        Visibility(
                                          visible: state.value == "true" ? true : false,
                                          child:MetaTextFieldBlocView(mapData: jsonData['text_field_voucher'],
                                              textFieldBloc: formBloc!.tfVoucher,
                                              onChanged:(value){
                                                formBloc!.tfVoucher.updateValue(value);
                                              }),
                                        );
                                    }
                                ),
                                Container(
                                  child: MetaTextFieldBlocView(mapData: jsonData['text_field_amount'],
                                      textFieldBloc: formBloc!.tfAmount,
                                      onChanged:(value){
                                        formBloc!.tfAmount.updateValue(value);
                                      }),
                                ),
                                MetaTextFieldBlocView(mapData: jsonData['text_field_desc'],
                                    textFieldBloc: formBloc!.tfDescription,
                                    onChanged:(value){
                                      formBloc!.tfDescription.updateValue(value);
                                    }),
                                Container(
                                  child: MetaSwitchBloc(
                                      mapData:  jsonData['withBillCheckBox'],
                                      bloc:  formBloc!.swWithBill,
                                      onSwitchPressed: (value){
                                        formBloc!.selectWithBill.updateValue(value.toString());
                                        formBloc!.swWithBill.updateValue(value);
                                      }),
                                ),
                                Row(
                                  children: [

                                    showWithBill ? Container(
                                      margin: EdgeInsets.symmetric(vertical: 20.h),
                                      width: 180.w,
                                      child: MetaButton(mapData: jsonData['uploadButton'],
                                          onButtonPressed: (){

                                          }
                                      ),
                                    ):SizedBox(),
                                  ],
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

  void createMapData() {
    Map<String,dynamic> saveTravelData = {
      "conveyanceDate": "06-01-2023",
      "origin": "cbi",
      "destination": "hebbal",
      "travelMode": 193,
      "travelModeName": "Own Vehicle",
      "amount": 1000.0,
      "description": "",
      "voucherNumber": "",
      "withBill": false,
      "voucherPath": "",
      "voucherFile": null,
    };
  }
  getInitialText(String text) {

    if(text.isNotEmpty){
      return text;
    }
    return null;
  }

}
