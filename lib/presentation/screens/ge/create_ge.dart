import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/data/blocs/general_expense/ge_bloc.dart';
import 'package:travelgrid/data/datsources/general_expense_list.dart';
import 'package:travelgrid/presentation/components/bloc_map_event.dart';
import 'package:travelgrid/presentation/components/clippers/app_bar_shape.dart';
import 'package:travelgrid/presentation/components/search_bar_component.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class CreateGeneralExpense extends StatefulWidget {
  @override
  _CreateGeneralExpenseState createState() => _CreateGeneralExpenseState();
}

class _CreateGeneralExpenseState extends State<CreateGeneralExpense> {
  Map<String,dynamic> jsonData = {};
  List details=[];
  double cardHt = 90.h;
  bool enableSearch = false;
  final TextEditingController _searchController = TextEditingController();
  bool loaded=false;
  GeneralExpenseBloc? bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.geCreateData;
    prettyPrint(jsonData);

     details = jsonData['requesterDetails']['data'];

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        elevation: 2.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MetaButton(mapData: jsonData['bottomButtonSort'],
                onButtonPressed: (){

                }
            ),
            MetaButton(mapData: jsonData['bottomButtonFilter'],
                onButtonPressed: (){

                }
            )
          ],
        ),
      ),
      body: Container(
        color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
        height: 270.h,
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: MetaTextView(mapData: jsonData['requesterTitle'])),
            SizedBox(height:10.h),
            Container(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: details.length,
                shrinkWrap: true,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio: 3,mainAxisSpacing: 3.h),
                itemBuilder: (BuildContext context, int index) {

                    jsonData['requesterDetails']['style']['text'] = details[index];
                    Map newData = jsonData['requesterDetails']['style'];

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                   MetaTextView(mapData: newData,key: UniqueKey(),),
                                   MetaTextView(mapData: newData,key: UniqueKey(),)
                                 ])
                           );
                    },
              )
            )
          ],
        ),
      ),
    );
  }


}
