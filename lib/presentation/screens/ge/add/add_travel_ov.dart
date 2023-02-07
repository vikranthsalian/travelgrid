import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/models/ge_conveyance_model.dart';
import 'package:travelgrid/data/models/own_vehicle_model.dart';
import 'package:travelgrid/presentation/components/dialog_yes_no.dart';
import 'package:travelgrid/presentation/screens/ge/bloc/travel_ov_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';


class CreateTravelExpenseOV extends StatelessWidget {
  Function(List<MaGeConveyanceCityPair>)? onAdd;
  Function(Map)? onClose;
  Map<String,dynamic> jsonData;
  CreateTravelExpenseOV({this.onAdd,this.onClose,required this.jsonData});
  List<MaGeConveyanceCityPair> dataItems=[];
  TravelOVFormBloc?  formBloc;



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
                onButtonPressed: ()async{

                  if(dataItems.isNotEmpty){
                    await showDialog(
                        context: context,
                        builder: (_) => DialogYesNo(
                            title: "Are you sure you want to close, All Data will be lost.Please confirm before closing.",
                            onPressed: (value){

                              if(value == "YES"){
                                Navigator.pop(context);
                              }


                            }));
                  }else{
                   Navigator.pop(context);
                  }


                }
            ),
            MetaButton(mapData: jsonData['bottomButtonRight'],
                onButtonPressed: () async {

                  if(dataItems.isEmpty){
                    MetaAlert.showErrorAlert(message: "Please Add Own Vehicle Expesne");
                  }else{
                    Navigator.pop(context);
                    onAdd!(dataItems);
                  }


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
          Expanded(
            child: Container(
              child: BlocProvider(
                create: (context) => TravelOVFormBloc(jsonData),
                child: Builder(
                    builder: (context) {
                        formBloc =  BlocProvider.of<TravelOVFormBloc>(context);

                        String  dateText = DateFormat('dd-MM-yyyy').format(DateTime.now());

                        formBloc!.checkInDate.updateValue(dateText);

                        formBloc!.selectModeID.updateValue("193");
                        formBloc!.modeName.updateValue("Own Vehicle");

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: FormBlocListener<TravelOVFormBloc, String, String>(
                          onSubmissionFailed: (context, state) {
                            print(state);
                          },
                          onSubmitting: (context, state) {
                            FocusScope.of(context).unfocus();
                          },
                          onSuccess: (context, state) {

                            print(state.successResponse);
                            MaGeConveyanceCityPair modelResponse = MaGeConveyanceCityPair.fromJson(jsonDecode(state.successResponse.toString()));

                            dataItems.add(modelResponse);


                            formBloc!.onListLoaded.updateValue(dataItems);

                            formBloc!.clear();


                            formBloc!.checkInDate.updateValue(modelResponse.checkInDate.toString());


                            formBloc!.startTime.updateValue(modelResponse.endTime.toString());
                            formBloc!.startTimeWidget.updateValue(modelResponse.endTime.toString());

                            formBloc!.endTimeWidget.updateValue("00:00");
                            formBloc!.endTime.updateValue("00:00");


                            formBloc!.tfOrigin.updateValue(modelResponse.destination.toString());
                            formBloc!.tfDistance.updateValue("0");
                            formBloc!.tfAmount.updateValue("0");
                            formBloc!.onDataAdded.updateValue("Added");




                            print(dataItems.length);
                          },
                          onFailure: (context, state) {


                          },
                          child: ScrollableFormBlocManager(
                            formBloc: formBloc!,
                            child: ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                children:[
                                  Row(
                                    children: [

                                      Expanded(
                                        child: Container(
                                          child: MetaDialogSelectorView(mapData: jsonData['selectMode'],
                                            text :getInitialText(formBloc!.modeName.value),
                                            onChange:(data)async{
                                              print(data);

                                              await showDialog(
                                                  context: context,
                                                  builder: (_) => DialogYesNo(
                                                    title: "Are you sure you want to change Travel Mode, All Data will be lost.Please confirm before switching",
                                                      onPressed: (value){

                                                      if(value == "YES"){

                                                        onClose!(data);
                                                        print("onclose");

                                                        Navigator.pop(context);
                                                      }else{
                                                        formBloc!.selectModeID.updateValue("193");
                                                        formBloc!.modeName.updateValue("Own Vehicle");
                                                      }


                                              }));
                                            },),
                                        ),
                                      ),

                                      Expanded(
                                        child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                            bloc: formBloc!.onDataAdded,
                                            builder: (context, state) {
                                              return
                                                Container(
                                                  child: MetaDateTimeView(mapData: jsonData['checkInDateTime'],
                                                    isEnabled: state.value =="Added" ? false :true,
                                                    value: {
                                                      "date": formBloc!.checkInDate.value,
                                                      //  "time": formBloc!.checkInTime.value,
                                                    },
                                                    onChange: (value){
                                                      print(value);
                                                      formBloc!.checkInDate.updateValue(value['date'].toString());
                                                      //  formBloc!.checkInTime.updateValue(value['time'].toString());
                                                    },),
                                                );
                                            }
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child:
                                        BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                            bloc: formBloc!.startTimeWidget,
                                            builder: (context, state) {
                                              return
                                                Container(
                                                  child: MetaDateTimeView(mapData: jsonData['startTime'],
                                                    isEnabled: formBloc!.onDataAdded.value == "Added" ? false :true,
                                                    value: {
                                                      "date": {},
                                                      "time": formBloc!.startTime.value,
                                                    },
                                                    onChange: (value){
                                                      print(value);
                                                      // formBloc!.checkInDate.updateValue(value['date'].toString());
                                                      formBloc!.startTime.updateValue(value['time'].toString());
                                                    },),
                                                );
                                            }
                                        ),
                                      ),
                                      Expanded(
                                        child:
                                        BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                            bloc: formBloc!.endTimeWidget,
                                            builder: (context, state) {
                                              return Container(
                                                child: MetaDateTimeView(mapData: jsonData['endTime'],
                                                  value: {
                                                    "date": {},
                                                    "time": formBloc!.endTime.value,
                                                  },
                                                  onChange: (value){
                                                    print(value);
                                                    //    formBloc!.checkInDate.updateValue(value['date'].toString());
                                                    formBloc!.endTime.updateValue(value['time'].toString());
                                                    formBloc!.endTimeWidget.updateValue(value['time'].toString());

                                                  },),
                                              );
                                            }
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Expanded(
                                        child:
                                        BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                            bloc: formBloc!.onDataAdded,
                                            builder: (context, state) {
                                              return Container(
                                                  child:MetaTextFieldBlocView(mapData: jsonData['text_field_origin'],
                                                      textFieldBloc: formBloc!.tfOrigin,
                                                      isEnabled : state.value == "Added" ? false: true,
                                                      onChanged:(value){
                                                        formBloc!.tfOrigin.updateValue(value);
                                                      }),
                                                  alignment: Alignment.centerLeft,
                                                );
                                            }
                                        ),
                                      ),
                                      SizedBox(width: 10.w,),

                                      Expanded(
                                        child: Container(
                                          child:MetaTextFieldBlocView(mapData: jsonData['text_field_destination'],
                                              textFieldBloc: formBloc!.tfDestination,
                                              onChanged:(value){
                                                formBloc!.tfDestination.updateValue(value);
                                              }),
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ),
                                    ],
                                  ),
                                  MetaDialogSelectorView(mapData: jsonData['selectVehicleType'],
                                    text :getInitialText(formBloc!.vehicleTypeName.value),
                                    onChange:(value){
                                      print(value);
                                      formBloc!.vehicleTypeName.updateValue(value['text']);
                                      formBloc!.tfFuelPrice.updateValue(value['fuelPrice'].toString());

                                    },),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: MetaTextFieldBlocView(mapData: jsonData['text_field_distance'],
                                              textFieldBloc: formBloc!.tfDistance,
                                              onChanged:(value){
                                                formBloc!.tfDistance.updateValue(value);
                                              }),
                                        ),
                                      ),
                                      SizedBox(width: 10.w,),
                                      Expanded(
                                        child: Container(
                                          child: MetaTextFieldBlocView(mapData: jsonData['text_field_amount'],
                                              textFieldBloc: formBloc!.tfAmount,
                                              onChanged:(value){
                                                formBloc!.tfAmount.updateValue(value);
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),

                                  MetaButton(mapData: jsonData['addButton'],
                                      onButtonPressed: (){

                                        formBloc!.submit();

                                      }
                                  ),

                                  buildSummaryItemWidget(jsonData['summaryItems']),


                                ]
                            ),
                          )
                      ),
                    );
                  }
                ),
              ),
            ),
          )

        ],
      ),
    );
  }


  Container buildSummaryItemWidget(Map map) {
    List items =[];
    items =  map['dataHeader'];
    return Container(
      height: 200.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
      color: Colors.white,
      child: Column(
        children: [
          Container(
              child: Row(
                children: items.map((e) {
                  return Expanded(
                      flex: e['flex'],
                      child: Container(
                          child: MetaTextView(mapData: e)));
                }).toList(),
              )
          ),
          Divider(color: Color(0xff3D3D3D),),
          BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
              bloc: formBloc!.onListLoaded,
              builder: (context, state) {

                print("Rebuiding ListView");
                return  Container(
                  color: Colors.white,
                    child: state.value.isNotEmpty ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {

                        return Container(
                          height: 40.h,
                          margin: EdgeInsets.symmetric(vertical: 2.h),
                          child: Row(
                              children: [
                                Expanded(flex:1, child: MetaTextView(mapData: map['listView']['item']
                                    ,text: state.value[index].origin.toString() + "\n"+ "-"+state.value[index].destination.toString()) ),
                                Expanded(flex:1,child: MetaTextView(mapData: map['listView']['item']
                                    ,text:state.value[index].distance.toString() +" KM")),
                                Expanded(flex:1,child: MetaTextView(mapData: map['listView']['item']
                                    ,text:(state.value[index].startTime.toString() + "\n"+ "-"+state.value[index].endTime.toString()) )),
                                Expanded(flex:1,child: MetaTextView(mapData: map['listView']['item']
                                    ,text:state.value[index].amount.toString())),
                                Expanded(flex:1,child: InkWell(onTap: (){

                                },
                                    child: Container(
                                        width:25.w,
                                        height:25.w,
                                        child: MetaSVGView(mapData:  map['listView']['item']['svgIcon']))))
                              ]),
                        );
                      },
                      itemCount: state.value.length
                  ):Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MetaTextView(mapData: map['listView']['emptyData']['title']),
                    ],
                  ),
                );
              }
          )

        ],
      ),
    );
  }
  getInitialText(String text) {

    if(text.isNotEmpty){
      return text;
    }
    return null;
  }
}
