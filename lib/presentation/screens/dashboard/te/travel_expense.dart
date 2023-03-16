import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/data/blocs/travel_expense/te_bloc.dart';
import 'package:travelgrid/data/datasources/summary/te_summary_response.dart' as ts;
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

import '../../../../data/datasources/list/te_list_response.dart';

class TravelExpense extends StatefulWidget {
  @override
  _TravelExpenseState createState() => _TravelExpenseState();
}

class _TravelExpenseState extends State<TravelExpense> {
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;
  bool enableSearch = false;
  final TextEditingController _searchController = TextEditingController();
  bool loaded=false;
  TravelExpenseBloc? bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.teData;
    //prettyPrint(jsonData);
  }


  @override
  Widget build(BuildContext context) {

   if(!loaded){
     bloc = Injector.resolve<TravelExpenseBloc>()..add(GetTravelExpenseListEvent());
     loaded=true;
   }

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

                }
            ),
            MetaButton(mapData: jsonData['bottomButtonRight'],
                onButtonPressed: (){

                }
            )
          ],
        ),
      ),
      body: BlocBuilder<TravelExpenseBloc, TravelExpenseState>(
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


  Widget getListView(TravelExpenseState state){

    List<Data>? list = state.response?.data ?? [];

    return  list.isNotEmpty ? ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        Data item = list[index];

        bool isVisible=false;
        if(item.status!.toLowerCase()=="create" || item.status!.toLowerCase()=="take back"){
          isVisible=true;
        }

        Map date = {
          "text" : MetaDateTime().getDate(item.date.toString(),format: "dd MMM"),
          "color" : "0xFF2854A1",
          "size": "20",
          "family": "bold",
          "align" : "center"
        };

        Map week = {
          "text" : MetaDateTime().getDate(item.date.toString(),format: "EEE").toUpperCase(),
          "color" : "0xFF2854A1",
          "size": "13",
          "family": "bold",
          "align" : "center-right"
        };

        Map status = {
          "text" : item.status.toString().toUpperCase(),
          "color" : "0xFFFFFFFF",
          "size": "8",
          "family": "semiBold",
          "align" : "center"
        };

        Map recordLocator = {
          "text" :"#"+ item.recordLocator.toString().toUpperCase(),
          "color" : "0xFF2854A1",
          "size": "15",
          "family": "bold",
          "align" : "center-left"
        };

        Map amount = {
          "text" :"Amount : "+ item.totalAmount.toString().toUpperCase(),
          "color" : "0xFF000000",
          "size": "12",
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

        Map cancel = {
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
                        child: MetaTextView( mapData: status),
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
                                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                                  height: cardHt * 0.40,
                                  child: MetaTextView(mapData: recordLocator)
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                                  height: cardHt * 0.25,
                                  child: MetaTextView(mapData: amount)
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          height: cardHt * 0.27,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                             InkWell(
                                    onTap: (){
                                      Navigator.of(context).pushNamed(jsonData['listView']['onClick'],
                                          arguments: {
                                            "isEdit": true,
                                            "status" :item.status,
                                            "isApproval":false,
                                            "response":ts.TESummaryResponse(),
                                            "title": item.recordLocator.toString()
                                                .toUpperCase()
                                          }).then((value) {
                                        bloc!.add(GetTravelExpenseListEvent());
                                      });
                                    },
                                 child: Visibility(
                                   visible: isVisible,
                                     child: MetaTextView( mapData: cancel))
                             ),
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
                                Navigator.of(context).pushNamed(jsonData['listView']['onClick'],
                                    arguments: {
                                        "isEdit": false,
                                        "status" :item.status,
                                        "isApproval":false,
                                        "title":
                                            item.recordLocator.toString()
                                                .toUpperCase()
                                }).then((value) {
                                  bloc!.add(GetTravelExpenseListEvent());
                                });
                                },
                                child: MetaTextView( mapData:  view ))
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
