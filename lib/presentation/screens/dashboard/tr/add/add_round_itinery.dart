import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/city_util.dart';
import 'package:travelgrid/data/datasources/tr_summary_response.dart';
import 'package:travelgrid/data/models/tr/tr_city_pair_model.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/bloc/tr_round_itinerary%20_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/date_time_view.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class AddRoundItinerary  extends StatelessWidget {
  Map<String,dynamic> jsonData = {};
  Function? onAdd;
  MaCityPairs? cityPairs1;
  MaCityPairs? cityPairs2;
  bool isEdit;
  String? tripType;
  AddRoundItinerary({required this.jsonData,this.onAdd,this.cityPairs1,this.cityPairs2,this.isEdit=false,this.tripType});


  RoundItineraryFormBloc?  formBloc;

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
      body: Container(
        color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
        child: Column(
          children: [
            SizedBox(height:40.h),
            Container(
              height: 40.h,
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
                    child:MetaTextView(mapData: jsonData['title'],text: "Add Round Itinerary Details",),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color:Colors.white,
                child: BlocProvider(
                  create: (context) => RoundItineraryFormBloc(jsonData),
                  child: Builder(
                      builder: (context) {


                        formBloc =  BlocProvider.of<RoundItineraryFormBloc>(context);
                        String  dateText = DateFormat('dd-MM-yyyy').format(DateTime.now());
                        formBloc!.checkInDate.updateValue(dateText);
                        formBloc!.checkInDate2.updateValue(dateText);
                        //formBloc!.checkInTime.updateValue("00:00");

                        if(tripType=="O"){
                          formBloc!.travelMode.updateValue("A");
                          formBloc!.travelModeID.updateValue("A");
                        }

                        return Container(
                          child: FormBlocListener<RoundItineraryFormBloc, String, String>(
                              onSubmissionFailed: (context, state) {
                                print(state);
                              },
                              onSubmitting: (context, state) {
                                FocusScope.of(context).unfocus();
                              },
                              onSuccess: (context, state) {
                                print(state.successResponse);
                                 TRCityPairModel modelResponse1 = TRCityPairModel.fromJson(jsonDecode(state.successResponse.toString())['pair1']);
                                 TRCityPairModel modelResponse2 = TRCityPairModel.fromJson(jsonDecode(state.successResponse.toString())['pair2']);

                                onAdd!(modelResponse1,modelResponse2);
                                Navigator.pop(context);
                              },
                              onFailure: (context, state) {

                                print(state);
                              },
                              child: ScrollableFormBlocManager(
                                formBloc: formBloc!,
                                child:Container(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10.h,),
                                        Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: MetaSearchSelectorView(
                                                    tripType,
                                                    mapData: jsonData['selectOrigin'],
                                                    text: CityUtil.getCityNameFromID(formBloc!.origin.value),
                                                    onChange:(value){
                                                      print(value);
                                                      formBloc!.origin.updateValue(value.id.toString());

                                                      formBloc!.destination2.updateValue(value.id.toString());
                                                    },),
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: MetaSearchSelectorView(
                                                    tripType,
                                                    mapData: jsonData['selectDestination'],
                                                    text: CityUtil.getCityNameFromID(formBloc!.destination.value),
                                                    onChange:(value){
                                                      formBloc!.destination.updateValue(value.id.toString());

                                                      formBloc!.origin2.updateValue(value.id.toString());
                                                    },),
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              ),
                                            ]),

                                        SizedBox(height: 10.h,),
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.h),
                                            color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                                            child: MetaTextView(mapData: jsonData['label'],text: "Onward Itinerary Details",)),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                                          child: ListView(
                                            padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              children:[

                                                Row(
                                                    children: [
                                                      tripType=="D"?
                                                      Expanded(
                                                        child: Container(
                                                          child: MetaDialogSelectorView(mapData: jsonData['selectMode'],
                                                            text :CityUtil.getTraveModeFromID(formBloc!.travelMode.value),
                                                            onChange:(value){
                                                              print(value);
                                                              formBloc!.travelMode.updateValue(value['id'].toString());
                                                              formBloc!.travelModeID.updateValue(value['id'].toString());
                                                              formBloc!.fareClass.updateValue("");
                                                            },),
                                                        ),
                                                      ):Expanded(
                                                        child: AbsorbPointer(
                                                          child: Container(
                                                            child: MetaDialogSelectorView(mapData: jsonData['selectMode'],
                                                              text :CityUtil.getTraveModeFromID(formBloc!.travelMode.value),
                                                              onChange:(value){
                                                                print(value);
                                                                formBloc!.travelMode.updateValue(value['id'].toString());
                                                                formBloc!.travelModeID.updateValue(value['id'].toString());
                                                                formBloc!.fareClass.updateValue("");
                                                              },),
                                                          ),
                                                        ),
                                                      ),

                                                      Expanded(
                                                        child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                                            bloc: formBloc!.travelModeID,
                                                            builder: (context, state) {
                                                              return Container(
                                                                child: MetaDialogSelectorView(mapData: jsonData['selectFare'],
                                                                  modeType: formBloc!.travelMode.value,
                                                                  text :CityUtil.getFareValueFromID(
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
                                                  child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                                      bloc: formBloc!.travelModeID,
                                                      builder: (context, state) {

                                                        if(formBloc!.travelModeID.value=="A"){
                                                          return  Container(
                                                            child: MetaSwitchBloc(
                                                                mapData:  jsonData['byCompanySwitch'],
                                                                bloc:  formBloc!.swByCompany,
                                                                onSwitchPressed: (value){
                                                                  //  formBloc!.selectWithBill.updateValue(value.toString());
                                                                  formBloc!.swByCompany.updateValue(value);
                                                                  formBloc!.swByCompanyID.updateValue(value);
                                                                }),
                                                          );
                                                        }

                                                        formBloc!.swByCompany.updateValue(false);
                                                        formBloc!.swByCompanyID.updateValue(false);

                                                        return  AbsorbPointer(
                                                          child: Container(
                                                            child: MetaSwitchBloc(
                                                                mapData:  jsonData['byCompanySwitch'],
                                                                bloc:  formBloc!.swByCompany,
                                                                onSwitchPressed: (value){

                                                                  formBloc!.swByCompany.updateValue(value);
                                                                  formBloc!.swByCompanyID.updateValue(value);
                                                                }),
                                                          ),
                                                        );

                                                      }
                                                  ),
                                                ),

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



                                                BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                                    bloc: formBloc!.swByCompanyID,
                                                    builder: (context, state) {

                                                      return  Visibility(
                                                        visible: !formBloc!.swByCompanyID.value! ,
                                                        child: Column(
                                                          children: [
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
                                                      );
                                                    }
                                                )


                                              ]
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.h),
                                            color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                                            child: MetaTextView(mapData: jsonData['label'],text: "Return Itinerary Details",)),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                                          child: ListView(
                                              padding: EdgeInsets.zero,
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              children:[
                                                // Row(
                                                //     children: [
                                                //       Expanded(
                                                //         child: Container(
                                                //           child: MetaSearchSelectorView(mapData: jsonData['selectOrigin'],
                                                //             text: CityUtil.getCityNameFromID(formBloc!.origin2.value),
                                                //             onChange:(value){
                                                //               print(value);
                                                //               formBloc!.origin2.updateValue(value.id.toString());
                                                //             },),
                                                //           alignment: Alignment.centerLeft,
                                                //         ),
                                                //       ),
                                                //       Expanded(
                                                //         child: Container(
                                                //           child: MetaSearchSelectorView(mapData: jsonData['selectDestination'],
                                                //             text: CityUtil.getCityNameFromID(formBloc!.destination2.value),
                                                //             onChange:(value){
                                                //               formBloc!.destination2.updateValue(value.id.toString());
                                                //             },),
                                                //           alignment: Alignment.centerLeft,
                                                //         ),
                                                //       ),
                                                //     ]),

                                                Row(
                                                    children: [
                                                      tripType=="D"?
                                                      Expanded(
                                                        child: Container(
                                                          child: MetaDialogSelectorView(mapData: jsonData['selectMode'],
                                                            text :CityUtil.getTraveModeFromID(formBloc!.travelMode2.value),
                                                            onChange:(value){
                                                              print(value);
                                                              formBloc!.travelMode2.updateValue(value['id'].toString());
                                                              formBloc!.travelModeID2.updateValue(value['id'].toString());
                                                              formBloc!.fareClass2.updateValue("");
                                                            },),
                                                        ),
                                                      ):Expanded(
                                                        child: AbsorbPointer(
                                                          child: Container(
                                                            child: MetaDialogSelectorView(mapData: jsonData['selectMode'],
                                                              text :CityUtil.getTraveModeFromID(formBloc!.travelMode2.value),
                                                              onChange:(value){
                                                                print(value);
                                                                formBloc!.travelMode2.updateValue(value['id'].toString());
                                                                formBloc!.travelModeID2.updateValue(value['id'].toString());
                                                                formBloc!.fareClass2.updateValue("");
                                                              },),
                                                          ),
                                                        ),
                                                      ),

                                                      Expanded(
                                                        child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                                            bloc: formBloc!.travelModeID2,
                                                            builder: (context, state) {
                                                              return Container(
                                                                child: MetaDialogSelectorView(mapData: jsonData['selectFare'],
                                                                  modeType: formBloc!.travelMode2.value,
                                                                  text :CityUtil.getFareValueFromID(
                                                                      formBloc!.fareClass2.value,
                                                                      formBloc!.travelMode2.value),
                                                                  onChange:(value){
                                                                    print(value);
                                                                    formBloc!.fareClass2.updateValue(value['id'].toString());
                                                                  },),
                                                              );
                                                            }
                                                        ),
                                                      ),
                                                    ]),

                                                Container(
                                                  child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                                      bloc: formBloc!.travelModeID2,
                                                      builder: (context, state) {

                                                        if(formBloc!.travelModeID2.value=="A"){
                                                          return  Container(
                                                            child: MetaSwitchBloc(
                                                                mapData:  jsonData['byCompanySwitch'],
                                                                bloc:  formBloc!.swByCompany2,
                                                                onSwitchPressed: (value){
                                                                  //  formBloc!.selectWithBill.updateValue(value.toString());
                                                                  formBloc!.swByCompany2.updateValue(value);
                                                                  formBloc!.swByCompanyID2.updateValue(value);
                                                                }),
                                                          );
                                                        }

                                                        formBloc!.swByCompany2.updateValue(false);
                                                        formBloc!.swByCompanyID2.updateValue(false);

                                                        return  AbsorbPointer(
                                                          child: Container(
                                                            child: MetaSwitchBloc(
                                                                mapData:  jsonData['byCompanySwitch'],
                                                                bloc:  formBloc!.swByCompany2,
                                                                onSwitchPressed: (value){

                                                                  formBloc!.swByCompany2.updateValue(value);
                                                                  formBloc!.swByCompanyID2.updateValue(value);
                                                                }),
                                                          ),
                                                        );

                                                      }
                                                  ),
                                                ),

                                                Container(
                                                  child: MetaDateTimeView(mapData: jsonData['checkInDateTime'],
                                                    value: {
                                                      "date": formBloc!.checkInDate2.value,
                                                      "time": formBloc!.checkInTime2.value,
                                                    },
                                                    onChange: (value){
                                                      print(value);
                                                      formBloc!.checkInDate2.updateValue(value['date'].toString());
                                                      formBloc!.checkInTime2.updateValue(value['time'].toString());
                                                    },),
                                                ),



                                                BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                                    bloc: formBloc!.swByCompanyID2,
                                                    builder: (context, state) {

                                                      return  Visibility(
                                                        visible: !formBloc!.swByCompanyID2.value! ,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: MetaTextFieldBlocView(mapData: jsonData['text_field_pnr'],
                                                                        textFieldBloc: formBloc!.tfPNR2,
                                                                        onChanged:(value){
                                                                          formBloc!.tfPNR2.updateValue(value);
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
                                                                        textFieldBloc: formBloc!.tfTicket2,
                                                                        onChanged:(value){
                                                                          formBloc!.tfTicket2.updateValue(value);
                                                                        }),
                                                                  ),
                                                                  SizedBox(width: 30.w,),

                                                                  Expanded(
                                                                    child: MetaTextFieldBlocView(mapData: jsonData['text_field_amount'],
                                                                        textFieldBloc: formBloc!.tfAmount2,
                                                                        onChanged:(value){
                                                                          formBloc!.tfAmount2.updateValue(value);
                                                                        }),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                      );
                                                    }
                                                )


                                              ]
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ),
                        );
                      }
                  ),
                ),
              ),
            ),
          ],
        ),
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
