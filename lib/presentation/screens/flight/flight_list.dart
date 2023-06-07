import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/capitalize.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/data/blocs/flight/flight_bloc.dart';
import 'package:travelgrid/data/datasources/others/flight_list.dart';
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/components/filterby_component.dart';
import 'package:travelgrid/presentation/components/sortby_component.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class FlightScreen extends StatelessWidget {
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;

  FlightBloc? bloc;

  int selected=0;
 // int filterSelected=0;
  String sortedBy="Default";

  List<String> filterSelected=["All"];
  List<String> filterOptions=["All"];


  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.flightData;

     bloc = Injector.resolve<FlightBloc>();
     callBloc();


    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                          SortComponent(
                              type: "tr",
                              selected: selected,
                              onSelect:(int value,Map<String,dynamic> data) {
                                selected=value;
                                sortedBy=data['value'];
                                print("Sort Selected: "+value.toString());
                                Navigator.pop(context);
                                callBloc();

                              })
                  );
                }
            ),
            MetaButton(mapData: jsonData['bottomButtonRight'],
                onButtonPressed: (){
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) =>
                        FilterComponent(
                            tags: filterSelected,
                            options: filterOptions,
                            selected:(id){
                              filterSelected=id;
                              Navigator.pop(context);
                              callBloc();
                            }),
                  );
                }
            )
          ],
        ),
      ),
      body: BlocBuilder<FlightBloc, FlightState>(
          bloc: bloc,
          builder:(context, state) {
            jsonData['listView']['recordsFound']['value'] = 0;
            return Container(
                child: BlocMapToEvent(state: state.eventState, message: state.message,
                    callback: (){
                       jsonData['listView']['recordsFound']['value'] = state.response?.data?.length;

                       if(state.response?.data== null)
                         return;
                       //
                       // for(var item in state.response!.data!){
                       //   filterOptions.add(item.currentStatus.toString());
                       //   filterOptions.add(item.tripPlan.toString());
                       //   filterOptions.add(item.tripType.toString());
                       // }
                       // filterOptions = filterOptions.toSet().toList();

                    },
                    topComponent:Container(
                      color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                      height: 120.h,
                      child:  Column(
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
                                  child:MetaTextView(mapData: jsonData['title']),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height:5.h),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            child:MetaTextView(mapData: jsonData['listView']['recordsFound']),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                child:MetaTextView(mapData: jsonData['listView']['recordsFound'],text: "Sorted By : "+sortedBy),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                child:MetaTextView(mapData: jsonData['listView']['recordsFound'],text: "Filtered By : "+filterSelected.length.toString()),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    child:RefreshIndicator(
                        onRefresh: _pullRefresh,
                        child: getListView(state))
                )
            );
          }
      ),
    );
  }


  Widget getListView(FlightState state){

    List<Data>? list = state.response?.data! ?? [];

    return  list.isNotEmpty ? ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount:list.length,
      itemBuilder: (BuildContext context, int index) {
        Data item = list[index];

        Map date = {
          "text" : MetaDateTime().getDate(item.departDate.toString(),format: "dd MMM",isFlightDate: true),
          "color" : "0xFF2854A1",
          "size": "13",
          "family": "bold",
          "align" : "center"
        };
        Map next = {
          "text" : "⇩",
          "color" : "0xFF2854A1",
          "size": "13",
          "family": "bold",
          "align" : "center"
        };

        Map date2 = {
          "text" : MetaDateTime().getDate(item.arriveDate.toString(),format: "dd MMM",isFlightDate: true),
          "color" : "0xFF2854A1",
          "size": "13",
          "family": "bold",
          "align" : "center"
        };

        Map week = {
          "text" : MetaDateTime().getDate(item.arriveDate.toString(),format: "EEEEEE",isFlightDate: true).toUpperCase(),
          "color" : "0xFFFFFFFF",
          "size": "13",
          "family": "bold",
          "align" : "center"
        };

        Map flightName = {
          "text" :"#"+ item.flight.toString().toUpperCase(),
          "color" : "0xFF2854A1",
          "size": "15",
          "family": "bold",
          "align" : "center-left"
        };

        Map place = {
          "text" :MetaDateTime().getDate(item.departDate.toString(),format: "hh:mm",isFlightDate: true),
          "color" : "0xFF2854A1",
          "size": "14",
          "family": "bold",
          "align" : "center-left"
        };

        Map time = {
          "text" :MetaDateTime().getDate(item.departDate.toString(),format: "hh:mm",isFlightDate: true),
          "color" : "0xFFCCCCCC",
          "size": "14",
          "family": "bold",
          "align" : "center-left"
        };
        Map time2 = {
          "text" :MetaDateTime().getDate(item.arriveDate.toString(),format: "hh:mm",isFlightDate: true),
          "color" : "0xFFCCCCCC",
          "size": "14",
          "family": "bold",
          "align" : "center-left"
        };

        Map price = {
          "text" :"",
          "color" : "0xFFFFFFFF",
          "size": "10",
          "family": "bold",
          "align" : "center-left"
        };


        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              Card(
                color: Color(0xFF2854A1),
                elevation: 5,
                child: Container(
                  width: cardHt,
                  height: cardHt,
                  child: Column(
                    children: [
                      Container(
                        height:cardHt * 0.07,
                      ),
                      Container(
                        color: Color(0xFFFFFFFF),
                        child: Column(
                          children: [
                            Container(
                                height: cardHt * 0.24,
                                child: MetaTextView(mapData: date)
                            ),
                            Container(
                                height: cardHt * 0.15,
                                child: MetaTextView(mapData: next)
                            ),
                            Container(
                                height:cardHt * 0.24,
                                child: MetaTextView( mapData: date2)
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: cardHt * 0.30,
                        child: MetaTextView( mapData: week),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 3.w,),
              Expanded(
                child: Card(
                  color: Color(0xFF2854A1),
                  elevation: 5,
                  child: Container(
                    width: cardHt,
                    height: cardHt,
                    child: Column(
                      children: [
                        Container(
                          height:cardHt * 0.07,
                        ),
                        Container(
                          color: Color(0xFFFFFFFF),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                height: cardHt * 0.16,
                                child:Container(
                                    child: MetaTextView(mapData: flightName)
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                height: cardHt * 0.23,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: MetaTextView(mapData: place,text: item.from,)
                                    ),
                                    Container(
                                        child: MetaTextView(mapData: place,text: item.to,)
                                    ),
                                  ],
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.symmetric(horizontal: 10.w),
                              //   height: cardHt * 0.15,
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Container(
                              //           child: MetaTextView(mapData: date,text: "")
                              //       ),
                              //       Container(
                              //           child: MetaTextView(mapData: date,text:"")
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                height: cardHt * 0.22,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: MetaTextView(mapData: time)
                                    ),
                                    Container(
                                        child: MetaTextView(mapData: time2)
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: cardHt * 0.30,
                          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 2.h),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child:  MetaTextView( mapData: price,
                                      text: "Retail Fare :\n" +item.retailFare.toString().inRupeesFormat())),
                              SizedBox(width: 10.w,),
                              Container(
                                  child: MetaTextView( mapData:  price ,
                                      text: "Corp Fare :\n" +item.corpFare.toString().inRupeesFormat()))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 3.h);
      },
    ):  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MetaTextView(mapData: jsonData['listView']['emptyData']['title']),
        SizedBox(height: 10.h,),
        MetaButton(mapData: jsonData['listView']['emptyData']['bottomButtonRefresh'],
            onButtonPressed: (){
              callBloc();
            })
      ],
    );
  }

  void callBloc() {
    bloc!.add(GetFlightListEvent());
  }

  Future<void> _pullRefresh() async {
    callBloc();
  }


}
