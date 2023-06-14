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
import 'package:travelgrid/presentation/widgets/image_view.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class FlightScreen extends StatelessWidget {

  String from,date,to;
  FlightScreen({required this.from,required this.to,required this.date});
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 75.h;

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
                       jsonData['listView']['recordsFound']['value'] = state.response?.data?.airFareResults?.length ?? [];

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
                                  child:MetaTextView(mapData: jsonData['title'],text: from +" - "+to + " | "+date,),
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

    List<AirFareResults>? list = state.response?.data?.airFareResults ?? [];

    return  list.isNotEmpty ? ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount:list.length,
      itemBuilder: (BuildContext context, int index) {
        AirFareResults item = list[index];


        Map flightName = {
          "text" : item.carrierName.toString().toUpperCase(),
          "color" : "0xFF2854A1",
          "size": "16",
          "family": "bold",
          "align" : "center-left"
        };

        Map flightDetails = {
          "text" :item.flightNumber.toString().toUpperCase(),
          "color" : "0xFF2854A1",
          "size": "10",
          "family": "bold",
          "align" : "center-left"
        };
        Map stops = {
          "text" :"Total Stops : "+item.totalStops.toString().toUpperCase() ,
          "color" : "0xFF000000",
          "size": "10",
          "family": "bold",
          "align" : "center-left"
        };

        Map time = {
          "text" :MetaDateTime().getDate(item.departureDate.toString(),format: "hh:mm",isFlightDate: true) +" | "+MetaDateTime().getDate(item.arrivalDate.toString(),format: "hh:mm",isFlightDate: true),
          "color" : "0xFFCCCCCC",
          "size": "8",
          "family": "bold",
          "align" : "center-left"
        };

        Map price = {
          "text" :"",
          "color" : "0xFF003C00",
          "size": "10",
          "family": "bold",
          "align" : "center-left"
        };


        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              Card(
                elevation: 5,
                color: Color(0xFF2854A1),
                child: Container(

                  width: cardHt,
                  height: cardHt,
                  child:Column(
                    children: [
                      Container(
                        height:cardHt * 0.1,
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(3),bottomRight:Radius.circular(3)),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.w),
                            color: Color(0xFFFFFFFF),

                            child: MetaBaseImageView(mapData: {
                              "image" : getImageLogo(item.carrierName!.toLowerCase()),

                //    "align": "center",
                            }),
                          ),
                        ),
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
                          height:cardHt * 0.1,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: 10.w,left: 10.w,top: 2.h,bottom: 3.h),
                            color: Color(0xFFFFFFFF),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(


                                      child:Container(
                                          child: MetaTextView(mapData: flightName)
                                      ),

                                    ),
                                    Container(
                                        child:  MetaTextView( mapData: price,
                                            text: "Retail Fare : " +item.corpFare.toString().inRupeesFormat())),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(


                                      child:Container(
                                          child: MetaTextView(mapData: flightDetails)
                                      ),
                                    ),

                                    Container(
                                        child: MetaTextView( mapData:  price ,
                                            text: "Corp Fare : " +item.corpFare.toString().inRupeesFormat()))
                                  ],
                                ),
                                SizedBox(height: 2.h,),


                                Container(
                                    child: MetaTextView( mapData:  stops )),

                                Container(
                                    child: MetaTextView(mapData: time)
                                ),

                              ],
                            ),
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


    bloc!.add(GetFlightListEvent(from: from,to: to,date: date.replaceAll("-",date)));
  }

  Future<void> _pullRefresh() async {
    callBloc();
  }

  getImageLogo(String? carrierCode) {
    switch(carrierCode){
      case 'air india':
        return 'ai.png';
      case 'air asia':
        return 'aa.png';
      case 'indigo':
        return 'in.png';
      case 'vistara':
        return 'vi.png';
    }

  }


}
