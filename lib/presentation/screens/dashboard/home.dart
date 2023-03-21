import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/usecases/common_usecase.dart';
import 'package:travelgrid/presentation/components/dialog_yes_no.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String,dynamic> jsonData = {};
  List items=[];
  String?  dateText;
  String  fullname="";
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


  @override
  Widget build(BuildContext context) {

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
                              leading: Container(
                                  height: 50.w,
                                  width: 50.w,
                                  child: MetaSVGView(mapData:  jsonData['svgIcon']),
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
                              onTap: (){

                                if(e["onClick"].isNotEmpty){
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

                                  }
                              ),
                            )
                          ],
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

  List<Color> getColor(List items) {
    List<Color> colors=[];
    for(var color in items){
      colors.add(ParseDataType().getHexToColor(color));
    }
    return colors;
  }

}
