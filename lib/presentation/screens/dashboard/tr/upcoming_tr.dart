import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/data/blocs/travel_request/tr_bloc.dart';
import 'package:travelgrid/data/datasources/list/tr_upcoming_response.dart';
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class UpcomingTR extends StatelessWidget {
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;

  TravelRequestBloc? bloc;


  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.upcomingTRData;

     bloc = Injector.resolve<TravelRequestBloc>();
     callBloc();


    return Scaffold(
      backgroundColor: Colors.white,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton:  FloatingActionButton(
      //   child:MetaIcon(mapData:jsonData['bottomButtonFab'],onButtonPressed: ()async{
      //     if(jsonData['bottomButtonFab']['onClick'].isNotEmpty){
      //
      //       await showDialog(
      //           context: context,
      //           builder: (_) => DialogTripType(
      //               title: "Select Trip Type",
      //               onPressed: (value){
      //
      //                   Navigator.of(context).pushNamed(jsonData['bottomButtonFab']['onClick'],
      //                       arguments: {
      //                     'tripType':value,
      //                     'isEdit':false,
      //                   }).then((value) {
      //                     callBloc();
      //                   });
      //
      //               }));
      //
      //     }
      //   },),
      //   backgroundColor: ParseDataType().getHexToColor(jsonData['backgroundColor']),
      //   onPressed: () {}),
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
      body: BlocBuilder<TravelRequestBloc, TravelRequestState>(
          bloc: bloc,
          builder:(context, state) {
            jsonData['listView']['recordsFound']['value'] = 0;
            return Container(
                child: BlocMapToEvent(state: state.eventState, message: state.message,
                    callback: (){
                       jsonData['listView']['recordsFound']['value'] = state.response?.data?.length ?? 0;
                       print("ajfasj");
                       print(state.response?.data?.length);

                       if(state.response?.data == null)
                         return;
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




  Widget getListView(TravelRequestState state){

    List<Data>? list = state.responseUp?.data ?? [];

    return  list.isNotEmpty ? ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount:list.length,
      itemBuilder: (BuildContext context, int index) {
        Data item = list[index];

        String date=MetaDateTime().getDate(item.startDate.toString(),format: "dd MMM");
        // Map date = {
        //   "text" : MetaDateTime().getDate(item.startDate.toString(),format: "dd MMM"),
        //   "color" : "0xFF2854A1",
        //   "size": "16",
        //   "family": "bold",
        //   "align" : "center"
        // };

        Map week = {
          "text" :date+", "+ MetaDateTime().getDate(item.startDate.toString(),format: "EEE").toUpperCase(),
          "color" : "0xFFFFFFFF",
          "size": "13",
          "family": "bold",
          "align" : "center-right"
        };


        Map recordLocator = {
          "text" :"#"+ item.tripNumber.toString().toUpperCase(),
          "color" : "0xFFFFFFFF",
          "size": "14",
          "family": "bold",
          "align" : "center-left"
        };

        Map code = {
          "text" :"#"+ item.tripNumber.toString().toUpperCase(),
          "color" : "0xFF2854A1",
          "size": "17",
          "family": "bold",
          "align" : "center-left"
        };


        return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Card(
              color: Color(0xFF2854A1),
              elevation: 5,
              child: Container(
                width: cardHt,
                height: cardHt,
                child: Column(
                  children: [
                    Container(
                      height:cardHt * 0.3,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: MetaTextView(mapData: recordLocator)
                            ),
                            Container(
                                margin: EdgeInsets.only(right: 5.w),
                                height:cardHt * 0.25,
                                child: MetaTextView( mapData: week)
                            )
                          ],
                        ),
                      ),
                    ),

                    Container(
                      color: Color(0xFFFFFFFF),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            height: cardHt * 0.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    child: MetaTextView(mapData: code,text: item.origin.toString().toUpperCase())
                                ),

                                Container(
                                    child: MetaTextView(mapData: code,text: item.destination.toString().toUpperCase())
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
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
    bloc!.add(GetUpcomingListEvent());
  }

  Future<void> _pullRefresh() async {
    callBloc();
  }


}
