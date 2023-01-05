import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

 //  getInitRoute();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration:  BoxDecoration(
                gradient:  LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    stops: const [0.0, 1.0],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    tileMode: TileMode.repeated
                )
            ),
            child: Image.asset(FlavourConstants.splashLogo,width: 250,height: 250,),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(FlavourConstants.poweredBy,style:Theme.of(context).textTheme.caption))
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
        Timer(const Duration(seconds: 3),(){
          Navigator.of(context).pushNamed(RouteConstants.splashPath);
        });
      // }
  }

}