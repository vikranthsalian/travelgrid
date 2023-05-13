import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelgrid/common/constants/asset_constants.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/login_response.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';


class ProfileScreen extends StatelessWidget {
  Map<String,dynamic> jsonData = {};
  List items=[];
  String fullname="";

  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.profileData;

    MetaLoginResponse  loginResponse = context.read<LoginCubit>().getLoginResponse();
    fullname=loginResponse.data!.fullName??"";

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
              height: 250.h,
              child:  Column(
                children: [
                  SizedBox(height:30.h),
                  Container(
                    height: 40.h,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MetaIcon(mapData:jsonData['backBar'],
                            onButtonPressed: (){
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),

                  Container(
                    height: 100.w,
                    width: 100.w,
                    child: MetaSVGView(mapData:  jsonData['svgIcon']),
                  ),
                  SizedBox(height: 10.h,),
                  Container(
                    child:MetaTextView(mapData: jsonData['name'],text: fullname),
                  ),
                  Container(
                    child: Row(

                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                child:MetaTextView(mapData: jsonData['title'],text: "User ID"),
                              ),
                              Container(
                                child:MetaTextView(mapData: jsonData['subtitle'],text: fullname),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                child:MetaTextView(mapData: jsonData['title'],text: "Email"),
                              ),
                              Container(
                                child:MetaTextView(mapData: jsonData['subtitle'],text: fullname),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                child:MetaTextView(mapData: jsonData['title'],text: "Gender"),
                              ),
                              Container(
                                child:MetaTextView(mapData: jsonData['subtitle'],text: fullname),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height:10.h),

          ],
        )
    );
  }


}
