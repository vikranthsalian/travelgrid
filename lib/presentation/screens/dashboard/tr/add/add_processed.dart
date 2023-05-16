import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/capitalize.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/city_util.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/datasources/summary/tr_summary_response.dart';
import 'package:travelgrid/data/models/tr/tr_city_pair_model.dart';
import 'package:travelgrid/data/models/tr/tr_forex_model.dart';
import 'package:travelgrid/data/models/tr/tr_insurance_model.dart';
import 'package:travelgrid/data/models/tr/tr_traveller_details.dart';
import 'package:travelgrid/data/models/tr/tr_visa_model.dart';
import 'package:travelgrid/presentation/components/dialog_cash.dart';
import 'package:travelgrid/presentation/screens/common/employees_screen.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/add/add_forex.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/add/add_insurance.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/add/add_traveller.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/add/add_visa.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/add/build_itenerary.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/bloc/tr_processed_form_bloc.dart';
import 'package:travelgrid/presentation/widgets/checkbox.dart';
import 'package:travelgrid/presentation/widgets/dialog_selector_view.dart';
import 'package:travelgrid/presentation/widgets/search_selector_view.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_field.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:travelgrid/presentation/widgets/toggle_button.dart';

class TrProcessed extends StatelessWidget {
  Function? onNext;
  String? tripType;
  TRSummaryResponse? summaryResponse;
  bool? isEdit;
  TrProcessed({this.onNext,this.tripType,this.summaryResponse,this.isEdit=false});
  File? file;
  Map<String,dynamic> jsonData = {};
  ProcessedTrFormBloc?  formBloc;

  var map = {
    "text" : '',
    "color" : "0xFFFFFFFF",
    "size": "10",
    "family": "regular",
    "align" : "center"
  };

  var supp = {
    "text" : "Supporting Document/Notes",
    "color" : "0xFF2854A1",
    "size": "16",
    "family": "bold",
    "align": "center-left"
  };
  final List<bool> steps = <bool>[true, false, false];
  List<Widget> items = [];
  List<String> segment = ["O","R","M"];
  List<String> segLabel = ["one-way","R","M"];
  int selected = 0;
  List<TRCityPairModel> listCity=[];
  List<TrForexAdvance> listForex=[];
  List<TRTravelVisas> listVisa=[];
  List<TRTravelInsurance> listInsurance=[];
  List<TRTravellerDetails> list =  [];
  bool showTravellerItems=true;

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
                formBloc!.segmentType.updateValue(segment[0]);
                formBloc!.segmentTypeID.updateValue(segment[0]);

                formBloc!.requestType.updateValue("Self");
                formBloc!.requestTypeID.updateValue("self");

                formBloc!.swBillable.updateValue(true);
                if(isEdit!){

                  final idx = segLabel.indexWhere((element) => element == summaryResponse?.data?.segmentType.toString());
                  print(summaryResponse?.data?.segmentType);
                  formBloc!.segmentType.updateValue(segment[idx]);
                  formBloc!.segmentTypeID.updateValue(segment[idx]);


                  formBloc!.requestType.updateValue(summaryResponse?.data?.maRequesterDetails?.requestType.toString().capitalize() ?? "");
                  formBloc!.requestTypeID.updateValue(summaryResponse?.data?.maRequesterDetails?.requestType.toString()??"");


                  if(summaryResponse?.data?.maRequesterDetails?.requestType.toString()!="self") {

                   List<TRTravellerDetails> details=[];
                    for(var item in summaryResponse!.data!.maTravelerDetails!){

                      formBloc!.employeeType.updateValue(item.employeeType);

                     details.add(TRTravellerDetails(
                      employeeCode: item.employeeCode,
                      employeeName:item.employeeName ?? "",
                      name:item.name ?? "",
                      email: item.email ?? "",
                      employeeType: item.employeeType,
                      mobileNumber:item.mobileNumber ?? "",
                      emergencyContactNo:item.emergencyContactNo ?? ""
                     ));
                    }
                    formBloc!.travellerDetails.updateValue(details);
                  }

                  formBloc!.purposeOfTravel.updateValue(summaryResponse?.data?.purposeOfVisit.toString()??"");
                  formBloc!.purposeOfTravelID.updateValue(CityUtil.getIDFromTravelPurpose(summaryResponse?.data?.purposeOfVisit.toString()??""));

                  formBloc!.purposeDetails.updateValue(summaryResponse?.data?.purposeOfTravel ?? "");

                  if(summaryResponse?.data?.tripBillable.toString().toLowerCase()=="no"){
                    formBloc!.swBillable.updateValue(false);
                  }else{
                    formBloc!.swBillable.updateValue(true);
                  }

                //  formBloc!.noteApprover.updateValue(summaryResponse?.data?. ?? "");
                  //formBloc!.noteAgent.updateValue(summaryResponse?.data?. ?? "");

                 // formBloc!.cityList.updateValue(summaryResponse?.data?.maCityPairs ?? "");


                  setListData(summaryResponse!.data!);



                }
                
                
                
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
                                color: Colors.white,
                                padding: EdgeInsets.only(bottom: 10.h,top: 5.h),
                                // decoration: BoxDecoration(
                                //   color: ParseDataType().getHexToColor(jsonData['backgroundColor']),
                                //   //  borderRadius:  BorderRadius.all(Radius.circular(30)),
                                // ),
                                alignment: Alignment.center,

                                child: Container(
                                  height: 35.h,
                                  child: MetaToggleButton(
                                    type: 2,
                                    border: 30,
                                    onCheckPressed: (index){
                                      selected = index;
                                      formBloc!.segmentType.updateValue(segment[index]);
                                      formBloc!.segmentTypeID.updateValue(segment[index].toString());
                                      formBloc!.cityList.changeValue([]);
                                    },
                                    steps: steps,items: items,enabledColor:ParseDataType().getHexToColor(jsonData['backgroundColor']) ),
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: MetaDialogSelectorView(mapData: jsonData['selectRequest'],
                                          text :getInitialText(formBloc!.requestType.value),
                                          onChange:(value){
                                            print(value);

                                            formBloc!.requestType.updateValue(value['text']);
                                            formBloc!.requestTypeID.updateValue(value['id']);
                                            if(formBloc!.requestTypeID.value == "self"){
                                              formBloc!.travellerDetails.clear();
                                              list.clear();
                                              formBloc!.travellerDetails.updateValue([]);
                                              formBloc!.employeeType.updateValue("");
                                            }


                                          },),
                                      ),
                                    ),
                                    Expanded(
                                      child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                          bloc: formBloc!.requestTypeID,
                                          builder: (context, state) {
                                            print(formBloc!.requestTypeID.value);
                                            return Visibility(
                                              visible: (
                                                  state.value.toString().toLowerCase() == "onBehalf".toLowerCase()
                                                  || state.value.toString().toLowerCase() == "group".toLowerCase()) ? true : false,
                                              child:Container(
                                                child: MetaDialogSelectorView(mapData: jsonData['selectEmployeeType'],
                                                  text :getInitialText(formBloc!.employeeType.value!),
                                                  onChange:(value){

                                                  if(formBloc!.employeeType.value!=value['text']){
                                                    formBloc!.employeeType.updateValue(value['text']);
                                                    formBloc!.travellerDetails.clear();
                                                    list.clear();
                                                  }

                                                  },),
                                              ),
                                            );
                                          }
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                child: BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
                                    bloc: formBloc!.employeeType,
                                    builder: (context, state) {
                                      print(formBloc!.employeeType.value);
                                      return Visibility(
                                        visible: (
                                            state.value.toString().toLowerCase() == "employee".toLowerCase()
                                                || state.value.toString().toLowerCase() == "non-employee".toLowerCase())  ? true : false,
                                        child:buildExpandableView(jsonData,"travellerDetails",context)
                                      );
                                    }
                                ),
                              ),


                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(

                                        child: MetaSwitchBloc(
                                            mapData:  jsonData['billableSwitch'],
                                            bloc:  formBloc!.swBillable,
                                            onSwitchPressed: (value){
                                              formBloc!.swBillable.updateValue(value);
                                            }),
                                      ),

                                    ),
                                    Expanded(
                                      
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                                        child: MetaDialogSelectorView(mapData: jsonData['selectTravelPurpose'],
                                          text :getInitialText(formBloc!.purposeOfTravel.value),
                                          onChange:(value){
                                            print(value);
                                            formBloc!.purposeOfTravel.updateValue(value['label']);
                                            formBloc!.purposeOfTravelID.updateValue(value['id'].toString());
                                          },),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                child: MetaTextFieldBlocView(mapData: jsonData['text_field_details'],
                                    textFieldBloc: formBloc!.purposeDetails,
                                    onChanged:(value){
                                      formBloc!.purposeDetails.updateValue(value);
                                    }),
                              ),



                              SizedBox(height: 2.h,),
                              buildCityPairWidget(),
                              if(tripType=="D")
                              buildExpandableView(jsonData,"cashAdvanceDetails",context),
                              if(tripType=="O")
                              buildExpandableView(jsonData,"forexAdvanceDetails",context),
                              if(tripType=="O")
                              buildExpandableView(jsonData,"visaDetails",context),
                              if(tripType=="O")
                              buildExpandableView(jsonData,"insuranceDetails",context),

                              Container(
                                height: 40.h,
                                  padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 3.h),
                                  margin: EdgeInsets.symmetric(horizontal:10.w,vertical: 5.h),

                                  decoration: BoxDecoration(
                                    color:  Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                    border: Border.all(
                                      color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                                      width: 2.r,
                                    ),
                                  ),
                                  child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                                      child: MetaTextView(mapData: supp,))),

                              Container(

                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                child: MetaTextFieldBlocView(mapData: jsonData['text_field_appprover'],
                                    textFieldBloc: formBloc!.noteApprover,
                                    onChanged:(value){
                                      formBloc!.noteApprover.updateValue(value);
                                    }),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                child: MetaTextFieldBlocView(mapData: jsonData['text_field_agent'],
                                    textFieldBloc: formBloc!.noteAgent,
                                    onChanged:(value){
                                      formBloc!.noteAgent.updateValue(value);
                                    }),
                              ),
                              SizedBox(height: 20.h,),
                              // UploadComponent(jsonData: jsonData['uploadButton'],
                              //     url: formBloc!.voucherPath.value,
                              //     isViewOnly: false,
                              //     onSelected: (File dataFile){
                              //       file=dataFile;
                              //     }),
                              // SizedBox(height: 20.h,),
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

  Container buildExpandableView(Map mapData,String key,ctx){
    Map<String,dynamic> map= mapData[key];

     getViews(map,value){
      switch(value){

        case "travellerDetails":
          return buildTravellerWidget(map);
        case "cashAdvanceDetails":
          return buildCashAdvanceWidget(map);
        case "forexAdvanceDetails":
          return buildForexAdvanceWidget(map);
        case "visaDetails":
          return buildVisaAdvanceWidget(map);
        case "insuranceDetails":
          return buildInsuranceAdvanceWidget(map);
        // case "approverDetails":
        //   return showApproverDetails ? buildApproverWidget(map):Container();
        default:
          return Container();
      }

    }

    return Container(
      child: Column(
        children: [
          buildHeaders(map,ctx),
          getViews(map,key)
        ],
      ),
    );
  }

  Container buildHeaders(Map<String,dynamic> map,ctx) {
    return Container(
      height: 40.h,


      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 3.h),
      margin: EdgeInsets.symmetric(horizontal:10.w,vertical: 5.h),

      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.r)),
        border: Border.all(
          color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
          width: 2.r,
        ),
      ),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: MetaTextView(mapData: map['label'])),
          Expanded(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: InkWell(
                  onTap: ()async{
                    if(map['add']['type'] == "traveller") {

                      addTraveller(ctx);

                      return;
                    }
                    openAddons(map,ctx,false);

                  },
                    child: MetaTextView(mapData: map['add'],text: "ADD",)
                )),
          ),
          //Expanded(child: child)
        ],
      ),
    );
  }

  buildCityPairWidget() {

    return BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
        bloc: formBloc!.segmentTypeID,
        builder: (context, state) {

          return  BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
              bloc: formBloc!.cityList,
              builder: (context, state) {

                List<TRCityPairModel> list  = formBloc!.cityList.value!.toList();
                return BuildItinerary(
                  tripType: tripType,
                    map: jsonData['cityPairDetails'],
                    list: list,
                    type: formBloc!.segmentTypeID.value,
                    onAdded: (List<TRCityPairModel> list){

                      formBloc!.cityList.changeValue(list);

                    });
              }
          ) ;
        }
    );


  }

  buildCashAdvanceWidget(Map map) {

    return BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
        bloc: formBloc!.cashList,
        builder: (context, state) {

          List<MaCashAdvance>? list  = formBloc!.cashList.value!.toList();
          return  Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            color: Colors.white,
            child: list.isNotEmpty ? Column(
              children: [
                Row(
                  children: [
                    Container(
                        width: 40.w,
                        child: MetaTextView(mapData:  map['header'],text: "#")),
                    Expanded(child: MetaTextView(mapData:  map['header'],text: "Currency",)),
                    Expanded(
                        flex: 2,
                        child: MetaTextView(mapData:  map['header'],text: "Requested Amount")),
                  //  Expanded(child: MetaTextView(mapData:  map['header'],text: "Status")),

                  ],
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      MaCashAdvance item = list[index];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        color: Colors.white,
                        child:  Row(
                          children: [
                            Container(
                                width: 40.w,
                                child: MetaTextView(mapData:  map['item'],text: (index+1).toString())),
                            Expanded(child: MetaTextView(mapData:  map['item'],text: "INR",)),
                            Expanded(
                                flex: 2,
                                child: MetaTextView(mapData:  map['item'],text:item.totalCashAmount.toString().inRupeesFormat(),)),
                          //  Expanded(child: MetaTextView(mapData:  map['item'],text: item.currentStatus)),

                          ],
                        ),
                      );
                    },
                    itemCount: list.length
                ),
              ],
            ):Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MetaTextView(mapData: map['listView']['emptyData']['title']),
              ],
            ),
          );
        }
    );
  }

  buildForexAdvanceWidget(Map map) {

    return BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
        bloc: formBloc!.forexList,
        builder: (context, state) {

          List<TrForexAdvance>? list  = formBloc!.forexList.value!.toList();
          return  Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            color: Colors.white,
            child: list.isNotEmpty ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  TrForexAdvance item = list[index];
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    color: Colors.white,
                    child:  Column(
                      children: [
                        Container(
                          height: 20.h,
                          child: Row(
                            children: [
                                  Container(
                                  width: 10.w,
                                  child: MetaTextView(mapData:  map['header'],text: "#")),
                              Expanded(child: MetaTextView(mapData:  map['header'],text: "Currency",)),
                              Expanded(child: MetaTextView(mapData:  map['header'],text: "Req Cash")),
                              Expanded(child: MetaTextView(mapData:  map['header'],text: "Req Card")),

                                ],
                          ),
                        ),

                        Container(
                          height: 20.h,
                          child: Row(
                            children: [
                              Container(
                                  width: 10.w,
                                  child: MetaTextView(mapData:  map['item'],text: (index+1).toString())),
                              Expanded(child: MetaTextView(mapData:  map['item'],text:  CityUtil.getCurrencyFromID(item.currency))),
                              Expanded(child: MetaTextView(mapData:  map['item'],text: item.cash.toString().inRupeesFormat(),)),
                              Expanded(child: MetaTextView(mapData:  map['item'],text: item.card.toString().inRupeesFormat(),)),
                            ],
                          ),
                        ),
                        Container(
                          height: 20.h,
                          child: Row(
                              children: [
                                Expanded(child: MetaTextView(mapData:  map['header'],text: "Ex. Rate")),
                                Expanded(child: MetaTextView(mapData:  map['header'],text: "Comments")),
                                Expanded(child: MetaTextView(mapData:  map['header'],text: "Total Forex(INR)")),
                              ]),
                        ),
                        Container(
                          height: 20.h,
                          child: Row(
                              children: [
                                Expanded(child: MetaTextView(mapData:  map['item'],text: ((item.totalForexAmount)!/(item.cash!+item.card!)).toString())),
                                Expanded(child: MetaTextView(mapData:  map['item'],text: item.address)),
                                Expanded(child: MetaTextView(mapData:  map['item'],text: item.totalForexAmount.toString())),
                              ]),
                        ),

                      ],
                    ),
                  );
                },
                itemCount: list.length
            ):Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MetaTextView(mapData: map['listView']['emptyData']['title']),
              ],
            ),
          );
        }
    );
  }

  buildVisaAdvanceWidget(Map map) {

    return BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
        bloc: formBloc!.visaList,
        builder: (context, state) {

          List<TRTravelVisas>? list  = formBloc!.visaList.value!.toList();
          return  Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            color: Colors.white,
            child: list.isNotEmpty ? Column(
              children: [
                Row(
                  children: [
                    Container(
                        width: 10.w,
                        child: MetaTextView(mapData:  map['header'],text: "#")),
                    Expanded(
                        child: MetaTextView(mapData:  map['header'],text: "Visiting Country")),
                    Expanded(
                        child: MetaTextView(mapData:  map['header'],text: "Duration(Days)")),
                    Expanded(child: MetaTextView(mapData:  map['header'],text: "Visa Type",)),
                  ],
                ),
                Container(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        TRTravelVisas item = list[index];
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          color: Colors.white,
                          child:  Row(
                            children: [
                              Container(
                                  width: 10.w,
                                  child: MetaTextView(mapData:  map['item'],text: (index+1).toString())),
                              Expanded(child: MetaTextView(mapData:  map['item'],text: item.visitingCountry)),
                              Expanded(child: MetaTextView(mapData:  map['item'],text:item.durationOfStay.toString())),
                              Expanded(child: MetaTextView(mapData:  map['item'],text:item.visaType)),
                            ],
                          ),
                        );
                      },
                      itemCount: list.length
                  ),
                ),
              ],
            ):Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MetaTextView(mapData: map['listView']['emptyData']['title']),
              ],
            ),
          );
        }
    );
  }

  buildInsuranceAdvanceWidget(Map map) {

    return BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
        bloc: formBloc!.insuranceList,
        builder: (context, state) {

          List<TRTravelInsurance>? list  = formBloc!.insuranceList.value!.toList();


          return  Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            color: Colors.white,
            child: list.isNotEmpty ? Column(
              children: [
                Row(
                  children: [
                    Container(
                        width: 10.w,
                        child: MetaTextView(mapData:  map['header'],text: "#")),
                    Expanded(
                        child: MetaTextView(mapData:  map['header'],text: "Visiting Country")),
                    Expanded(
                        child: MetaTextView(mapData:  map['header'],text: "Duration(Days)")),
                    Expanded(child: MetaTextView(mapData:  map['header'],text: "Service Type",)),

                  ],
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      TRTravelInsurance item = list[index];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        color: Colors.white,
                        child:  Row(
                          children: [
                            Container(
                                width: 10.w,
                                child: MetaTextView(mapData:  map['item'],text: (index+1).toString())),
                            Expanded(child: MetaTextView(mapData:  map['item'],text: item.visitingCountry)),
                            Expanded(child: MetaTextView(mapData:  map['item'],text:item.durationOfStay.toString())),
                            Expanded(child: MetaTextView(mapData:  map['item'],text:"VISA")),
                          ],
                        ),
                      );
                    },
                    itemCount: list.length
                ),
              ],
            ):Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MetaTextView(mapData: map['listView']['emptyData']['title']),
              ],
            ),
          );
        }
    );
  }

  buildTravellerWidget(Map map) {

    return BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
        bloc: formBloc!.travellerDetails,
        builder: (context, state) {
          List<TRTravellerDetails>? list  = formBloc!.travellerDetails.value ?? [] ;
            bool  checkIndex=false;


          for(var item in list){
            if(item.primary==true){
              checkIndex=true;
              break;
            }
          }

          if((checkIndex==false && list.isNotEmpty)){
            list[0].primary=true;
          }

          return  Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            color: Colors.white,
            child: list.isNotEmpty ? Column(
              children: [
                Row(
                  children: [
                    Expanded(child: MetaTextView(mapData:  map['header'],text: "TR Traveller")),
                  //  Expanded(child: MetaTextView(mapData:  map['header'],text: "Gender")),
                    Expanded(
                      flex: 2,
                        child: MetaTextView(mapData:  map['header'],text: "Info",)),
                    Container(
                      width: 50.w,
                        child: MetaTextView(mapData:  map['header'],text: "Update",)),

                  ],
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      TRTravellerDetails? details  = list[index] ;
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                        color: Colors.white,
                        child: Container(
                          child: Row(
                            children: [
                                    MetaCheckBox(
                                      value: details.primary ?? false,
                                      onCheckPressed: (value){
                                        for(var item in list){
                                          item.primary=false;
                                        }
                                        details.primary=true;
                                        formBloc!.travellerDetails.clear();
                                        formBloc!.travellerDetails.changeValue(list);
                                      }),
                               // }
                              //),
                              Expanded(child: MetaTextView(mapData:  map['item'],text:details.name)),
                             // Expanded(child: MetaTextView(mapData:  map['item'],text: details.gender!)),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MetaTextView(mapData:  map['item'],textAlign:TextAlign.start,text: details.mobileNumber!),
                                      MetaTextView(mapData:  map['item'],textAlign:TextAlign.start,text: details.email!)
                                    ],
                                  )),
                              SizedBox(width: 10.w,),
                              details.employeeType!="Employee" ? InkWell(
                                  onTap: (){

                                  },
                                  child: Container(
                                      width:25.w,
                                      height:25.w,
                                      child: MetaSVGView(mapData:  map['listView']['items'][0]))):
                              Container(
                                  width:25.w,
                                  height:25.w),
                              SizedBox(width: 5.w,),
                              InkWell(
                                  onTap: (){

                                    list.removeAt(index);

                                    formBloc!.travellerDetails.clear();
                                    formBloc!.travellerDetails.changeValue(list);

                                  },
                                  child: Container(
                                      width:25.w,
                                      height:25.w,
                                      child: MetaSVGView(mapData:  map['listView']['items'][1])))
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: formBloc!.travellerDetails.value!.length
                ),
              ],
            ):Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MetaTextView(mapData: map['listView']['emptyData']['title']),
              ],
            ),
          );


        }
    );
  }

  procSubmit()async{
    print('page1 submit');
    // if(file!=null){
    //   SuccessModel model = await  MetaUpload().uploadImage(file!,"TR");
    //   if(model.status!){
    //     formBloc!.voucherPath.updateValue(model.data!);
    //     formBloc!.submit();
    //   }
    // }else{
    //   formBloc!.submit();
    // }
    formBloc!.submit();
  }

  getInitialText(String text) {

    if(text.isNotEmpty){
      return text;
    }
    return null;
  }

  void setListData(Data data) {
    List<TRCityPairModel> cityList=[];
    for(var item in data.maCityPairs!){
      Map<String,dynamic> data ={
        "leavingFrom": item.leavingFrom!.id.toString(),
        "goingTo":item.goingTo!.id.toString(),
        "startDate": item.startDate!.replaceAll("/", "-"),
        "startTime": item.startTime,
        "byCompany":item.byCompany!.id,
        "fareClass": item.fareClass!.id,
        "travelMode": item.travelMode,
        "price":item.price,
        "pnr":item.pnr,
        "ticket":item.ticketNo,
      };
      cityList.add(TRCityPairModel.fromJson(data));
    }
    formBloc!.cityList.updateValue(cityList);
    formBloc!.cashList.updateValue(data.maCashAdvance);

    List<TRTravelVisas> visaList=[];
    for(var item in data.maTravelVisas!){
      Map<String, dynamic> data = {
        "serviceType": item.serviceType ?? "VISA",
        "visitingCountry": item.visitingCountry,
        "durationOfStay": item.durationOfStay,
        "visaRequirement": item.visaRequirement,
        "numberOfEntries": item.numberOfEntries=="Single"?183:184,
        "visaType": item.visaType,
      };
      visaList.add(TRTravelVisas.fromJson(data));
    }
    formBloc!.visaList.updateValue(visaList);



    List<TRTravelInsurance> insuranceList=[];
    for(var item in data.maTravelInsurance!){
      Map<String, dynamic> data = {
        "serviceType": item.serviceType,
        "visitingCountry": item.visitingCountry,
        "durationOfStay": item.durationOfStay,
        "insuranceRequirement": item.insuranceRequirement,
      };
      insuranceList.add(TRTravelInsurance.fromJson(data));
    }
    formBloc!.insuranceList.updateValue(insuranceList);


    List<TrForexAdvance> forexList=[];
    for(var item in data.maForexAdvance!){
      Map<String, dynamic> data = {
        "cash": item.cash,
        "card": item.card,
        "currency": CityUtil.getCurrenciesFromID(item.currency,isID: false) as int,
        "violationMessage": item.violationMessage,
        "totalForexAmount": double.parse(item.totalForexAmount.toString()) ,
        "address": item.address,
      };
      forexList.add(TrForexAdvance.fromJson(data));
    }
    formBloc!.forexList.updateValue(forexList);
    print('formBloc!.forexList');
    print(forexList);
    print(formBloc!.forexList.value);


  }

  void openAddons(Map<String, dynamic> map,ctx,isEdit) async{

    if(formBloc!.cityList.value!.isEmpty){
      MetaAlert.showSuccessAlert(message: "Please add Itinerary Details First");
      return;
    }

    if(map['add']['type']=="cash") {
      await showDialog(
      context: ctx,
      builder: (_) =>
          DialogCash(onSubmit: (value) {
            List<MaCashAdvance> list = [
              MaCashAdvance(
                  totalCashAmount: int.parse(value),
                  currentStatus: "",
                  violation: ""
              )
            ];
            formBloc!.cashList.changeValue(list);
          }));
    }


    if(map['add']['type']=="forex") {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (context) =>
          AddForex(
            jsonData: map['details'],
            isEdit:isEdit,
            onAdd: (TrForexAdvance data){
              listForex.add(data);
              formBloc!.forexList.clear();
              formBloc!.forexList.changeValue(listForex);
            },)));
    }

    if(map['add']['type']=="visa") {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (context) =>
          AddVisa(
            jsonData: map['details'],
            isEdit:isEdit,
            onAdd: (TRTravelVisas data){
              listVisa.add(data);
              formBloc!.visaList.clear();
              formBloc!.visaList.changeValue(listVisa);
            },)));
    }

    if(map['add']['type']=="insurance") {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (context) =>
          AddInsurance(
            jsonData: map['details'],
            isEdit:isEdit,
            onAdd: (TRTravelInsurance data){
              listInsurance.add(data);
              formBloc!.insuranceList.clear();
              formBloc!.insuranceList.changeValue(listInsurance);
            },)));
    }


  }

  void addTraveller(ctx) {

    if(formBloc!.requestTypeID.value.toString().toLowerCase() == "onBehalf".toLowerCase()){

    if(formBloc!.employeeType.value == "Employee"){
      if(formBloc!.travellerDetails.value!.length == 0){
        navigateEmployee(ctx,false);
      }else{
        MetaAlert.showSuccessAlert(message: "Employee Details Already Added");
      }

      }else{
        if(formBloc!.travellerDetails.value!.length == 0){
          navigateTraveller(ctx,false,TRTravellerDetails());
        }else{
          MetaAlert.showSuccessAlert(message: "Traveller Details Already Added");
        }
      }
    }else if(formBloc!.requestTypeID.value.toString().toLowerCase() == "group".toLowerCase()){
      if(formBloc!.employeeType.value == "Employee"){
        navigateEmployee(ctx,false);
      }else{
        navigateTraveller(ctx,false,TRTravellerDetails());
      }
    }
  }

  void navigateTraveller(ctx,isEdit,details) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (context) =>
        AddTravellerDetails(
          tripType,
          isEdit:isEdit,
          travellerDetails: details,
          onAdd: (data){

            if(formBloc!.requestTypeID.value.toString().toLowerCase() == "onBehalf".toLowerCase()){
              formBloc!.travellerDetails.changeValue([data]);
            }else{
              list =  formBloc!.travellerDetails.value ?? [];
              list.add(data);
              formBloc!.travellerDetails.clear();
              formBloc!.travellerDetails.changeValue(list);
              print(formBloc!.travellerDetails.value);
            }
          },)));
  }

  void navigateEmployee(ctx,isEdit) {
    Navigator.of(ctx).push(
        MaterialPageRoute(builder: (context) =>
            EmployeeScreen(
              onTap: (data) {
                Navigator.pop(context);
                TRTravellerDetails model = TRTravellerDetails(
                  employeeCode: data.employeecode,
                  employeeName: data.fullName,
                  primary: false,
                  name: data.fullName,
                  gender: data.gender,
                  email: data.currentContact!.email ?? "",
                  employeeType: "Employee",
                  mobileNumber: data.currentContact!.mobile ?? "",
                );
                if(formBloc!.requestTypeID.value.toString().toLowerCase() == "onBehalf".toLowerCase()){
                  formBloc!.travellerDetails.changeValue([model]);
                }else{
                  formBloc!.travellerDetails.value ?? [];
                  list.add(model);
                  formBloc!.travellerDetails.clear();
                  formBloc!.travellerDetails.changeValue(list);
                }
              },
            ))
    );
  }


}
