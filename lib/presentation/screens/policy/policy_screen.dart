import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelgrid/common/constants/asset_constants.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/presentation/components/clippers/app_bar_shape.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
class PolicyHome extends StatefulWidget {
  @override
  _PolicyHomeState createState() => _PolicyHomeState();
}

class _PolicyHomeState extends State<PolicyHome> {
  Map<String,dynamic> jsonData = {};
  List items=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.policyData;
    prettyPrint(jsonData);
    items = jsonData['listView']['data'];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
            height: 120.h,
            child:  Column(
              children: [
                SizedBox(height:40.h),
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
                      Container(
                        child:MetaTextView(mapData: jsonData['title']),
                      ),
                    ],
                  ),
                ),
                SizedBox(height:10.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child:MetaTextView(mapData: jsonData['listView']['recordsFound']),
                ),
                SizedBox(height:10.h),
              ],
            ),
          ),
          SizedBox(height:10.h),
          getListView()
        ],
      )
    );
  }

  Widget getListView(){
    double cardHt=90.h;
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: items.length,
      shrinkWrap: true,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,mainAxisSpacing: 3.h),
      itemBuilder: (BuildContext context, int index) {

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Card(
            color: Color(0xFF2854A1),
            elevation: 5,
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: cardHt * 0.2,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AssetConstants.pdfSvg,
                              color: ParseDataType().getHexToColor(jsonData['listView']['svgIconColor']),
                              width: 50.w,
                              height: 50.w,
                            ),
                            SizedBox(height:10.h),
                            Container(
                              child: MetaTextView(mapData: items[index]['title']),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(RouteConstants.pdfPath, arguments:items[index]['path']);
                      },
                      child: Container(
                        height: cardHt * 0.47,
                        child: MetaTextView( mapData:  items[index]['subtitle']),
                      ),
                    ),
                  ]),
            ),
          ),
        );
      },
    );

  }

}
