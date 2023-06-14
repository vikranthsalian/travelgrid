import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/data/blocs/travel_request/tr_bloc.dart';
import 'package:travelgrid/data/datasources/list/tr_list_response.dart';
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/components/dialog_trip_type.dart';
import 'package:travelgrid/presentation/components/filterby_component.dart';
import 'package:travelgrid/presentation/components/sortby_component.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class TravelRequest extends StatelessWidget {
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;

  TravelRequestBloc? bloc;

  int selected=0;
 // int filterSelected=0;
  String sortedBy="Default";

  List<String> filterSelected=["All"];
  List<String> filterOptions=["All"];


  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.trData;

     bloc = Injector.resolve<TravelRequestBloc>();
     callBloc();


    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  FloatingActionButton(
        child:MetaIcon(mapData:jsonData['bottomButtonFab'],onButtonPressed: ()async{
          if(jsonData['bottomButtonFab']['onClick'].isNotEmpty){

            await showDialog(
                context: context,
                builder: (_) => DialogTripType(
                    title: "Select Trip Type",
                    onPressed: (value){

                        Navigator.of(context).pushNamed(jsonData['bottomButtonFab']['onClick'],
                            arguments: {
                          'tripType':value,
                          'isEdit':false,
                        }).then((value) {
                          callBloc();
                        });

                    }));

          }
        },),
        backgroundColor: ParseDataType().getHexToColor(jsonData['backgroundColor']),
        onPressed: () {}),
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
      body: BlocBuilder<TravelRequestBloc, TravelRequestState>(
          bloc: bloc,
          builder:(context, state) {
            jsonData['listView']['recordsFound']['value'] = 0;
            return Container(
                child: BlocMapToEvent(state: state.eventState, message: state.message,
                    callback: (){
                       jsonData['listView']['recordsFound']['value'] = state.response?.data?.length;

                       if(state.response?.data== null)
                         return;

                       for(var item in state.response!.data!){
                         filterOptions.add(item.currentStatus.toString());
                         filterOptions.add(item.tripPlan.toString());
                         filterOptions.add(item.tripType.toString());
                       }
                       filterOptions = filterOptions.toSet().toList();

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


  Widget getListView(TravelRequestState state){

    List<Data>? list = state.response?.data ?? [];

    return  list.isNotEmpty ? ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount:list.length,
      itemBuilder: (BuildContext context, int index) {
        Data item = list[index];

        bool isVisible=false;
        if(item.currentStatus!.toLowerCase() == "take back"){
          isVisible=true;
        }

        Map date = {
          "text" : MetaDateTime().getDate(item.startDate.toString(),format: "dd MMM"),
          "color" : "0xFF2854A1",
          "size": "20",
          "family": "bold",
          "align" : "center"
        };

        Map week = {
          "text" : MetaDateTime().getDate(item.startDate.toString(),format: "EEE").toUpperCase(),
          "color" : "0xFF2854A1",
          "size": "13",
          "family": "bold",
          "align" : "center-right"
        };

        Map trip = {
          "text" : item.tripPlan.toString().toUpperCase(),
          "color" : "0xFFFFFFFF",
          "size": "10",
          "family": "semiBold",
          "align" : "center"
        };

        Map recordLocator = {
          "text" :"#"+ item.tripNumber.toString().toUpperCase(),
          "color" : "0xFF2854A1",
          "size": "12",
          "family": "bold",
          "align" : "center-left"
        };

        Map code = {
          "text" :"#"+ item.tripNumber.toString().toUpperCase(),
          "color" : "0xFF2854A1",
          "size": "20",
          "family": "bold",
          "align" : "center-left"
        };

        Map subtitle = {
          "text" :"#"+ item.tripNumber.toString().toUpperCase(),
          "color" : "0xFF000000",
          "size": "10",
          "family": "bold",
          "align" : "center-left"
        };

        Map thirdTitle = {
          "text" :"#"+ item.tripNumber.toString().toUpperCase(),
          "color" : "0xFFCCCCCC",
          "size": "9",
          "family": "bold",
          "align" : "center-left"
        };


        Map status = {
          "text" :item.currentStatus!.toUpperCase(),
          "color" : "0xFFFFFFFF",
          "size": "7",
          "family": "bold",
          "align" : "center-left"
        };

        Map view = {
          "text" :"View".toUpperCase(),
          "color" : "0xFFFFFFFF",
          "size": "12",
          "family": "bold",
          "align" : "center"
        };

        Map edit = {
          "text" :"Edit".toUpperCase(),
          "color" : "0xFFFFFFFF",
          "size": "12",
          "family": "bold",
          "align" : "center"
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
                                height: cardHt * 0.40,
                                child: MetaTextView(mapData: date)
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 5.w),
                                height:cardHt * 0.25,
                                child: MetaTextView( mapData: week)
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: cardHt * 0.27,
                        child: MetaTextView( mapData: trip),
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
                                height: cardHt * 0.14,
                                child:Container(
                                    child: MetaTextView(mapData: recordLocator)
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                height: cardHt * 0.23,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: MetaTextView(mapData: code,text: item.maCityPairs?.first.leavingFrom?.cityCode ?? "")
                                    ),
                                    Container(
                                        child: MetaTextView(mapData: code,text: item.maCityPairs?.last.goingTo?.cityCode ?? "")
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                height: cardHt * 0.15,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: MetaTextView(mapData: subtitle,text:  item.maCityPairs?.first.leavingFrom!.name!.toUpperCase())
                                    ),
                                    Container(
                                        child: MetaTextView(mapData: subtitle,text:item.maCityPairs?.first.goingTo!.name!.toUpperCase())
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                height: cardHt * 0.13,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: MetaTextView(mapData: thirdTitle,text: item.startDate,)
                                    ),
                                    Container(
                                        child: MetaTextView(mapData: thirdTitle,text:item.endDate)
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: cardHt * 0.27,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                             Expanded(
                               flex: 4,
                                 child: Container(
                                   margin: EdgeInsets.symmetric(horizontal: 5.w),
                                   alignment: Alignment.centerLeft,
                                     child: MetaTextView( mapData: status))),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: (){
                                          Navigator.of(context).pushNamed(jsonData['bottomButtonFab']['onClick'],
                                              arguments: {
                                                "isEdit": true,
                                                "status": item.currentStatus!.toLowerCase(),
                                                "tripType":item.tripType=="Domestic"?"D":"O",
                                                "title": item.tripNumber.toString().toUpperCase()
                                              }).then((value) {
                                          });
                                        },
                                        child: Container(
                                            child:  Visibility(
                                                visible: isVisible,
                                                child: MetaTextView( mapData: edit)))),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                                      child: MetaTextView(mapData: {
                                        "text" :"|",
                                        "color" : "0xFFFFFFFF",
                                        "size": "12",
                                        "family": "bold",
                                        "align" : "center"
                                      }),
                                    ),
                                    InkWell(
                                        onTap: (){
                                          Navigator.of(context).pushNamed(jsonData['listView']['onClick'],
                                              arguments: {
                                                "isEdit": false,
                                                "status": item.currentStatus!.toLowerCase(),
                                                "isApproval":false,
                                                "title": item.tripNumber.toString().toUpperCase()
                                              }).then((value) {
                                                callBloc();
                                          });
                                        },
                                        child: Container(
                                            child: MetaTextView( mapData:  view )))
                                  ],
                                ),
                              )

                          ]),
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
    bloc!.add(GetTravelRequestListEvent(selected,filterSelected));
  }

  Future<void> _pullRefresh() async {
    callBloc();
  }


}
