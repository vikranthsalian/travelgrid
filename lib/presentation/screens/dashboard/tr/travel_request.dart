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
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class TravelRequest extends StatefulWidget {
  @override
  _TravelRequestState createState() => _TravelRequestState();
}

class _TravelRequestState extends State<TravelRequest> {
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;
  bool enableSearch = false;
  final TextEditingController _searchController = TextEditingController();
  bool loaded=false;
  TravelRequestBloc? bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.trData;

  }


  @override
  Widget build(BuildContext context) {

   if(!loaded){
     bloc = Injector.resolve<TravelRequestBloc>()..add(GetTravelRequestListEvent());
     loaded=true;
   }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  FloatingActionButton(
        child:MetaIcon(mapData:jsonData['bottomButtonFab'],onButtonPressed: ()async{
          if(jsonData['bottomButtonFab']['onClick'].isNotEmpty){

           Navigator.of(context).pushNamed(jsonData['bottomButtonFab']['onClick']).then((value) {
             bloc!.add(GetTravelRequestListEvent());
           });
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

                }
            ),
            MetaButton(mapData: jsonData['bottomButtonRight'],
                onButtonPressed: (){

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
                    },
                    topComponent:Container(
                      color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                      height: 110.h,
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
                          // Container(
                          //   margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 5.h),
                          //   padding: EdgeInsets.symmetric(vertical: 5.h),
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(8.r),
                          //       color: Color(0xFFFFFFFF),
                          //       border: Border.all(color: Colors.black12)),
                          //   child: SearchBarComponent(
                          //     barHeight: 40.h,
                          //     hintText: "Search.....",
                          //     searchController: _searchController,
                          //     onClear: (){
                          //
                          //     },
                          //     onSubmitted: (text) {
                          //
                          //     },
                          //     onChange: (text) {
                          //
                          //     },
                          //   ),
                          // ),
                          SizedBox(height:5.h),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            child:MetaTextView(mapData: jsonData['listView']['recordsFound']),
                          ),
                          SizedBox(height:5.h),
                        ],
                      ),
                    ),
                    child:Transform.translate(
                        offset: Offset(0,0.h),
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
      itemBuilder: (BuildContext context, int index) {
        Data item = list[index];

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
          "size": "25",
          "family": "bold",
          "align" : "center-left"
        };

        Map subtitle = {
          "text" :"#"+ item.tripNumber.toString().toUpperCase(),
          "color" : "0xFF000000",
          "size": "12",
          "family": "bold",
          "align" : "center-left"
        };

        Map thirdTitle = {
          "text" :"#"+ item.tripNumber.toString().toUpperCase(),
          "color" : "0xFFCCCCCC",
          "size": "10",
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
          padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                                margin: EdgeInsets.symmetric(horizontal: 15.w),
                                height: cardHt * 0.30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: MetaTextView(mapData: recordLocator,text: "IXE",)
                                    ),
                                    Container(
                                        child: MetaTextView(mapData: recordLocator,text:"BLR")
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15.w),
                                height: cardHt * 0.15,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: MetaTextView(mapData: subtitle,text: item.origin)
                                    ),
                                    Container(
                                        child: MetaTextView(mapData: subtitle,text:item.destination)
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15.w),
                                height: cardHt * 0.20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: MetaTextView(mapData: thirdTitle,text: "10:00",)
                                    ),
                                    Container(
                                        child: MetaTextView(mapData: thirdTitle,text:"16:45")
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
                               flex: 3,
                                 child: Container(
                                   margin: EdgeInsets.symmetric(horizontal: 5.w),
                                   alignment: Alignment.centerLeft,
                                     child: MetaTextView( mapData: status))),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: (){
                                          Navigator.of(context).pushNamed(jsonData['bottomButtonFab']['onClick'],
                                              arguments: {
                                                "isEdit": false,
                                                "isApproval":false,
                                                "status" :item.currentStatus,
                                                "title":
                                                item.tripNumber.toString()
                                                    .toUpperCase()
                                              }).then((value) {
                                            bloc!.add(GetTravelRequestListEvent());
                                          });
                                        },
                                        child: Container(
                                            child: MetaTextView( mapData:  edit ))),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 5.w),
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
                                          Navigator.of(context).pushNamed(jsonData['bottomButtonFab']['onClick'],
                                              arguments: {
                                                "isEdit": false,
                                                "isApproval":false,
                                                "status" :item.currentStatus,
                                                "title":
                                                item.tripNumber.toString()
                                                    .toUpperCase()
                                              }).then((value) {
                                            bloc!.add(GetTravelRequestListEvent());
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
      itemCount:list.length,
    ):  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MetaTextView(mapData: jsonData['listView']['emptyData']['title']),
        SizedBox(height: 10.h,),
        MetaButton(mapData: jsonData['listView']['emptyData']['bottomButtonRefresh'],
            onButtonPressed: (){

            })
      ],
    );
  }

}
