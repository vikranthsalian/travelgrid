import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/location.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/datsources/lat_long_distance_model.dart';
import 'package:travelgrid/data/models/ge_conveyance_model.dart';
import 'package:travelgrid/data/models/location_model.dart';
import 'package:travelgrid/domain/usecases/common_usecase.dart';
import 'package:travelgrid/presentation/components/dialog_type.dart';
import 'package:travelgrid/presentation/components/dialog_yes_no.dart';
import 'package:travelgrid/presentation/screens/common/common_type_screen.dart';
import 'package:travelgrid/presentation/screens/ge/bloc/travel_ov_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/checkbox.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:tuple/tuple.dart';


class CreateTravelExpenseOV extends StatelessWidget {

  Function(List<MaGeConveyanceCityPair>,String)? onAdd;
  Function(Map)? onClose;
  Map<String,dynamic> jsonData;
  CreateTravelExpenseOV({this.onAdd,this.onClose,required this.jsonData});
  List<MaGeConveyanceCityPair> dataItems=[];
  List<LocationModel> locationItems=[];
  List<LocationModel> slots=[];
  TravelOVFormBloc?  formBloc;
  String? date;



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
                    MetaAlert.showErrorAlert(message: "Please Add Own Vehicle Expense");
                  }else{
                    Navigator.pop(context);
                    onAdd!(dataItems,date!);
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
                            date = formBloc!.checkInDate.value;
                            dataItems.add(modelResponse);


                            formBloc!.onListLoaded.updateValue(dataItems);

                            formBloc!.clear();


                          //  formBloc!.checkInDate.updateValue(modelResponse.checkInDate.toString());


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
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children:[
                                  BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                      bloc: formBloc!.onAutoSelected,
                                      builder: (context, state) {
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile(
                                                    title: Text("Auto"),
                                                    value: "auto",
                                                    groupValue: formBloc!.onAutoSelected.value,
                                                    onChanged: (value){
                                                      print(value);
                                                      formBloc!.onAutoSelected.updateValue(value!);
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile(
                                                    title: Text("Manual"),
                                                    value: "manual",
                                                    groupValue: formBloc!.onAutoSelected.value,
                                                    onChanged: (value){
                                                      print(value);
                                                      formBloc!.onAutoSelected.updateValue(value!);
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),

                                            getManualWidgets(context),
                                          ],
                                        );
                                      }
                                  ),
                                  SizedBox(height: 10.h,),


                                  MetaButton(mapData: jsonData['addButton'],
                                      onButtonPressed: ()async{

                                        if(formBloc!.onAutoSelected.value=="auto"){
                                          int count=0;
                                          for(var item in formBloc!.onLocationAdded.value!){
                                            if(item.isChecked == true){
                                              count++;
                                            }
                                          }
                                          if(count == 2){
                                            List<LocationModel>? list=[];
                                            for(var item in formBloc!.onLocationAdded.value!){
                                              if(item.isChecked == true){
                                                list.add(item);
                                              }
                                            }

                                            await showDialog(
                                                context: context,
                                                builder: (_) => DialogType(
                                                  size: 0.3,
                                                  child: CommonTypeScreen(
                                                      mapData: jsonData['selectVehicleType'],
                                                      onTap:(value)async{
                                                       formBloc!.vehicleTypeName.updateValue(value['id']);

                                                        formBloc!.travelModeID.updateValue("193");
                                                      //  formBloc!.checkInDate.updateValue(list[0].date!);
                                                        formBloc!.startTime.updateValue(list[0].time!);
                                                        formBloc!.endTime.updateValue(list[1].time!);

                                                        formBloc!.tfOrigin.updateValue(list[0].location!);
                                                        formBloc!.tfDestination.updateValue(list[1].location!);

                                                        formBloc!.tfFuelPrice.updateValue(value['fuelPrice'].toString());

                                                        MetaLatLongDistanceModel model =  await Injector.resolve<CommonUseCase>().getDistance("12.972442,77.580643","13.067439,80.237617");

                                                        if(model.routes!.isNotEmpty){
                                                          if(model.routes![0].sections!.isNotEmpty){
                                                           int? meters = model.routes![0].sections![0].summary!.length ?? 0;

                                                           double? distanceInMeters = meters.toDouble();
                                                           double distanceInKiloMeters = distanceInMeters / 1000;
                                                           double roundDistanceInKM = double.parse((distanceInKiloMeters).toStringAsFixed(2));

                                                           formBloc!.tfDistance.updateValue(roundDistanceInKM.toString());
                                                           formBloc!.tfAmount.updateValue((roundDistanceInKM *   formBloc!.tfFuelPrice.valueToInt!).toString());
                                                         }
                                                        }
                                                        //
                                                        //

                                                        //
                                                        // print("sdadksa");

                                                        formBloc!.submit();

                                                      }),
                                                ));
                                          }else{
                                            MetaAlert.showErrorAlert(message: "Select 2 items");
                                          }

                                        }else{
                                          formBloc!.submit();
                                        }





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

   getManualWidgets(context){

     if(formBloc!.onAutoSelected.value == "auto"){
       print("jsonData['locationItems']");
       print(jsonData['locationItems']['saveButton']);
       return BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
           bloc: formBloc!.onLocationAdded,
           builder: (context, state) {
             return  locationItemWidget(jsonData['locationItems'],formBloc!.onLocationAdded.value);
           }
       );
     }else{
       return [
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
             formBloc!.travelModeID.updateValue(value['id'].toString());

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
       ]  ;
     }

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

                                },child: Container(
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

  Container locationItemWidget(Map map,List<LocationModel>? list) {
    List items =[];
    items =  map['dataHeader'];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
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
          Container(
            height: 200.h,
            color: Colors.white,
            child: list!.isNotEmpty ? ListView.builder(

                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int i) {

                  return Container(
                    height: 40.h,
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                    child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 5.w,left: 5.w),
                            height:20.w,
                            width: 20.w,
                            child: MetaCheckBox(
                                mapData:map['listView']['checkbox'],
                                value:list[i].isChecked,
                                onCheckPressed: (bool? value){
                                  list[i].isChecked = value;
                                }),
                          ),
                          Expanded(
                              flex:3,
                              child: MetaTextView(mapData: map['listView']['item'],
                                  text: list[i].location)),
                          Expanded(
                              flex:2,
                              child: MetaTextView(mapData: map['listView']['item'],
                                  text: list[i].date! + "\n" +list[i].time!
                              )),
                          Container(
                              width:25.w,
                              height:25.w,
                              child: MetaSVGView(mapData:  map['listView']['item']['svgIcon']))
                        ]),
                  );
                },
                itemCount: list.length
            ):Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MetaTextView(mapData: map['listView']['emptyData']['title']),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: MetaButton(mapData: jsonData['locationItems']['saveButton'],
                onButtonPressed: ()async{

                  Tuple2<Position,String> data = await LocationUtils().determinePosition();

                  locationItems.add(LocationModel(latitude:data.item1.latitude ,
                      location: data.item2,
                      longitude:data.item1.longitude ,
                      time :DateFormat('hh:mm').format(DateTime.now()),
                      date: DateFormat('dd-MM-y').format(DateTime.now())
                  ));
                  formBloc!.onLocationAdded.clear();
                  formBloc!.onLocationAdded.changeValue(locationItems);

                }
            ),
          ),
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
