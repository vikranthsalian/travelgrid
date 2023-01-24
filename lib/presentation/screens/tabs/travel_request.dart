import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/presentation/components/clippers/app_bar_shape.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class TravelRequest extends StatefulWidget {
  @override
  _TravelRequestState createState() => _TravelRequestState();
}

class _TravelRequestState extends State<TravelRequest> {
  Map<String,dynamic> jsonData = {};
  List items=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.trData;
    prettyPrint(jsonData);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody for floating bar get better perfomance
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  FloatingActionButton(
        child:MetaIcon(mapData:jsonData['bottomButtonFab'],
              onButtonPressed: (){}),
        backgroundColor: ParseDataType().getHexToColor(jsonData['app_bar']['backgroundColor']),
        onPressed: () {  },),
      bottomNavigationBar:
      BottomAppBar(
        color:ParseDataType().getHexToColor(jsonData['app_bar']['backgroundColor']),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        elevation: 2.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MetaButton(mapData: jsonData['bottomButtonLeft'],
                onButtonPressed: (){

                }
            ),
            MetaButton(mapData: jsonData['bottomButtonRight'],
                onButtonPressed: (){

                }
            )
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 50.w,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading:jsonData['app_bar']['leading'] !=null ? true: false,
        leading: jsonData['app_bar']['leading'] !=null ?
        MetaIcon(mapData:jsonData['app_bar']['leading'],
            onButtonPressed: (){

        }):null ,
        centerTitle: jsonData['app_bar']['isCenter'] ?? false,
        // actions: [
        //   MetaIcon(mapData:jsonData['app_bar']['actions'][0],
        //       onButtonPressed: (){
        //
        //       })
        // ],
        toolbarHeight: 130.h,
        flexibleSpace: ClipPath(
          clipper: Customshape(),
          child: Container(
            height: 130.h,
            width: MediaQuery.of(context).size.width,
            color:ParseDataType().getHexToColor(jsonData['app_bar']['backgroundColor']),
            child: Center(child: MetaTextView(mapData: jsonData['app_bar']['title'])),
          ),
        ),
      ),
      body: Center(
        child:items.isNotEmpty ? getListView():
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MetaTextView(mapData: jsonData['listView']['emptyData']['title']),
            SizedBox(height: 10.h,),
            MetaButton(mapData: jsonData['listView']['emptyData']['bottomButtonRefresh'],
            onButtonPressed: (){

            })
          ],
        )
      ),
      //  bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget getListView(){
    return  ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return Container();
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container();
      },
      itemCount: 0,
    );
  }

}
