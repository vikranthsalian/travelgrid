import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  Map<String,dynamic> splashData = {};
  Map<String,dynamic> splashBottomText = {};

  @override
  void initState() {

    splashData = FlavourConstants.splashData;
    prettyPrint(splashData);
    splashBottomText = FlavourConstants.splashData['splash_bottom_text'];

    getInitRoute();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ParseDataType().getHexToColor(splashData['splash_bg_color']),
      body:Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(FlavourConstants.path + splashData['splash_logo'],width: 250,height: 250,),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                  splashBottomText['text'],
                  style:Theme.of(context).textTheme.
                      caption?.copyWith(
                                fontSize: ParseDataType().getDouble(splashBottomText['size']).sp,
                                color: ParseDataType().getHexToColor(splashBottomText['color']) ,
                                fontFamily: splashBottomText['family'])
              )
          )
        ],
      ),
    );
  }

  void getInitRoute() {
      // if(PreferenceConfig.containsKey(PreferenceConstants.sessionID)) {
      //   Timer(const Duration(seconds: 3),(){
      //     Navigator.of(context).pushNamed(RouteConstants.dashBoardTabsPath, arguments: { "tab" : 0 });
      //   });
      // }else{
        Timer( Duration(seconds: 3),(){
          Navigator.of(context).pushNamed(RouteConstants.loginPath);
        });
      // }
  }

}