import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/blocs/travel_request/tr_bloc.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/usecases/common_usecase.dart';
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/components/dialog_yes_no.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travelgrid/data/datasources/list/tr_upcoming_response.dart' as trData;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String,dynamic> jsonData = {};
  List items=[];
  String?  dateText;
  String  fullname="";
  double cardHt =50.h;
  @override
  void initState() {
    super.initState();
    jsonData = FlavourConstants.homeData;
    for(var badges in jsonData['badges']){
      items.add(badges);
    }

  MetaLoginResponse  loginResponse = context.read<LoginCubit>().getLoginResponse();
    fullname=loginResponse.data!.fullName??"";

    dateText = DateFormat('dd MMM y, EEEE').format(DateTime.now());
  }
  TravelRequestBloc? bloc;

  @override
  Widget build(BuildContext context) {

    bloc = Injector.resolve<TravelRequestBloc>();
    callBloc();


    return Scaffold(
      backgroundColor:ParseDataType().getHexToColor(jsonData['backgroundColor']),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Container(
                height: 125.h,
                decoration: BoxDecoration(
                  color: ParseDataType().getHexToColor(jsonData['backgroundColor']),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.r))
                ),
                child: Column(
                  children: [
                    SizedBox(height:30.h),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListTile(
                              leading: InkWell(
                                onTap:(){
                                  Navigator.pushNamed(context, RouteConstants.profilePath);
                                 },
                                child: Container(
                                    height: 50.w,
                                    width: 50.w,
                                    child: MetaSVGView(mapData:  jsonData['svgIcon']),
                                ),
                              ) ,
                              title: Container(
                                child:MetaTextView(mapData: jsonData['label']),
                              ),
                              subtitle: Container(
                                child:MetaTextView(mapData: jsonData['title'],text:fullname),
                              ),
                            ),
                          ),
                          MetaIcon(mapData:jsonData['logout'],
                              onButtonPressed: ()async{
                            await showDialog(
                            context: context,
                            builder: (_) => DialogYesNo(
                                title: "Do you want to logout?",
                                onPressed: (value)async{
                                  if(value == "YES"){
                                    SuccessModel model =   await Injector.resolve<CommonUseCase>().logOut();
                                    if(model.token == null){
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(RouteConstants.loginPath,
                                              (Route<dynamic> route) => false);
                                    }

                                  }
                                }));
                              }),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child:MetaTextView(mapData: jsonData['date'],text: dateText),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
              //  color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(40.r))
                  ),

                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10.h),
                        margin: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10.w))
                        ),
                        child:StaggeredGrid.count(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          children: items.map((e) => StaggeredGridTile.count(
                            crossAxisCellCount: e['cross'],
                            mainAxisCellCount: e['main'],
                            child: InkWell(
                              onTap: () {

                                if(e["onClick"].isNotEmpty){
                                  print(e["onClick"]);
                                  Navigator.of(appNavigatorKey.currentState!.context).pushNamed(e["onClick"]);
                                }else{
                                  MetaAlert.showErrorAlert(
                                    message: "Yet to be configured",
                                  );
                                }


                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: getColor(e['cardColor']),
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  Container(
                                      height: 80.w,
                                      width: 80.w,
                                      child: MetaSVGView(mapData:  e['svgIcon']),
                                    ),
                                    MetaTextView(mapData:e['label']),
                                  ],
                                ),
                              ),
                            ),
                          )).toList(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: MetaButton(mapData: jsonData['policiesButton'],
                                  onButtonPressed: (){
                                    if(jsonData['policiesButton']["onClick"].isNotEmpty) {
                                      Navigator.of(appNavigatorKey.currentState!.context).pushNamed(jsonData['policiesButton']["onClick"]);
                                    }
                                  }
                              ),
                            ),
                            SizedBox(width: 5.w,),
                            Expanded(
                              child: MetaButton(mapData: jsonData['walletButton'],
                                  onButtonPressed: (){
                                    if(jsonData['walletButton']["onClick"].isNotEmpty) {
                                      Navigator.of(appNavigatorKey.currentState!.context).pushNamed(jsonData['walletButton']["onClick"],arguments: {
                                        "selectable":false
                                      });
                                    }
                                  }
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 200.h,
                        child: BlocBuilder<TravelRequestBloc, TravelRequestState>(
                            bloc: bloc,
                            builder:(context, state) {
                              jsonData['listView']['recordsFound']['value'] = 0;
                              return Container(
                                  child: BlocMapToEvent(state: state.eventState, message: state.message,
                                      callback: (){
                                        jsonData['listView']['recordsFound']['value'] = state.response?.data?.length;
                                        if(state.response?.data== null)
                                          return;

                                      },
                                      topComponent: Container(
                                          margin: EdgeInsets.symmetric(vertical: 10.w),
                                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                                          child: MetaTextView(mapData: {
                                            "text" :"Upcoming Travel Requests",
                                            "color" : "0xFF2854A1",
                                            "size": "17",
                                            "family": "bold",
                                            "align" : "center-left"
                                          })
                                      ),
                                      child:Container(
                                        padding: EdgeInsets.only(bottom: 30.h),
                                          child: getListView(state))
                                  )
                              );
                            }
                        ),
                      )
                    ],


                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getListView(TravelRequestState state){

    List<trData.Data>? list = state.responseUp?.data ?? [];

    return  list.isNotEmpty ? ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount:list.length,
      itemBuilder: (BuildContext context, int index) {
        trData.Data item = list[index];

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

  List<Color> getColor(List items) {
    List<Color> colors=[];
    for(var color in items){
      colors.add(ParseDataType().getHexToColor(color));
    }
    return colors;
  }

}
