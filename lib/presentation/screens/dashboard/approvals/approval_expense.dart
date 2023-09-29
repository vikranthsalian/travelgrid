import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelex/common/constants/flavour_constants.dart';
import 'package:travelex/common/extensions/parse_data_type.dart';
import 'package:travelex/data/blocs/approval_expense/ae_bloc.dart';
import 'package:travelex/presentation/screens/dashboard/approvals/ge.dart';
import 'package:travelex/presentation/screens/dashboard/approvals/te.dart';
import 'package:travelex/presentation/screens/dashboard/approvals/tr.dart';
import 'package:travelex/presentation/widgets/icon.dart';
import 'package:travelex/presentation/widgets/text_view.dart';

class ApprovalExpense extends StatefulWidget {
  @override
  _ApprovalExpenseState createState() => _ApprovalExpenseState();
}

class _ApprovalExpenseState extends State<ApprovalExpense> {
  Map<String,dynamic> jsonData = {};
  List tabs=[];
  bool loaded=false;
  ApprovalExpenseBloc? bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.aeData;
    tabs = jsonData['tabs'];
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
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
                    child: TabBar(
                      indicatorColor: Colors.white,
                      tabs: tabs.map((e) {
                      return Tab(text: e['text']);
                    }).toList())
                  ),
                  SizedBox(height:5.h),

                ],
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),

                    children: tabs.map((e) {


                      if(e['type'].toString()=="TR"){
                        return ApprovalTR(data: e['view']);
                      }

                      if(e['type'].toString()=="TE"){
                        return ApprovalTE(data: e['view']);
                      }

                      if(e['type'].toString()=="GE"){
                        return ApprovalGE(data: e['view']);
                      }

                      return Container();

                    }).toList()
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
