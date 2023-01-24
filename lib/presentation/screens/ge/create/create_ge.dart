import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/constants/asset_constants.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/date_time_util.dart';
import 'package:travelgrid/data/blocs/general_expense/ge_bloc.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datsources/general_expense_list.dart';
import 'package:travelgrid/data/datsources/login_response.dart';
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
  List expenseTypes=[];
  double cardHt = 90.h;
  bool enableSearch = false;
  final TextEditingController _searchController = TextEditingController();
  bool loaded=false;
  GeneralExpenseBloc? bloc;
  bool isSwitched = false;
  List<String> values=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonData = FlavourConstants.geCreateData;
   // prettyPrint(jsonData);

     details = jsonData['requesterDetails']['data'];
      expenseTypes = jsonData['expensesTypes'];

    MetaLoginResponse loginResponse = context.read<LoginCubit>().getLoginResponse();
    values.add(loginResponse.data!.fullName ?? "");
    values.add(loginResponse.data!.grade!.organizationGradeName ?? "");
    values.add(loginResponse.data!.gender ?? "");
    values.add(loginResponse.data!.employeecode ?? "");
    values.add(loginResponse.data!.divName ?? "");
    values.add(loginResponse.data!.deptName ?? "");
    values.add(loginResponse.data!.costCenter!.costcenterName ?? "");
    values.add(loginResponse.data!.worklocation!.locationName ?? "");
    values.add(loginResponse.data!.currentContact!.mobile ?? "");
    values.add(loginResponse.data!.permanentContact?? "");

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
      body: Container(
        color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
        height: 450.h,
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
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: MetaTextView(mapData: jsonData['requesterTitle'])),
                  Switch(
                    activeColor: Colors.green,
                    value: isSwitched,
                    onChanged:(bool? value) {
                      setState(() {
                        isSwitched=value!;
                      });
                    },
                  ),
                    ],
              ),
            ),
            SizedBox(height:5.h),
            Container(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: details.length,
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
                                   MetaTextView(mapData: jsonData['requesterDetails']['label'],text:details[index],
                                     key: UniqueKey(),),
                                   MetaTextView(mapData: jsonData['requesterDetails']['value'],text:values[index],
                                     key: UniqueKey(),)
                                 ])
                           );
                    },
              )
            ),
            Container(
              color: Colors.white,
              height:80,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  children: expenseTypes.map((e) {
                    print(e);

                    return Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(e['onClick']);
                          },
                          child: Container(
                          child: Card(
                          color: Color(0xFF2854A1),
                          elevation: 5,
                          child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 5.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 5.h),
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          AssetConstants.pdfSvg,//e['svgIcon']['color']
                                          color: ParseDataType().getHexToColor(e['svgIcon']['color']),
                                          width: 25.w,
                                          height: 25.w,
                                        ),
                                        SizedBox(height:5.h),
                                        Container(
                                          alignment: Alignment.center,
                                          child: MetaTextView(mapData: e['title']),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                       child: MetaTextView(mapData: {
                                         "text" : "+ ADD",
                                         "color" : "0xFFFFFFFF",
                                         "size": "8",
                                         "family": "bold",
                                         "align": "center"
                                       })
                                    ),
                                  ),
                                ]),
                          ),
                      ),
                    ),
                        ));

                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
