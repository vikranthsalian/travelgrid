import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/capitalize.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/data/blocs/travel_expense/te_bloc.dart';
import 'package:travelgrid/data/datasources/summary/te_summary_response.dart' as ts;
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/components/filterby_component.dart';
import 'package:travelgrid/presentation/components/sortby_component.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

import '../../../../data/datasources/list/te_list_response.dart';

class TravelExpense extends StatelessWidget {
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;
  TravelExpenseBloc? bloc;

  int selected=0;
 // int filterSelected=0;
  String sortedBy="Default";
  List<String> filterSelected=["All"];
  List<String> filterOptions=["All"];
  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.teData;
    bloc = Injector.resolve<TravelExpenseBloc>();
    callBloc();


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
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                          SortComponent(
                              type: "ge",
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
      body: BlocBuilder<TravelExpenseBloc, TravelExpenseState>(
          bloc: bloc,
          builder:(context, state) {
            jsonData['listView']['recordsFound']['value'] = 0;
            return Container(
                child: BlocMapToEvent(state: state.eventState, message: state.message,
                    callback: (){
                       jsonData['listView']['recordsFound']['value'] = state.response?.data?.length;

                       if(state.response?.data==null)
                       return ;
                       for(var item in state.response!.data!){
                         filterOptions.add(item.status!);
                       }
                       filterOptions = filterOptions.toSet().toList();
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

  Future<void> _pullRefresh() async {
    callBloc();
  }

  void callBloc() {
    bloc = Injector.resolve<TravelExpenseBloc>()..add(GetTravelExpenseListEvent(selected,filterSelected));
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
          "text" :"Amount : ".toUpperCase()+ item.totalAmount.toString().inRupeesFormat(),
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
                                       callBloc();
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
                                 callBloc();
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
            callBloc();
            })
      ],
    );
  }

}
