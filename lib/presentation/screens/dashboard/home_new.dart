import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/data/blocs/travel_request/tr_bloc.dart';
import 'package:travelgrid/presentation/components/dialog_trip_type.dart';
import 'package:travelgrid/presentation/components/drawer.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:tuple/tuple.dart';

class HomeNewPage extends StatefulWidget {
  @override
  _HomeNewPageState createState() => _HomeNewPageState();
}

class _HomeNewPageState extends State<HomeNewPage> {

  TravelRequestBloc? bloc;
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();


  int _currentPage = 0;
  int nextPage=0;
  PageController _controller=PageController();


  @override
  Widget build(BuildContext context) {
    //
    // bloc = Injector.resolve<TravelRequestBloc>();
    // callBloc();
    //

    return Scaffold(
      key: _scaffoldKey,
      drawer: WidgetDrawer(),
      backgroundColor:Colors.white,
      body: Container(
        child: Column(
          children: [
            Container(
              padding:  EdgeInsets.only(top: 40.h,right: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child:
                    MetaIcon(
                        mapData:{
                          "icon": "sort",
                          "size": 30.0,
                          "color": "0xFF2854A1",
                          "backgroundColor": "transparent",
                          "onPress": true,
                          "align": "center"
                        },
                        onButtonPressed: (){
                          Timer(
                              const Duration(milliseconds: 10),() =>{
                            _scaffoldKey.currentState?.openDrawer()
                          }
                          );
                        })
                  ),
                  Container(width: 150.w,
                    height: 35.h,
                    child: MetaButton(mapData:{
                      "text" : "NH Travelgrid",
                      "color" : "0xFFFFFFFF",
                      "backgroundColor" : "0xFF2854A1",
                      "size": "18",
                      "family": "regular",
                      "borderRadius": 15.0
                    },
                        onButtonPressed: (){

                        }
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: MetaTextView(mapData: {
                "text" : "Hi, What would like to do?",
                "color" : "0xFF000000",
                "size": "18",
                "family": "bold",
                "align": "center-left"
              }),
            ),
            SizedBox(height: 20.h,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: ()async{
                        await showDialog(
                        context: context,
                        builder: (_) => DialogTripType(
                            title: "Select Trip Type",
                            onPressed: (value){

                              Navigator.of(context).pushNamed(RouteConstants.travelCreateRequestPath,
                                  arguments: {
                                    'tripType':value,
                                    'isEdit':false,
                                  });

                            }));
                       },
                        child: buildCard("New TR","briefcase.svg"))
                  ),
                  Expanded(
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(RouteConstants.generalCreateExpensePath);
                        },
                          child: buildCard("New GE","conv.svg"))
                  )
                ],
              ),
            ),
            SizedBox(height: 30.h,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(RouteConstants.upcomingTRPath);
                        },
                        child: buildCard2("Upcoming TR","calendar.svg")),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(RouteConstants.walletPath,arguments: {
                          "selectable":false
                        });
                      },
                        child: buildCard2("Documents","pdf.svg")),
                  )
                ],
              ),
            ),
            SizedBox(height: 50.h,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              height: 100.h,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                onPageChanged: _onchanged,
                controller: _controller,
                itemCount: items.length,
                itemBuilder: (context, int index) {

                  return InkWell(
                    onTap: () {
                        Navigator.of(appNavigatorKey.currentState!.context).pushNamed(items[index]["onClick"]);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: getColor(items[index]['cardColor']),
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 60.w,
                            width: 60.w,
                            child: MetaSVGView(mapData: items[index]['svgIcon']),
                          ),
                          MetaTextView(mapData:items[index]['label']),
                        ],
                      ),
                    ),
                  );

                  // return Container(
                  //   color: Colors.white,
                  //   child: Image.asset(
                  //     data[index].item2,
                  //     fit: BoxFit.cover,
                  //   ),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildCard2(text,icon) {
    return Card(
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    height: 50.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 20.w,
                          width: 20.w,
                          child: MetaSVGView(mapData: {
                            "icon": icon
                          }),
                        ),
                        SizedBox(width: 5.w),
                        MetaTextView(
                            mapData: {
                          "text" : text,
                          "color" : "0xFF000000",
                          "size": "13",
                          "family": "bold",
                          "align": "center"
                        }),

                      ],
                    ),
                  ),
                  );
  }

  Card buildCard(text,icon) {
    return Card(
                  elevation: 10,
                  child: Container(
                    height: 100.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50.w,
                          width: 50.w,
                          child: MetaSVGView(mapData: {
                            "icon": icon,
                            "color" : "0xFF000000"
                          }),
                        ),
                        MetaTextView(mapData: {
                          "text" : text,
                          "color" : "0xFF000000",
                          "size": "18",
                          "family": "bold",
                          "align": "center"
                        }),
                      ],
                    ),
                  ),
                  );
  }


  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }
  Map<String,dynamic> jsonData ={};
  List items=[];
  @override
  initState() {
    super.initState();
    jsonData = {
     "badges": [
      {
        "main": 2,
        "cross": 2,
        "label":{
          "text" : "Travel Request",
          "color" : "0XFFFFFFFF",
          "size": "18",
          "family": "regular"
        },
        "count":{
          "text" : "20",
          "color" : "0XFF000000",
          "size": "16",
          "family": "bold"
        },
        "svgIcon":{
          "icon": "briefcase.svg",
          "color" : "0XFFFFFFFF"
        },
        "cardColor": [
          "0XFF2193b0",
          "0XFF6dd5ed"
        ],
        "onClick": "/travelRequest"
      },
      {
        "main": 2,
        "cross": 2,
        "label":{
          "text" : "Travel Expenses",
          "color" : "0XFFFFFFFF",
          "size": "18",
          "family": "regular"
        },
        "count":{
          "text" : "18",
          "color" : "0XFF000000",
          "size": "16",
          "family": "bold"
        },
        "svgIcon":{
          "icon": "misc.svg",
          "color" : "0XFFFFFFFF"
        },
        "cardColor": [
          "0XFF7b4397",
          "0XFFdc2430"
        ],
        "onClick": "/travelExpense"
      },
      {
        "main": 2,
        "cross": 2,
        "label":{
          "text" : "Approvals",
          "color" : "0XFFFFFFFF",
          "size": "18",
          "family": "regular"
        },
        "count":{
          "text" : "18",
          "color" : "0XFF000000",
          "size": "16",
          "family": "bold"
        },
        "svgIcon":{
          "icon": "approve.svg",
          "color" : "0XFFFFFFFF"
        },
        "cardColor": [
          "0XFF5C258D",
          "0XFF4389A2"
        ],
        "onClick": "/approvalExpense"
      },
      {
        "main": 2,
        "cross": 2,
        "label":{
          "text" : "General Expenses",
          "color" : "0XFFFFFFFF",
          "size": "18",
          "family": "regular"
        },
        "count":{
          "text" : "18",
          "color" : "0XFF000000",
          "size": "16",
          "family": "bold"
        },
        "svgIcon":{
          "icon": "conv.svg",
          "color" : "0XFFFFFFFF"
        },
        "cardColor": [
          "0XFFFF8008",
          "0XFFFFC837"
        ],
        "onClick": "/generalExpense"
      }
    ]
    };

    for(var badges in jsonData['badges']){
      items.add(badges);
    }
    if (_controller!=null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _animateSlider());
    }
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateSlider() {
    Future.delayed(Duration(seconds: 2)).then((_) {

      nextPage = nextPage + 1;

      print("nextpage: "+nextPage.toString());

      if (nextPage == items.length) {
        nextPage = 0;
      }
      try {
        _controller
            .animateToPage(
            nextPage, duration: Duration(seconds: 1), curve: Curves.linear)
            .then((_) => _animateSlider());
      }catch(e){

      }
    });
  }
  List<Color> getColor(List items) {
    List<Color> colors=[];
    for(var color in items){
      colors.add(ParseDataType().getHexToColor(color));
    }
    return colors;
  }
}
