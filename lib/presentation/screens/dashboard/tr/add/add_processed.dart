import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/city_util.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/bloc/tr_approval_form_bloc.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/bloc/tr_processed_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:travelgrid/presentation/widgets/toggle_button.dart';

class TrProcessed extends StatelessWidget {
  Function? onNext;
  TrProcessed({this.onNext});

  Map<String,dynamic> jsonData = {};
  ProcessedTrFormBloc?  formBloc;
  var map = {
    "text" : '',
    "color" : "0xFFFFFFFF",
    "size": "10",
    "family": "regular",
    "align" : "center"
  };
  final List<bool> steps = <bool>[true, false, false];
  List<Widget> items = [];
  List<String> segment = ["O","R","M"];
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.trAddProcessed;

    items=[
      MetaTextView(mapData: map,text: 'One-Way'),
      MetaTextView(mapData: map,text: 'Round'),
      MetaTextView(mapData: map,text: 'Multi'),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
      //  margin: EdgeInsets.symmetric(vertical: 20.h),
        child: BlocProvider(
          create: (context) => ProcessedTrFormBloc(jsonData),
          child: Builder(
              builder: (context) {


                formBloc =  BlocProvider.of<ProcessedTrFormBloc>(context);
                String  dateText = DateFormat('dd-MM-yyyy').format(DateTime.now());
                formBloc!.checkInDate.updateValue(dateText);
                //formBloc!.checkInTime.updateValue("00:00");
                formBloc!.segmentType.updateValue(segment[0]);
                return Container(

                  child: FormBlocListener<ProcessedTrFormBloc, String, String>(
                      onSubmissionFailed: (context, state) {
                        print(state);
                      },
                      onSubmitting: (context, state) {
                        FocusScope.of(context).unfocus();
                      },
                      onSuccess: (context, state) {
                        print(state.successResponse);
                        onNext!(jsonDecode(state.successResponse.toString()));
                        // GEAccomModel modelResponse = GEAccomModel.fromJson(jsonDecode(state.successResponse.toString()));
                        //
                        // widget.onAdd!(
                        //     {
                        //       "data": jsonDecode(state.successResponse.toString()),
                        //       "item" : ExpenseModel(type: GETypes.ACCOMMODATION,amount: modelResponse.amount.toString())
                        //     }
                        // );
                        // Navigator.pop(context);
                      },
                      onFailure: (context, state) {

                        print(state);
                      },
                      child: ScrollableFormBlocManager(
                        formBloc: formBloc!,
                        child:ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children:[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                  decoration: BoxDecoration(
                                    color: ParseDataType().getHexToColor(jsonData['backgroundColor']),
                                  //  borderRadius:  BorderRadius.all(Radius.circular(30)),
                                  ),
                                  alignment: Alignment.center,

                                  child: Container(
                                    height: 35.h,
                                    child: MetaToggleButton(
                                      type: 2,
                                      border: 30,
                                      onCheckPressed: (index){
                                        selected = index;
                                        formBloc!.segmentType.updateValue(segment[index]);
                                      },
                                      steps: steps,items: items,enabledColor:ParseDataType().getHexToColor(jsonData['backgroundColor']) ,),
                                  )
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                                child: Column(
                                  children: [
                                    Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: MetaSearchSelectorView(mapData: jsonData['selectOrigin'],
                                                text: CityUtil.getCityNameFromID(formBloc!.origin.value),
                                                onChange:(value){
                                                  print(value);
                                                  formBloc!.origin.updateValue(value.id.toString());
                                                },),
                                              alignment: Alignment.centerLeft,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: MetaSearchSelectorView(mapData: jsonData['selectDestination'],
                                                text: CityUtil.getCityNameFromID(formBloc!.destination.value),
                                                onChange:(value){
                                                  formBloc!.destination.updateValue(value.id.toString());
                                                },),
                                              alignment: Alignment.centerLeft,
                                            ),
                                          ),
                                        ]),
                                    Container(
                                      child: MetaSwitchBloc(
                                          mapData:  jsonData['byCompanySwitch'],
                                          bloc:  formBloc!.swByCompany,
                                          onSwitchPressed: (value){
                                          //  formBloc!.selectWithBill.updateValue(value.toString());
                                            formBloc!.swByCompany.updateValue(value);
                                          }),
                                    ),
                                    Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: MetaDialogSelectorView(mapData: jsonData['selectMode'],
                                                text :CityUtil.getTraveModeFromID(formBloc!.travelMode.value),
                                                onChange:(value){
                                                  print(value);
                                                  formBloc!.travelMode.updateValue(value['id'].toString());
                                                  formBloc!.travelModeID.updateValue(value['id'].toString());
                                                },),
                                            ),
                                          ),

                                          Expanded(
                                            child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                                bloc: formBloc!.travelModeID,
                                                builder: (context, state) {
                                                  return Container(
                                                    child: MetaDialogSelectorView(mapData: jsonData['selectFare'],
                                                      modeType: formBloc!.travelMode.value,
                                                      text :CityUtil.getFareNameFromID(
                                                          formBloc!.fareClass.value,
                                                          formBloc!.travelMode.value),
                                                      onChange:(value){
                                                        print(value);
                                                        formBloc!.fareClass.updateValue(value['id'].toString());
                                                      },),
                                                  );
                                                }
                                            ),
                                          ),
                                        ]),
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
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: MetaTextFieldBlocView(mapData: jsonData['text_field_pnr'],
                                                textFieldBloc: formBloc!.tfPNR,
                                                onChanged:(value){
                                                  formBloc!.tfPNR.updateValue(value);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: MetaTextFieldBlocView(mapData: jsonData['text_field_ticket'],
                                                textFieldBloc: formBloc!.tfTicket,
                                                onChanged:(value){
                                                  formBloc!.tfTicket.updateValue(value);
                                                }),
                                          ),
                                          SizedBox(width: 30.w,),

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

                                  ],
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
      ),
    );
  }

  procSubmit(){
    print('page1 submit');
    formBloc!.submit();
  }

  getInitialText(String text) {

    if(text.isNotEmpty){
      return text;
    }
    return null;
  }

}
