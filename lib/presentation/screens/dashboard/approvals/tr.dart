import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/blocs/approval_expense/ae_bloc.dart';
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:travelgrid/data/datasources/list/tr_list_response.dart';

class ApprovalTR extends StatefulWidget {
  String data;
  ApprovalTR({required this.data});
  @override
  _ApprovalTRState createState() => _ApprovalTRState();
}

class _ApprovalTRState extends State<ApprovalTR> {
  List items=[];
  double cardHt = 90.h;
  bool enableSearch = false;
  final TextEditingController _searchController = TextEditingController();
  bool loaded=false;
  ApprovalExpenseBloc? bloc;
  Map<String,dynamic> mapData={};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapData = FlavorConfig.instance.variables[widget.data];
  }


  @override
  Widget build(BuildContext context) {

   if(!loaded){
     bloc = Injector.resolve<ApprovalExpenseBloc>()..add(GetApprovalExpenseTR());
     loaded=true;
   }

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
                onButtonPressed: (){

                }
            ),
            MetaButton(mapData: mapData['bottomButtonRight'],
                onButtonPressed: (){

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
                       mapData['listView']['recordsFound']['value'] = state.responseTR?.data?.length;
                    },
                    topComponent:Container(
                      color:ParseDataType().getHexToColor(mapData['backgroundColor']),
                      child:  Column(
                        children: [
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
                            child:MetaTextView(mapData: mapData['listView']['recordsFound']),
                          ),
                          SizedBox(height:5.h),
                        ],
                      ),
                    ),
                    child:getListView(state)
                )
            );
          }
      ),
    );
  }


  Widget getListView(ApprovalExpenseState state){

    List<Data>? list = state.responseTR?.data ?? [];

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
          "size": "15",
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

        Map view = {
          "text" :"View".toUpperCase(),
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
                              // Container(
                              //   margin: EdgeInsets.symmetric(horizontal: 15.w),
                              //   height: cardHt * 0.30,
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Container(
                              //           child: MetaTextView(mapData: recordLocator,text: "IXE",)
                              //       ),
                              //       Container(
                              //           child: MetaTextView(mapData: recordLocator,text:"BLR")
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15.w),
                                height: cardHt * 0.35,
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
                                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                                  height: cardHt * 0.3,
                                  child: MetaTextView(mapData: recordLocator)
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: cardHt * 0.27,
                          child:  Container(
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
                                              item.tripNumber!.toString()
                                                  .toUpperCase()
                                            }).then((value) {
                                          bloc!.add(GetApprovalExpenseTR());
                                        });
                                      },
                                      child: MetaTextView( mapData:  view ))
                                ]),
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
      itemCount:list.length,
    ):  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MetaTextView(mapData: mapData['listView']['emptyData']['title']),
        SizedBox(height: 10.h,),
        MetaButton(mapData: mapData['listView']['emptyData']['bottomButtonRefresh'],
            onButtonPressed: (){

            })
      ],
    );
  }

}