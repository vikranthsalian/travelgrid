import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/extensions/capitalize.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/data/blocs/approval_expense/ae_bloc.dart';
import 'package:travelgrid/data/datasources/list/ge_list_response.dart';
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/components/filterby_component.dart';
import 'package:travelgrid/presentation/components/sortby_component.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';


class ApprovalGE extends StatelessWidget {
  String data;
  ApprovalGE({required this.data});
  List items=[];
  double cardHt = 90.h;

  ApprovalExpenseBloc? bloc;
  Map<String,dynamic> mapData={};


  int selected=0;
 // int filterSelected=0;
  String sortedBy="Default";
  List<String> filterSelected=["All"];
  List<String> filterOptions=["All"];

  @override
  Widget build(BuildContext context) {

     mapData = FlavorConfig.instance.variables[data];
     bloc=Injector.resolve<ApprovalExpenseBloc>();
     callBloc();


    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color:ParseDataType().getHexToColor(mapData['backgroundColor']),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        elevation: 2.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MetaButton(mapData: mapData['bottomButtonLeft'],
                text: "Cancel",
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
            MetaButton(mapData: mapData['bottomButtonRight'],
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
      body: BlocBuilder<ApprovalExpenseBloc, ApprovalExpenseState>(
          bloc: bloc,
          builder:(context, state) {
            mapData['listView']['recordsFound']['value'] = 0;
            return Container(
                child: BlocMapToEvent(state: state.eventState, message: state.message,
                    callback: (){
                       mapData['listView']['recordsFound']['value'] = state.responseGE?.data?.length;


                       if(state.responseGE?.data==null)
                         return ;

                       for(var item in state.responseGE!.data!){
                         filterOptions.add(item.status!);
                       }
                       filterOptions = filterOptions.toSet().toList();

                    },
                    topComponent:Container(
                      color:ParseDataType().getHexToColor(mapData['backgroundColor']),
                      child:  Column(
                        children: [
                          SizedBox(height:5.h),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            child:MetaTextView(mapData: mapData['listView']['recordsFound']),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                child:MetaTextView(mapData: mapData['listView']['recordsFound'],text: "Sorted By : "+sortedBy),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                child:MetaTextView(mapData: mapData['listView']['recordsFound'],text: "Filtered By : "+filterSelected.length.toString()),
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


  Widget getListView(ApprovalExpenseState state){

    List<Data>? list = state.responseGE?.data ?? [];

    return  list.isNotEmpty ? ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        Data item = list[index];

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
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          height: cardHt * 0.27,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed(mapData['onClick'],
                                    arguments: {
                                        "isEdit": false,
                                      "isApproval":true,
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
        MetaTextView(mapData: mapData['listView']['emptyData']['title']),
        SizedBox(height: 10.h,),
        MetaButton(mapData: mapData['listView']['emptyData']['bottomButtonRefresh'],
            onButtonPressed: (){
              callBloc();
            })
      ],
    );
  }


  void callBloc() {
    bloc!.add(GetApprovalExpenseGE(selected,filterSelected));
  }

  Future<void> _pullRefresh() async {
    callBloc();
  }

}
