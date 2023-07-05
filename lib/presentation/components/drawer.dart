
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:travelgrid/common/constants/color_constants.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/PackageInfo.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/usecases/common_usecase.dart';
import 'package:travelgrid/presentation/components/dialog_yes_no.dart';
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
              height: 50.h,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                            "text" : fullname,
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
                  buildListTile(context,"Travel Request",Icons.card_travel,RouteConstants.travelRequestPath),
                  buildListTile(context,"Travel Expense",Icons.monetization_on_outlined,RouteConstants.travelExpensePath),
                  buildListTile(context,"General Expense",Icons.done_all,RouteConstants.generalExpensePath),
                  buildListTile(context,"Approvals",Icons.done_all,RouteConstants.approvalExpensePath),

                  Divider(),
                  buildListTile(context,"Policies",Icons.policy,RouteConstants.policyPath),
                  buildListTile(context,"Privacy Policy",Icons.privacy_tip_outlined,"https://www.narayanahealth.org/privacy-policy",isWeb: true),
                  buildListTile(context,"Terms and Conditions",Icons.sticky_note_2_sharp,"https://www.narayanahealth.org/terms-of-use",isWeb: true),


                  ListTile(
                    dense: false,
                    leading: Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          shape: BoxShape.circle),
                      child: Icon(Icons.picture_as_pdf,color: Colors.white,size: 15.sp,),
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
                      Navigator.of(context).pushNamed(RouteConstants.walletPath,arguments: {
                        "selectable":false
                      });
                    },
                  ),
                  Divider(),

                  ListTile(
                    dense: false,
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
                      child: MetaTextView(mapData: {
                        "text" : "Rate Us",
                        "color" : "0xFF000000",
                        "size": "14",
                        "family": "bold",
                        "align": "center-left"
                      }),
                    ),
                    trailing:  Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.8),),
                    onTap: () async{
                       launchUrl(Uri.parse(FlavourConstants.appAndroidUrl),mode: LaunchMode.externalApplication);
                    },
                  ),
                  // ListTile(
                  //   leading: Container(
                  //     height: 30.w,
                  //     width: 30.w,
                  //     decoration: BoxDecoration(
                  //         color: Colors.black.withOpacity(0.8),
                  //         shape: BoxShape.circle),
                  //     child: Icon(Icons.share_outlined,color: Colors.white,size: 15.sp,),
                  //   ),
                  //   title: Transform.translate(
                  //     offset: Offset(-10.w, 0),
                  //     child:  Text(
                  //       'Share App',
                  //       style: TextStyle(
                  //         fontSize: 16.sp,
                  //         color:Colors.black.withOpacity(0.8),
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  //   trailing:  Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.8),),
                  //   onTap: () {
                  //     ShareUtils.onShareMsg(FlavourConstants.shareMsg+FlavourConstants.appAndroidUrl);
                  //   },
                  // ),
                  Divider(),
                  ListTile(
                    dense: false,
                    leading: Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          shape: BoxShape.circle),
                      child: Icon(Icons.power_settings_new_sharp,color: Colors.white,size: 15.sp,),
                    ),
                    title: Transform.translate(
                      offset: Offset(-10.w, 0),
                      child: MetaTextView(mapData: {
                        "text" : "Log Out",
                        "color" : "0xFF000000",
                        "size": "14",
                        "family": "bold",
                        "align": "center-left"
                      }),
                    ),
                    trailing:  Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.8),),
                    onTap: () async{
                      await showDialog(
                          context: context,
                          builder: (_) => DialogYesNo(
                              title: "Do you want to logout?",
                              onPressed: (value)async{
                                if(value == "YES"){
                                  SuccessModel model =   await Injector.resolve<CommonUseCase>().logOut();
                                  if(model.token == null){
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(RouteConstants.splashPath,
                                            (Route<dynamic> route) => false);
                                  }

                                }
                              }));
                    },
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }

  ListTile buildListTile(BuildContext context,text,icon,path,{bool isWeb=false}) {
    return ListTile(
                  dense: false,
                  leading: Container(
                    height: 30.w,
                    width: 30.w,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        shape: BoxShape.circle),
                    child: Icon(icon,color: Colors.white,size: 15.sp,),
                  ),
                  title: Transform.translate(
                    offset: Offset(-10.w, 0),
                    child: MetaTextView(mapData: {
                      "text" : text,
                      "color" : "0xFF000000",
                      "size": "14",
                      "family": "bold",
                      "align": "center-left"
                    }),
                  ),
                  trailing:  Icon(Icons.chevron_right,color: Colors.black.withOpacity(0.8),),
                  onTap: () async{

                    if(isWeb){
                      final Uri url = Uri.parse(path);
                      if (!await launchUrl(url)) {
                    throw Exception('Could not launch $path');
                    }
                    }else{
                      Navigator.of(context).pushNamed(path);
                    }


                  },
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