
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:travelgrid/common/constants/color_constants.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/utils/PackageInfo.dart';
import 'package:travelgrid/common/utils/ShareUtility.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetDrawer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => WidgetDrawerState();
}


class WidgetDrawerState extends State<WidgetDrawer> {
  String appVersion="";
  String fullname="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MetaLoginResponse  loginResponse = context.read<LoginCubit>().getLoginResponse();
    fullname=loginResponse.data!.fullName??"";
    getAppVersion();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width:  MediaQuery.of(context).size.width*0.8,
      child: Drawer(
        elevation: 0,
        child:  Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: Container(
              color: ColorConstants.primaryColor,
              alignment: Alignment.bottomCenter,
              height: 45.h,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Column(
                  children: [
                    Text(
                      appVersion,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color:Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding:EdgeInsets.fromLTRB(0, 5.h, 0, 0),
                      child:  Text(
                        "Copyright © Channel Mentor Pvt Ltd.",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color:Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Container(

              child: ListView(
                children: <Widget>[
                  Container(
                      height: 80.h,
                      color: ColorConstants.primaryColor,
                      child:  ListTile(
                        leading: Container(
                          height: 50.w,
                          width: 50.w,
                          child: MetaSVGView(mapData: {
                            "icon": "profile.svg"
                          }),
                        ),
                        title: Transform.translate(
                          offset: Offset(-10.w, 0),
                          child: MetaTextView(mapData: {
                            "text" : fullname ?? "",
                            "color" : "0xFFFFFFFF",
                            "size": "18",
                            "family": "bold",
                            "align": "center-left"
                          }),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, RouteConstants.profilePath);
                        },
                      )),
                  Divider(),
                  ListTile(
                    leading: Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          shape: BoxShape.circle),
                      child: Icon(Icons.insert_emoticon,color: Colors.white,size: 15.sp,),
                    ),
                    title: Transform.translate(
                      offset: Offset(-10.w, 0),
                      child: MetaTextView(mapData: {
                        "text" : "My Travel Request",
                        "color" : "0xFF000000",
                        "size": "14",
                        "family": "bold",
                        "align": "center-left"
                      }),
                    ),
                    trailing:  Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.8),),
                    onTap: () {
                      Navigator.pushNamed(context, "/about");
                    },
                  ),
                  ListTile(
                    leading: Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          shape: BoxShape.circle),
                      child: Icon(Icons.insert_emoticon,color: Colors.white,size: 15.sp,),
                    ),
                    title: Transform.translate(
                      offset: Offset(-10.w, 0),
                      child: MetaTextView(mapData: {
                        "text" : "My Travel Expense",
                        "color" : "0xFF000000",
                        "size": "14",
                        "family": "bold",
                        "align": "center-left"
                      }),
                    ),
                    trailing:  Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.8),),
                    onTap: () {
                      Navigator.pushNamed(context, "/about");
                    },
                  ),
                  ListTile(
                    leading: Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          shape: BoxShape.circle),
                      child: Icon(Icons.insert_emoticon,color: Colors.white,size: 15.sp,),
                    ),
                    title: Transform.translate(
                      offset: Offset(-10.w, 0),
                      child: MetaTextView(mapData: {
                        "text" : "My General Expense",
                        "color" : "0xFF000000",
                        "size": "14",
                        "family": "bold",
                        "align": "center-left"
                      }),
                    ),
                    trailing:  Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.8),),
                    onTap: () {
                      Navigator.pushNamed(context, "/about");
                    },
                  ),
                  ListTile(
                    leading: Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          shape: BoxShape.circle),
                      child: Icon(Icons.insert_emoticon,color: Colors.white,size: 15.sp,),
                    ),
                    title: Transform.translate(
                      offset: Offset(-10.w, 0),
                      child: MetaTextView(mapData: {
                        "text" : "My Approvals",
                        "color" : "0xFF000000",
                        "size": "14",
                        "family": "bold",
                        "align": "center-left"
                      }),
                    ),
                    trailing:  Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.8),),
                    onTap: () {
                      Navigator.pushNamed(context, "/about");
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          shape: BoxShape.circle),
                      child: Icon(Icons.insert_emoticon,color: Colors.white,size: 15.sp,),
                    ),
                    title: Transform.translate(
                      offset: Offset(-10.w, 0),
                      child: MetaTextView(mapData: {
                        "text" : "Policies",
                        "color" : "0xFF000000",
                        "size": "14",
                        "family": "bold",
                        "align": "center-left"
                      }),
                    ),
                    trailing:  Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.8),),
                    onTap: () {
                      Navigator.pushNamed(context, "/about");
                    },
                  ),
                  ListTile(
                    leading: Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          shape: BoxShape.circle),
                      child: Icon(Icons.insert_emoticon,color: Colors.white,size: 15.sp,),
                    ),
                    title: Transform.translate(
                      offset: Offset(-10.w, 0),
                      child: MetaTextView(mapData: {
                        "text" : "Documents",
                        "color" : "0xFF000000",
                        "size": "14",
                        "family": "bold",
                        "align": "center-left"
                      }),
                    ),
                    trailing:  Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.8),),
                    onTap: () {
                      Navigator.pushNamed(context, "/about");
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          shape: BoxShape.circle),
                      child: Icon(Icons.star_rate_outlined,color: Colors.white,size: 15.sp,),
                    ),
                    title: Transform.translate(
                      offset: Offset(-10.w, 0),
                      child:  Text(
                        'Rate Us',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color:Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    trailing:  Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.8),),
                    onTap: () async{
                      await canLaunchUrl(Uri.parse(FlavourConstants.appAndroidUrl));
                    },
                  ),
                  ListTile(
                    leading: Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          shape: BoxShape.circle),
                      child: Icon(Icons.share_outlined,color: Colors.white,size: 15.sp,),
                    ),
                    title: Transform.translate(
                      offset: Offset(-10.w, 0),
                      child:  Text(
                        'Share App',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color:Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    trailing:  Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.8),),
                    onTap: () {
                      ShareUtils.onShareMsg(FlavourConstants.shareMsg+FlavourConstants.appAndroidUrl);
                    },
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }

  getAppVersion() async{
    PackageUtils.getPackageDetails().then((PackageInfo value) {
      setState(() {
        print("APP VERSION : $value");
        appVersion="App Version : ${value.version}";
      });
    });
  }
}