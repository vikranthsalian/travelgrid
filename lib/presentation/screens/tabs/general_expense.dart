import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/presentation/components/clippers/app_bar_shape.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GeneralExpense extends StatefulWidget {
  @override
  _GeneralExpenseState createState() => _GeneralExpenseState();
}

class _GeneralExpenseState extends State<GeneralExpense> {
  Map<String,dynamic> geJsonData = {};
  List items=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    geJsonData = FlavourConstants.geData;
    prettyPrint(geJsonData);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody for floating bar get better perfomance
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  FloatingActionButton(
        child:MetaIcon(mapData:geJsonData['bottomButtonFab'],
            onButtonPressed: (){}),
        backgroundColor: ParseDataType().getHexToColor(geJsonData['app_bar']['backgroundColor']),
        onPressed: () {  },),
      bottomNavigationBar:
      BottomAppBar(
        color:ParseDataType().getHexToColor(geJsonData['app_bar']['backgroundColor']),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        elevation: 2.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MetaButton(mapData: geJsonData['bottomButtonSort'],
                onButtonPressed: (){

                }
            ),
            MetaButton(mapData: geJsonData['bottomButtonFilter'],
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
        automaticallyImplyLeading:geJsonData['app_bar']['leading'] !=null ? true: false,
        leading: geJsonData['app_bar']['leading'] !=null ?
        MetaIcon(mapData:geJsonData['app_bar']['leading'],
            onButtonPressed: (){

        }):null ,
        centerTitle: geJsonData['app_bar']['isCenter'] ?? false,
        // actions: [
        //   MetaIcon(mapData:geJsonData['app_bar']['actions'][0],
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
            color:ParseDataType().getHexToColor(geJsonData['app_bar']['backgroundColor']),
            child: Center(child: MetaTextView(mapData: geJsonData['app_bar']['title'])),
          ),
        ),
      ),
      body: Center(
        child:items.isNotEmpty ? getListView():
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MetaTextView(mapData: geJsonData['listView']['emptyData']['title']),
            SizedBox(height: 10.h,),
            MetaButton(mapData: geJsonData['listView']['emptyData']['bottomButtonRefresh'],
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
