import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelex/common/constants/flavour_constants.dart';
import 'package:travelex/common/extensions/capitalize.dart';
import 'package:travelex/common/extensions/parse_data_type.dart';
import 'package:travelex/common/injector/injector.dart';
import 'package:travelex/common/utils/date_time_util.dart';
import 'package:travelex/data/blocs/flight/flight_bloc.dart';
import 'package:travelex/data/datasources/others/flight_list.dart';
import 'package:travelex/presentation/components/bloc_map_event.dart';
import 'package:travelex/presentation/components/dialog_yes_no.dart';
import 'package:travelex/presentation/components/search_bar_component.dart';
import 'package:travelex/presentation/widgets/button.dart';
import 'package:travelex/presentation/widgets/icon.dart';
import 'package:travelex/presentation/widgets/image_view.dart';
import 'package:travelex/presentation/widgets/radio.dart';
import 'package:travelex/presentation/widgets/text_view.dart';

class FlightScreen extends StatelessWidget {

  String from,date,to,paxCount,fareClass;
  FlightScreen({required this.from,required this.to,required this.date,required this.paxCount,required this.fareClass});
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 75.h;

  FlightBloc? bloc;
  final TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.flightData;

     bloc = Injector.resolve<FlightBloc>();
     callBloc();


    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomAppBar(
      //   color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
      //   shape: CircularNotchedRectangle(),
      //   notchMargin: 5,
      //   elevation: 2.0,
      //   child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       MetaButton(mapData: jsonData['bottomButtonLeft'],
      //           onButtonPressed: (){
      //             showModalBottomSheet(
      //                 context: context,
      //                 backgroundColor: Colors.transparent,
      //                 builder: (context) =>
      //                     SortComponent(
      //                         type: "tr",
      //                         selected: selected,
      //                         onSelect:(int value,Map<String,dynamic> data) {
      //                           selected=value;
      //                           sortedBy=data['value'];
      //                           print("Sort Selected: "+value.toString());
      //                           Navigator.pop(context);
      //                           callBloc();
      //
      //                         })
      //             );
      //           }
      //       ),
      //       MetaButton(mapData: jsonData['bottomButtonRight'],
      //           onButtonPressed: (){
      //             showModalBottomSheet(
      //               context: context,
      //               backgroundColor: Colors.transparent,
      //               builder: (context) =>
      //                   FilterComponent(
      //                       tags: filterSelected,
      //                       options: filterOptions,
      //                       selected:(id){
      //                         filterSelected=id;
      //                         Navigator.pop(context);
      //                         callBloc();
      //                       }),
      //             );
      //           }
      //       )
      //     ],
      //   ),
      // ),
      body: BlocBuilder<FlightBloc, FlightState>(
          bloc: bloc,
          builder:(context, state) {
            jsonData['listView']['recordsFound']['value'] = 0;
            return Container(
                child: BlocMapToEvent(state: state.eventState, message: state.message,
                    callback: (){
                       jsonData['listView']['recordsFound']['value'] = state.response?.data?.airFareResults?.length ?? [];

                    },
                    topComponent:Container(
                      color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
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
                                      Navigator.pop(context,"");
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
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Color(0xFFFFFFFF),
                                border: Border.all(color: Colors.black12)),
                            child: SearchBarComponent(
                              barHeight: 40.h,
                              hintText: "Search.....",
                              searchController: _searchController,
                              onClear: () {

                              },
                              onSubmitted: (text) {

                              },
                              onChange: (text) {
                                print("here: "+text);
                                search(text);
                              },
                            ),
                          ),
                          SizedBox(height:5.h),
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
          "size": "12",
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
          "text" :item.departureTime.toString()+
              " | "+item.arrivalTime.toString(),
          "color" : "0xFF000000",
          "size": "8",
          "family": "bold",
          "align" : "center-left"
        };

        Map duration = {
          "text" :"",
          "color" : "0xFF0000AA",
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


        return InkWell(
          onTap: ()async{

            item.selectedPrice = item.publishedPrice.toString();
            item.selectedFare = "retail";
            var data = item;
            await showDialog(
            context: context,
            builder: (_) => DialogYesNo(
                title: "Select Flight "+item.carrierName!+" "+ item.flightNumber.toString(),
                widgetView:MetaRadio(
                  onRadioSwitched: (value,type){
                    print("onRadioSwitched");
                    print(value);
                    item.selectedPrice = value;
                    item.selectedFare = type;
                  },
                  one: item.publishedPrice.toString(),
                  two: item.corpPublishedPrice.toString(),
                  three: item.splrtPublishedPrice.toString(),
                ),
                onPressed: (value) async{
                  if(value == "YES"){

                    Navigator.pop(context,data);

                  }
                }));
          },
          child: Container(
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
                              height:cardHt * 0.9,
                              padding: EdgeInsets.only(right: 10.w,left: 10.w,bottom: 1.h),
                              color: Color(0xFFFFFFFF),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: MetaTextView(mapData: flightName)
                                      ),
                                      Container(
                                          child:  MetaTextView( mapData: price,
                                              text: "Retail Fare : " +item.publishedPrice.toString().inRupeesFormat())),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: MetaTextView(mapData: flightDetails)
                                      ),

                                      Container(
                                          child: MetaTextView( mapData:  price ,
                                              text: "Corp Fare : " +item.corpPublishedPrice.toString().inRupeesFormat()))
                                    ]
                                  ),

                                  Container(
                                      child: MetaTextView( mapData:  stops )),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Visibility(
                                        visible:true,
                                        child: Container(
                                            child: MetaTextView(mapData: time)
                                        ),
                                      ),
                                      Container(
                                          child: MetaTextView(mapData: duration,
                                            text: "Duration : ${item.duration.toString()} Hour")
                                      )
                                    ]
                                  )

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
 // String dateString = date.replaceAll("-","");
    String formattedDate = MetaDateTime().getDate(date, format: "yyyy-MM-dd");
    bloc!.add(GetFlightListEvent(from: from,to: to,date:formattedDate,paxCount: paxCount,fare: fareClass));
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
      case 'airasia_india':
        return 'aa.png';
      case 'indigo':
        return 'in.png';
      case 'vistara':
        return 'vi.png';
      default :
        return 'def.png';
    }

  }


  void search(String key) {
    bloc!.add(FlightSearchEvent(key: key));
  }

}
