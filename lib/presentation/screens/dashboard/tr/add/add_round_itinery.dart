import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelex/common/constants/route_constants.dart';
import 'package:travelex/common/extensions/parse_data_type.dart';
import 'package:travelex/common/injector/injector.dart';
import 'package:travelex/common/utils/city_util.dart';
import 'package:travelex/common/utils/show_alert.dart';
import 'package:travelex/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelex/data/datasources/login_response.dart';
import 'package:travelex/data/datasources/others/flight_list.dart';
import 'package:travelex/data/datasources/summary/tr_summary_response.dart';
import 'package:travelex/data/models/success_model.dart';
import 'package:travelex/data/models/tr/tr_city_pair_model.dart';
import 'package:travelex/domain/usecases/tr_usecase.dart';
import 'package:travelex/presentation/screens/dashboard/tr/bloc/tr_round_itinerary%20_form_bloc.dart';
import 'package:travelex/presentation/widgets/button.dart';
import 'package:travelex/presentation/widgets/date_time_view.dart';
import 'package:travelex/presentation/widgets/dialog_selector_view.dart';
import 'package:travelex/presentation/widgets/icon.dart';
import 'package:travelex/presentation/widgets/search_selector_view.dart';
import 'package:travelex/presentation/widgets/svg_view.dart';
import 'package:travelex/presentation/widgets/switch.dart';
import 'package:travelex/presentation/widgets/text_field.dart';
import 'package:travelex/presentation/widgets/text_view.dart';

class AddRoundItinerary  extends StatelessWidget {
  Map<String,dynamic> jsonData = {};
  Function? onAdd;
  TRCityPairModel? cityPairs1;
  TRCityPairModel? cityPairs2;
  bool isEdit;
  String? tripType;
  String? paxCount;
  AddRoundItinerary({required this.jsonData,this.onAdd,this.cityPairs1,this.cityPairs2,this.isEdit=false,this.tripType,this.paxCount});


  RoundItineraryFormBloc?  formBloc;
  Map errorMap={
    "text" : '',
    "color" : "0xFFFFFFFF",
    "size": "10",
    "family": "regular",
    "align" : "center-left"
  };
  String errorMsg="";
  String errorMsg2="";
  MetaLoginResponse loginResponse = MetaLoginResponse();
  String? fromCode;
  String? toCode;

  @override
  Widget build(BuildContext context) {
    loginResponse = context.read<LoginCubit>().getLoginResponse();
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

                  if(formBloc!.tfAmount.valueToDouble == 0 && formBloc!.swByCompany.value == false){
                    MetaAlert.showErrorAlert(message: "Origin Amount value cannot be zero");
                    return;
                  }

                  if(formBloc!.tfAmount2.valueToDouble == 0 && formBloc!.swByCompany.value == false){
                    MetaAlert.showErrorAlert(message: "Destination Amount value cannot be zero");
                    return;
                  }


                  if(formBloc!.swByCompany.value && formBloc!.showFlightDetails.value==false && formBloc!.showFlightDetails2.value==false){
                    MetaAlert.showErrorAlert(message: "Please add Flight Details");
                    return;
                  }


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
                        formBloc!.travelMode.updateValue("A");
                        formBloc!.travelModeID.updateValue("A");
                        if(formBloc!.travelMode.value == "A"){
                          formBloc!.showFlightSearch.updateValue(true);
                          formBloc!.showFlightSearch2.updateValue(true);
                        }

                        formBloc!.swByCompany.updateValue(true);
                        formBloc!.swByCompanyID.updateValue(true);

                        // formBloc!.travelMode2.updateValue("A");
                        // formBloc!.travelModeID2.updateValue("A");
                        // formBloc!.swByCompany2.updateValue(true);
                        // formBloc!.swByCompanyID2.updateValue(true);

                        if(tripType=="O"){
                          formBloc!.travelMode.updateValue("A");
                          formBloc!.travelModeID.updateValue("A");
                        }

                        if(isEdit){

                          print(cityPairs1!.toJson());

                          formBloc!.origin.updateValue(cityPairs1!.leavingFrom!);
                          formBloc!.destination.updateValue(cityPairs1!.goingTo!);

                          formBloc!.checkInDate.updateValue(cityPairs1!.startDate!);
                          formBloc!.checkInTime.updateValue(cityPairs1!.startTime!);

                          formBloc!.travelMode.updateValue(cityPairs1!.travelMode!);
                          formBloc!.travelModeID.updateValue(cityPairs1!.travelMode!);


                          if(cityPairs1!.byCompany == 42){
                            formBloc!.swByCompany.updateValue(true);
                            formBloc!.swByCompanyID.updateValue(true);
                          }


                          fromCode = CityUtil.getCityNameFromID(formBloc!.origin.value,isCode: true);
                          toCode = CityUtil.getCityNameFromID(formBloc!.destination.value,isCode: true);
                          formBloc!.fareClass.updateValue(cityPairs1!.fareClass.toString());

                          String? fareClassKey = CityUtil.getFareValueFromID(
                            formBloc!.fareClass.value,
                            formBloc!.travelMode.value,
                            isValue:false,
                            showCode:true,
                          );
                          formBloc!.fareClassKey.updateValue(fareClassKey ?? "");

                          if(cityPairs1!.price!=null){
                            formBloc!.tfAmount.updateValue(cityPairs1!.price!.toString());
                          }
                          formBloc!.tfTicket.updateValue(cityPairs1!.ticket!);
                          formBloc!.tfPNR.updateValue(cityPairs1!.pnr!);

                          if(cityPairs1!.sbt == true){

                            formBloc!.showFlightDetails.updateValue(true);
                            formBloc!.showFlightSearch.updateValue(true);


                            formBloc!.flightPrice.updateValue(cityPairs1!.price.toString());

                            formBloc!.arrivalDate.updateValue(cityPairs1!.arrivalDate.toString());
                            formBloc!.arrivalTime.updateValue(cityPairs1!.arrivalTime.toString());

                            formBloc!.checkInDate.updateValue(cityPairs1!.startDate.toString());
                            formBloc!.checkInTime.updateValue(cityPairs1!.startTime.toString());

                            formBloc!.airlineCode.updateValue(cityPairs1!.airlinesCode.toString());
                            formBloc!.airline.updateValue(cityPairs1!.airlines.toString());
                            formBloc!.flightNo.updateValue(cityPairs1!.flightNo.toString());
                            formBloc!.stops.updateValue(cityPairs1!.numberOfStops.toString());
                            formBloc!.selectedFare.updateValue(cityPairs1!.selectedFare.toString());
                            formBloc!.sbt.updateValue(cityPairs1!.sbt!);

                          }






                          formBloc!.origin2.updateValue(cityPairs2!.leavingFrom!);
                          formBloc!.destination2.updateValue(cityPairs2!.goingTo!);

                          formBloc!.checkInDate2.updateValue(cityPairs2!.startDate!);
                          formBloc!.checkInTime2.updateValue(cityPairs2!.startTime!);
                          //
                          // formBloc!.travelMode2.updateValue(cityPairs2!.travelMode!);
                          // formBloc!.travelModeID2.updateValue(cityPairs2!.travelMode!);
                          //
                          //
                          // if(cityPairs2!.byCompany == 42){
                          //   formBloc!.swByCompany2.updateValue(true);
                          //   formBloc!.swByCompanyID2.updateValue(true);
                          // }
                          //
                          // formBloc!.fareClass2.updateValue(cityPairs2!.fareClass.toString());
                          if(cityPairs2!.price!=null){
                            formBloc!.tfAmount2.updateValue(cityPairs2!.price!.toString());
                          }
                          formBloc!.tfTicket2.updateValue(cityPairs2!.ticket!);
                          formBloc!.tfPNR2.updateValue(cityPairs2!.pnr!);


                          if(cityPairs2!.sbt == true){

                            formBloc!.showFlightDetails2.updateValue(true);
                            formBloc!.showFlightSearch2.updateValue(true);


                            formBloc!.flightPrice2.updateValue(cityPairs2!.price.toString());

                            formBloc!.arrivalDate2.updateValue(cityPairs2!.arrivalDate.toString());
                            formBloc!.arrivalTime2.updateValue(cityPairs2!.arrivalTime.toString());

                            formBloc!.checkInDate2.updateValue(cityPairs2!.startDate.toString());
                            formBloc!.checkInTime2.updateValue(cityPairs2!.startTime.toString());

                            formBloc!.airlineCode2.updateValue(cityPairs2!.airlinesCode.toString());
                            formBloc!.airline2.updateValue(cityPairs2!.airlines.toString());
                            formBloc!.flightNo2.updateValue(cityPairs2!.flightNo.toString());
                            formBloc!.stops2.updateValue(cityPairs2!.numberOfStops.toString());
                            formBloc!.selectedFare2.updateValue(cityPairs2!.selectedFare.toString());
                            formBloc!.sbt2.updateValue(cityPairs2!.sbt!);

                          }
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
                                                      fromCode=value.code;
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
                                                      toCode=value.code;
                                                      formBloc!.origin2.updateValue(value.id.toString());
                                                    },),
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              ),


                                            ]),

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
                                                      if(value['id']=="A"){
                                                        formBloc!.showFlightSearch.updateValue(true);
                                                      }else{
                                                        formBloc!.showFlightSearch.updateValue(false);
                                                        formBloc!.showFlightDetails.updateValue(false);
                                                      }
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
                                                              formBloc!.travelMode.value,
                                                              isValue: false
                                                          ),
                                                          onChange:(value)async{
                                                            print(value);
                                                            formBloc!.fareClass.updateValue(value['id'].toString());
                                                            formBloc!.fareClassKey.updateValue(value['value'].toString());

                                                            Map<String,dynamic> params = {
                                                              "tripTypeFC": tripType,
                                                              "gradeFC":loginResponse.data!.grade!.organizationGrade,
                                                              "travelModeFC":formBloc!.travelModeID.value,
                                                              "fareClassFC":value['value'],
                                                              "index":value['id'].toString(),
                                                            };

                                                            SuccessModel model =   await Injector.resolve<TrUseCase>().checkFireFareClassRule(params);

                                                            if(model.status! && model.message!=null){
                                                              print("seterror");
                                                              errorMsg = model.message.toString();
                                                              formBloc!.showError.updateValue(true);
                                                            }else{
                                                              errorMsg = "";
                                                              print("seterror false");
                                                              formBloc!.showError.updateValue(false);
                                                            }


                                                          },),
                                                      );
                                                    }
                                                ),
                                              ),
                                            ]),
                                        BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                            bloc: formBloc!.showError,
                                            builder: (context, state) {
                                              return Visibility(
                                                visible:state.value,
                                                child:Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                                    height: 20.h,
                                                    color: Color(0xFFB71C1C),
                                                    child: MetaTextView(mapData: errorMap,text: errorMsg)
                                                ),
                                              );
                                            }
                                        ),

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
                                                          if(value){
                                                            formBloc!.showFlightSearch.updateValue(true);
                                                            formBloc!.showFlightSearch2.updateValue(true);
                                                          }else{
                                                            formBloc!.showFlightSearch.updateValue(false);
                                                            formBloc!.showFlightSearch2.updateValue(false);
                                                            formBloc!.showFlightDetails.updateValue(false);
                                                            formBloc!.showFlightDetails2.updateValue(false);
                                                          }
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

                                        SizedBox(height: 10.h,),

                                        ...onwardDetails(),
                                        SizedBox(height: 5.h,),
                                        ...returnDetails(),

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


  List<Widget> getFlightView1() {
    return [


      SizedBox(height: 10.h,),
      BlocBuilder<BooleanFieldBloc, BooleanFieldBlocState>(
          bloc: formBloc!.showFlightDetails,
          builder: (context, state) {

            return   Visibility(
              visible: state.value,
              child: Container(
                child: Column(
                  children: [
                    MetaTextView(mapData: jsonData['flightLabel'],text: "Flight Details",),

                    Divider(color: Colors.black,),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              MetaTextView(mapData: jsonData['flightLabel'],text: "Flight Price",),
                              MetaTextView(mapData: jsonData['flightValue'],text:formBloc!.flightPrice.value),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              MetaTextView(mapData: jsonData['flightLabel'],text: "Arrival Date",),
                              MetaTextView(mapData: jsonData['flightValue'],text: formBloc!.arrivalDate.value),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              MetaTextView(mapData: jsonData['flightLabel'],text: "Arrival Time",),
                              MetaTextView(mapData: jsonData['flightValue'],text: formBloc!.arrivalTime.value),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              MetaTextView(mapData: jsonData['flightLabel'],text: "Flight No",),
                              MetaTextView(mapData: jsonData['flightValue'],text: formBloc!.flightNo.value),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              MetaTextView(mapData: jsonData['flightLabel'],text: "Airlines",),
                              MetaTextView(mapData: jsonData['flightValue'],text: formBloc!.airline.value),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              MetaTextView(mapData: jsonData['flightLabel'],text: "Selected Fare",),
                              MetaTextView(mapData: jsonData['flightValue'],text: formBloc!.selectedFare.value),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              MetaTextView(mapData: jsonData['flightLabel'],text: "No of Stops",),
                              MetaTextView(mapData: jsonData['flightValue'],text: formBloc!.stops.value),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: (){

                            formBloc!.showFlightDetails.updateValue(false);

                          },
                          child: Container(
                              width:25.w,
                              height:25.w,
                              child: MetaSVGView(mapData: jsonData['delete']))),
                    ),
                    Divider(color: Colors.black,),
                  ],
                ),
              ),
            );

          }
      ),
    ];
  }

  List<Widget> getFlightView2() {
    return [


      SizedBox(height: 10.h,),
      BlocBuilder<BooleanFieldBloc, BooleanFieldBlocState>(
          bloc: formBloc!.showFlightDetails2,
          builder: (context, state) {

            return   Visibility(
              visible: state.value,
              child: Container(
                child: Column(
                  children: [
                    MetaTextView(mapData: jsonData['flightLabel'],text: "Flight Details",),

                    Divider(color: Colors.black,),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              MetaTextView(mapData: jsonData['flightLabel'],text: "Flight Price",),
                              MetaTextView(mapData: jsonData['flightValue'],text:formBloc!.flightPrice2.value),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              MetaTextView(mapData: jsonData['flightLabel'],text: "Arrival Date",),
                              MetaTextView(mapData: jsonData['flightValue'],text: formBloc!.arrivalDate2.value),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              MetaTextView(mapData: jsonData['flightLabel'],text: "Arrival Time",),
                              MetaTextView(mapData: jsonData['flightValue'],text: formBloc!.arrivalTime2.value),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              MetaTextView(mapData: jsonData['flightLabel'],text: "Flight No",),
                              MetaTextView(mapData: jsonData['flightValue'],text: formBloc!.flightNo2.value),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              MetaTextView(mapData: jsonData['flightLabel'],text: "Airlines",),
                              MetaTextView(mapData: jsonData['flightValue'],text: formBloc!.airline2.value),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              MetaTextView(mapData: jsonData['flightLabel'],text: "Selected Fare",),
                              MetaTextView(mapData: jsonData['flightValue'],text: formBloc!.selectedFare2.value),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              MetaTextView(mapData: jsonData['flightLabel'],text: "No of Stops",),
                              MetaTextView(mapData: jsonData['flightValue'],text: formBloc!.stops2.value),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: (){

                            formBloc!.showFlightDetails2.updateValue(false);

                          },
                          child: Container(
                              width:25.w,
                              height:25.w,
                              child: MetaSVGView(mapData: jsonData['delete']))),
                    ),
                    Divider(color: Colors.black,),
                  ],
                ),
              ),
            );

          }
      ),
    ];
  }

  onwardDetails() {
    return [
      Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.h),
          color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
          child: MetaTextView(mapData: jsonData['label'],color: Colors.white,text: "Onward Itinerary Details",)),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children:[
              SizedBox(height: 10.h,),
              BlocBuilder<BooleanFieldBloc, BooleanFieldBlocState>(
                  bloc: formBloc!.showFlightSearch,
                  builder: (context, state) {

                    return Visibility(
                      visible: state.value,
                      child:   Container(
                        child:InkWell(
                            onTap:()async{

                              if(fromCode == null || toCode == null){
                                MetaAlert.showErrorAlert(message: "Please select fields");
                                return;
                              }

                              if( formBloc!.fareClassKey.value.isEmpty){
                                MetaAlert.showErrorAlert(message: "Please select Fare Class");
                                return;
                              }


                              if(fromCode!.isNotEmpty && toCode!.isNotEmpty && formBloc!.checkInDate.value.isNotEmpty)
                              {
                                var data = await Navigator.of(context).pushNamed(RouteConstants.flightPath,
                                    arguments: {
                                      "from":fromCode,
                                      "to": toCode,
                                      "paxCount": paxCount,
                                      "fareClass": formBloc!.fareClassKey.value,
                                      "date":formBloc!.checkInDate.value,
                                    });

                                AirFareResults airFareResults  = data as AirFareResults;

                                print("flightData");
                                print(jsonEncode(airFareResults));
                                if(airFareResults.origin!=null){
                                  formBloc!.showFlightDetails.updateValue(true);


                                  formBloc!.flightPrice.updateValue(airFareResults.selectedPrice!);

                                  formBloc!.arrivalDate.updateValue(airFareResults.arrivalDate ?? "");
                                  formBloc!.arrivalTime.updateValue(airFareResults.arrivalTime ?? "");

                                  formBloc!.checkInDate.updateValue(airFareResults.departureDate ?? "");
                                  formBloc!.checkInTime.updateValue(airFareResults.departureTime ?? "");

                                  formBloc!.airlineCode.updateValue(airFareResults.carrierCode!);
                                  formBloc!.airline.updateValue(airFareResults.carrierName!);
                                  formBloc!.flightNo.updateValue(airFareResults.flightNumber!);
                                  formBloc!.stops.updateValue(airFareResults.totalStops.toString());
                                  formBloc!.sbt.updateValue(true);
                                  formBloc!.selectedFare.updateValue(airFareResults.selectedFare!);
                                  formBloc!.timeField.updateValue(airFareResults.departureTime ?? "");
                                }
                              }else{
                                MetaAlert.showErrorAlert(message: "Flight Search Not Available for selected cities");
                              }
                            },
                            child:Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  height: 35.w,
                                  width: 35.w,
                                  child:MetaSVGView(mapData: jsonData['flightSvgIcon'])
                              ),
                            )),
                      ),
                    );

                  }
              ),


              BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                  bloc: formBloc!.timeField,
                  builder: (context, state) {

                    print("MetaDateTimeView rebuild");
                    print(formBloc!.checkInDate.value);
                    print(formBloc!.checkInTime.value);

                    return Container(
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
                    );

                  }
              ),

              ...getFlightView1(),

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
    ];
  }

  returnDetails() {
    print("returnDetails");
    print( jsonData['label']);
    return [
      Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.h),
          color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
          child: MetaTextView(mapData: jsonData['label'],color: Colors.white,text: "Return Itinerary Details",)),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: ListView(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children:[
              // Row(
              //     children: [
              //       tripType=="D"?
              //       Expanded(
              //         child: Container(
              //           child: MetaDialogSelectorView(mapData: jsonData['selectMode'],
              //             text :CityUtil.getTraveModeFromID(formBloc!.travelMode2.value),
              //             onChange:(value){
              //               print(value);
              //               formBloc!.travelMode2.updateValue(value['id'].toString());
              //               formBloc!.travelModeID2.updateValue(value['id'].toString());
              //               formBloc!.fareClass2.updateValue("");
              //             },),
              //         ),
              //       ):Expanded(
              //         child: AbsorbPointer(
              //           child: Container(
              //             child: MetaDialogSelectorView(mapData: jsonData['selectMode'],
              //               text :CityUtil.getTraveModeFromID(formBloc!.travelMode2.value),
              //               onChange:(value){
              //                 print(value);
              //                 formBloc!.travelMode2.updateValue(value['id'].toString());
              //                 formBloc!.travelModeID2.updateValue(value['id'].toString());
              //                 formBloc!.fareClass2.updateValue("");
              //               },),
              //           ),
              //         ),
              //       ),
              //
              //       Expanded(
              //         child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
              //             bloc: formBloc!.travelModeID2,
              //             builder: (context, state) {
              //               return Container(
              //                 child: MetaDialogSelectorView(mapData: jsonData['selectFare'],
              //                   modeType: formBloc!.travelMode2.value,
              //                   text :CityUtil.getFareValueFromID(
              //                       formBloc!.fareClass2.value,
              //                       formBloc!.travelMode2.value,
              //                       isValue: false
              //                   ),
              //                   onChange:(value)async{
              //                     print(value);
              //                     formBloc!.fareClass2.updateValue(value['id'].toString());
              //                     formBloc!.fareClassKey2.updateValue(value['value'].toString());
              //
              //
              //                     Map<String,dynamic> params = {
              //                       "tripTypeFC": tripType,
              //                       "gradeFC":loginResponse.data!.grade!.organizationGrade,
              //                       "travelModeFC":formBloc!.travelModeID.value,
              //                       "fareClassFC":value['value'],
              //                       "index":value['id'].toString(),
              //                     };
              //
              //                     SuccessModel model =   await Injector.resolve<TrUseCase>().checkFireFareClassRule(params);
              //
              //                     if(model.status! && model.message!=null){
              //                       print("seterror");
              //                       errorMsg2 = model.message.toString();
              //                       formBloc!.showError2.updateValue(true);
              //                     }else{
              //                       errorMsg2 = "";
              //                       print("seterror false");
              //                       formBloc!.showError2.updateValue(false);
              //                     }
              //
              //                   },),
              //               );
              //             }
              //         ),
              //       ),
              //     ]),
              // BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
              //     bloc: formBloc!.showError2,
              //     builder: (context, state) {
              //       return Visibility(
              //         visible:state.value,
              //         child:Container(
              //             padding: EdgeInsets.symmetric(horizontal: 10.w),
              //             height: 20.h,
              //             color: Color(0xFFB71C1C),
              //             child: MetaTextView(mapData: errorMap,text: errorMsg2)
              //         ),
              //       );
              //     }
              // ),
              //
              // Container(
              //   child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
              //       bloc: formBloc!.travelModeID2,
              //       builder: (context, state) {
              //
              //         if(formBloc!.travelModeID2.value=="A"){
              //           return  Container(
              //             child: MetaSwitchBloc(
              //                 mapData:  jsonData['byCompanySwitch'],
              //                 bloc:  formBloc!.swByCompany2,
              //                 onSwitchPressed: (value){
              //                   //  formBloc!.selectWithBill.updateValue(value.toString());
              //                   formBloc!.swByCompany2.updateValue(value);
              //                   formBloc!.swByCompanyID2.updateValue(value);
              //                 }),
              //           );
              //         }
              //
              //         formBloc!.swByCompany2.updateValue(false);
              //         formBloc!.swByCompanyID2.updateValue(false);
              //
              //         return  AbsorbPointer(
              //           child: Container(
              //             child: MetaSwitchBloc(
              //                 mapData:  jsonData['byCompanySwitch'],
              //                 bloc:  formBloc!.swByCompany2,
              //                 onSwitchPressed: (value){
              //
              //                   formBloc!.swByCompany2.updateValue(value);
              //                   formBloc!.swByCompanyID2.updateValue(value);
              //                 }),
              //           ),
              //         );
              //
              //       }
              //   ),
              // ),
              SizedBox(height: 10.h,),
              BlocBuilder<BooleanFieldBloc, BooleanFieldBlocState>(
                  bloc: formBloc!.showFlightSearch2,
                  builder: (context, state) {

                    return Visibility(
                      visible: state.value,
                      child:   Container(
                        child:InkWell(
                            onTap:()async{

                              if(fromCode == null ||toCode == null){
                                MetaAlert.showErrorAlert(message: "Please select fields");
                                return;
                              }

                              if( formBloc!.fareClassKey.value.isEmpty){
                                MetaAlert.showErrorAlert(message: "Please select Fare Class");
                                return;
                              }


                              if(fromCode!.isNotEmpty && toCode!.isNotEmpty && formBloc!.checkInDate2.value.isNotEmpty)
                              {
                                var data = await Navigator.of(context).pushNamed(RouteConstants.flightPath,
                                    arguments: {
                                      "from":toCode,
                                      "to": fromCode,
                                      "paxCount": paxCount,
                                      "fareClass": formBloc!.fareClassKey.value,
                                      "date":formBloc!.checkInDate2.value,
                                    });

                                AirFareResults airFareResults  = data as AirFareResults;

                                print("flightData");
                                print(jsonEncode(airFareResults));
                                if(airFareResults.origin!=null){
                                  formBloc!.showFlightDetails2.updateValue(true);


                                  formBloc!.flightPrice2.updateValue(airFareResults.selectedPrice!);

                                  formBloc!.arrivalDate2.updateValue(airFareResults.arrivalDate ?? "");
                                  formBloc!.arrivalTime2.updateValue(airFareResults.arrivalTime ?? "");

                                  formBloc!.checkInDate2.updateValue(airFareResults.departureDate ?? "");
                                  formBloc!.checkInTime2.updateValue(airFareResults.departureTime ?? "");

                                  formBloc!.airlineCode2.updateValue(airFareResults.carrierCode!);
                                  formBloc!.airline2.updateValue(airFareResults.carrierName!);
                                  formBloc!.flightNo2.updateValue(airFareResults.flightNumber!);
                                  formBloc!.stops2.updateValue(airFareResults.totalStops.toString());
                                  formBloc!.sbt2.updateValue(true);
                                  formBloc!.selectedFare2.updateValue(airFareResults.selectedFare!);
                                  formBloc!.timeField2.updateValue(airFareResults.departureTime ?? "");
                                }
                              }else{
                                MetaAlert.showErrorAlert(message: "Flight Search Not Available for selected cities");
                              }
                            },
                            child:Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  height: 35.w,
                                  width: 35.w,
                                  child:MetaSVGView(mapData: jsonData['flightSvgIcon'])
                              ),
                            )),
                      ),
                    );

                  }
              ),

              BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                  bloc: formBloc!.timeField2,
                  builder: (context, state) {

                    print("MetaDateTimeView rebuild");
                    print(formBloc!.checkInDate2.value);
                    print(formBloc!.checkInTime2.value);

                    return Container(
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
                    );

                  }
              ),


              // Container(
              //   child: MetaDateTimeView(mapData: jsonData['checkInDateTime'],
              //     value: {
              //       "date": formBloc!.checkInDate2.value,
              //       "time": formBloc!.checkInTime2.value,
              //     },
              //     onChange: (value){
              //       print(value);
              //       formBloc!.checkInDate2.updateValue(value['date'].toString());
              //       formBloc!.checkInTime2.updateValue(value['time'].toString());
              //     },),
              // ),




              ...getFlightView2(),



              //editboxes
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
      )
    ];
  }




  getInitialText(String text) {

    if(text.isNotEmpty){
      return text;
    }
    return null;
  }


}
