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
import 'package:travelgrid/presentation/components/expandable_component.dart';
import 'package:travelgrid/presentation/components/switch_component.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:tuple/tuple.dart';


class ProfileScreen extends StatelessWidget {
  Map<String,dynamic> jsonData = {};
  List items=[];
  String fullname="";
  List<Tuple2<String,String>> details=[];
  List<Tuple2<String,String>> orgDetails=[];
  bool showContactDetails=true;
  bool showOrgDetails=true;
  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.profileData;

    MetaLoginResponse  loginResponse = context.read<LoginCubit>().getLoginResponse();
    fullname=loginResponse.data!.fullName??"";


    details.add(Tuple2("User ID", loginResponse.data!.id.toString()));

    details.add(Tuple2("Gender", loginResponse.data!.gender.toString()));

    details.add(Tuple2("Address", loginResponse.data!.currentContact!.addressLine1.toString()));

    details.add(Tuple2("City", loginResponse.data!.currentContact!.location!.city.toString()));
    details.add(Tuple2("State", loginResponse.data!.currentContact!.location!.stateprov.toString()));
    details.add(Tuple2("ZipCode", loginResponse.data!.currentContact!.location!.postalCode.toString()));
    details.add(Tuple2("Country", loginResponse.data!.currentContact!.location!.countryName.toString()));
    details.add(Tuple2("Mobile", loginResponse.data!.currentContact!.mobile.toString()));

    orgDetails.add(Tuple2("Email", loginResponse.data!.currentContact!.email.toString()));
    orgDetails.add(Tuple2("Employee", loginResponse.data!.currentContact!.mobile.toString()));
    orgDetails.add(Tuple2("Grade", loginResponse.data!.grade!.companyId!.enterprise!.name.toString()));
    orgDetails.add(Tuple2("Division", loginResponse.data!.divName.toString()));




    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
              height: 220.h,
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
                ],
              ),
            ),
            SizedBox(height:10.h),
            ExpandableComponent(
                color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                jsonData: jsonData['contactDetails'],
                childWidget: buildRequesterWidget(jsonData['contactDetails'],details),
                initialValue: showContactDetails),
            ExpandableComponent(
                color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                jsonData: jsonData['orgDetails'],
                childWidget: buildRequesterWidget(jsonData['orgDetails'],orgDetails),
                initialValue: showOrgDetails),
          ],
        )
    );
  }




  Container buildRequesterWidget(Map map,List<Tuple2<String,String>> data){
    return Container(
        color: Colors.white,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          itemCount: data.length,
          shrinkWrap: true,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:2,
              childAspectRatio: 7,
              mainAxisSpacing: 3.h
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MetaTextView(
                        mapData: map['gridLabel'],text:data[index].item1,
                        key: UniqueKey()
                      ),
                      MetaTextView(mapData: map['gridValue'],text:data[index].item2,
                        key: UniqueKey())
                    ])
            );
          },
        )
    );
  }


}
