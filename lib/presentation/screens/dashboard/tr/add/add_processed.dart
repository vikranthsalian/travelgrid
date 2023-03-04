import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/city_util.dart';
import 'package:travelgrid/data/datasources/tr_summary_response.dart';
import 'package:travelgrid/data/models/tr/tr_city_pair_model.dart';
import 'package:travelgrid/presentation/components/dialog_cash.dart';
import 'package:travelgrid/presentation/screens/dashboard/tr/add/build_itenerary.dart';
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
  String? tripType;
  TrProcessed({this.onNext,this.tripType});

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
  List<TRCityPairModel> listCity=[];
  //BooleanFieldBloc? swCash=BooleanFieldBloc(initialValue: false);
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
                                padding: EdgeInsets.only(bottom: 10.h),
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
                                        formBloc!.segmentTypeID.updateValue(segment[index].toString());
                                        formBloc!.cityList.changeValue([]);
                                      },
                                      steps: steps,items: items,enabledColor:ParseDataType().getHexToColor(jsonData['backgroundColor']) ,),
                                  ),
                              ),
                              SizedBox(height: 10.h,),
                              buildCityPairWidget(),
                              buildExpandableView(jsonData,"cashAdvanceDetails",context),
                              buildExpandableView(jsonData,"forexAdvanceDetails",context),
                              buildExpandableView(jsonData,"visaDetails",context),
                              buildExpandableView(jsonData,"insuranceDetails",context),
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
    Map map= mapData[key];



     getViews(map,value){
      switch(value){

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

  Container buildHeaders(Map map,ctx) {
    return Container(
      height: 40.h,
      color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
      child: Row(

        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: MetaTextView(mapData: map['label'])),
          Expanded(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: InkWell(
                  onTap: ()async{
                    await showDialog(
                    context: ctx,
                    builder: (_) => DialogCash(onSubmit: (value){

                      List<MaCashAdvance> list = [MaCashAdvance(totalCashAmount: int.parse(value),currentStatus: "",violation: "")];
                      formBloc!.cashList.changeValue(list);



                    }));
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
                return    BuildItinerary(
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
            padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                                child: MetaTextView(mapData:  map['item'],text:item.totalCashAmount.toString(),)),
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
        bloc: formBloc!.cashList,
        builder: (context, state) {

          List<MaCashAdvance>? list  = formBloc!.cashList.value!.toList();
          return  Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                                child: MetaTextView(mapData:  map['item'],text:item.totalCashAmount.toString(),)),
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

  buildVisaAdvanceWidget(Map map) {

    return BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
        bloc: formBloc!.cashList,
        builder: (context, state) {

          List<MaCashAdvance>? list  = formBloc!.cashList.value!.toList();
          return  Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                                child: MetaTextView(mapData:  map['item'],text:item.totalCashAmount.toString(),)),
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

  buildInsuranceAdvanceWidget(Map map) {

    return BlocBuilder<SelectFieldBloc, SelectFieldBlocState>(
        bloc: formBloc!.cashList,
        builder: (context, state) {

          List<MaCashAdvance>? list  = formBloc!.cashList.value!.toList();
          return  Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                                child: MetaTextView(mapData:  map['item'],text:item.totalCashAmount.toString(),)),
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
