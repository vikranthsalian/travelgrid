import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/data/blocs/general_expense/ge_bloc.dart';
import 'package:travelgrid/data/datsources/general_expense_list.dart';
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/components/clippers/app_bar_shape.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class GeneralExpense extends StatefulWidget {
  @override
  _GeneralExpenseState createState() => _GeneralExpenseState();
}

class _GeneralExpenseState extends State<GeneralExpense> {
  Map<String,dynamic> jsonData = {};
  List items=[];
  double cardHt = 90.h;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.geData;
    prettyPrint(jsonData);
  }


  @override
  Widget build(BuildContext context) {

   GeneralExpenseBloc bloc = Injector.resolve<GeneralExpenseBloc>()..add(GetGeneralExpenseListEvent());


    return Scaffold(
      // extendBody for floating bar get better perfomance
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  FloatingActionButton(
        child:MetaIcon(mapData:jsonData['bottomButtonFab'],
        onButtonPressed: (){}),
        backgroundColor: ParseDataType().getHexToColor(jsonData['app_bar']['backgroundColor']),
        onPressed: () {  },),
      bottomNavigationBar:
      BottomAppBar(
        color:ParseDataType().getHexToColor(jsonData['app_bar']['backgroundColor']),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        elevation: 2.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MetaButton(mapData: jsonData['bottomButtonSort'],
                onButtonPressed: (){

                }
            ),
            MetaButton(mapData: jsonData['bottomButtonFilter'],
                onButtonPressed: (){

                }
            )
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading:false,
        toolbarHeight: 130.h,
        flexibleSpace: ClipPath(
          clipper: Customshape(),
          child: Container(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color:ParseDataType().getHexToColor(jsonData['app_bar']['backgroundColor']),
                  child: Center(child: MetaTextView(mapData: jsonData['app_bar']['title'])),
                ),
                MetaIcon(mapData:jsonData['app_bar']['leading'],
                    onButtonPressed: (){

                    })
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<GeneralExpenseBloc, GeneralExpenseState>(
        bloc: bloc,
        builder:(context, state) {

          return Container(
            child: BlocMapToEvent(state: state.eventState, message: state.message,
                child:getListView(state)
            )

          );
        }
      ),
      //  bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget getListView(GeneralExpenseState state){

    List<Data>? list = state.response?.data ?? [];

    print("-----------GeneralExpenseState-----------");
    print(list);

    return  list.isNotEmpty ? ListView.separated(
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
          "text" :"GE Amount : "+ item.totalAmount.toString().toUpperCase(),
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
          "text" :"Cancel".toUpperCase(),
          "color" : "0xFFFFFFFF",
          "size": "12",
          "family": "bold",
          "align" : "center"
        };


        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                        height: 7.h,
                      ),
                      Container(
                        color: Color(0xFFFFFFFF),
                        child: Column(
                          children: [
                            Container(
                                height: 35.h,
                                child: MetaTextView(mapData: date)
                            ),
                            Container(
                                height: 25.h,
                                child: MetaTextView( mapData: week)
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 23.h,
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
                          height: 7.h,
                        ),
                        Container(
                          color: Color(0xFFFFFFFF),
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                                  height: 35.h,
                                  child: MetaTextView(mapData: recordLocator)
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                                  height: 25.h,
                                  child: MetaTextView(mapData: amount)
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          height: 23.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                             MetaTextView( mapData: view),
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
                            MetaTextView( mapData: cancel),
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
        return SizedBox(height: 7.h);
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
