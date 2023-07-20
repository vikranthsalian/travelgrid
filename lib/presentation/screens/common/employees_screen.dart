import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/data/blocs/employee/employee_bloc.dart';
import 'package:travelgrid/data/cubits/employee_cubit/employee_cubit.dart';
import 'package:travelgrid/data/cubits/login_cubit/login_cubit.dart';
import 'package:travelgrid/data/datasources/login_response.dart' as user;
import 'package:travelgrid/presentation/components/search_bar_component.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
import 'package:travelgrid/data/datasources/others/employee_list.dart';

class EmployeeScreen extends StatefulWidget {
  Function(Data)? onTap;
  EmployeeScreen({this.onTap});

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  Map<String,dynamic> jsonData = {};
  List<Data> dataList = [];
  bool enableSearch = false;
  final TextEditingController _searchController = TextEditingController();
  bool loaded=false;
  EmployeeBloc? bloc;

  List<Data> list = [];
  @override
  void initState() {
    super.initState();
    jsonData = FlavourConstants.employeeData;
    list = appNavigatorKey.currentState!.context.read<EmployeeCubit>().getEmployeeResponse();

    list.removeWhere((item) => item.fullName!.contains('admin'));
    user.MetaLoginResponse loginResponse = context.read<LoginCubit>().getLoginResponse();
    String code= loginResponse.data!.employeecode!;
    list.removeWhere((item) => item.employeecode== code);

    dataList=list;

  }


  @override
  Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: ParseDataType().getHexToColor(
            jsonData['backgroundColor']),
        body: Column(
          children: [
            SizedBox(height: 40.h),
            Container(
              height: 40.h,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MetaIcon(mapData: jsonData['backBar'],
                      onButtonPressed: () {
                        Navigator.pop(context);
                      }),
                  Container(
                    child: MetaTextView(mapData: jsonData['title']),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.symmetric(vertical: 5.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Color(0xFFFFFFFF),
                  border: Border.all(color: Colors.black12)),
              child: SearchBarComponent(
                barHeight: 40.h,
                hintText: "Search.....",
                searchController: _searchController,
                onClear: () {

                },
                onSubmitted: (text) {

                },
                onChange: (text) {
                  search(text);
                },
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: MetaTextView(mapData: jsonData['listView']['recordsFound'],
                  text: list.length.toString() + " Records Found"),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Container(
                  color: Colors.white,
                  child: list.isNotEmpty ? ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      Map city = {
                        "text": "",
                        "color": "0xFF000000",
                        "size": "15",
                        "family": "bold",
                        "align": "center-left"
                      };

                      Map state = {
                        "text": "",
                        "color": "0xFFAEAEAE",
                        "size": "12",
                        "family": "bold",
                        "align": "center-left"
                      };

                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ListTile(
                          leading: Container(
                              height: 30.w,
                              width: 30.w,
                              child: MetaSVGView(
                                  mapData: jsonData['listView']['svgIcon'])
                          ),
                          title: Container(
                              child: MetaTextView(mapData: city,
                                  text: list[index].fullName.toString())
                          ),
                          subtitle: Container(
                              margin: EdgeInsets.only(right: 5.w),
                              child: MetaTextView(
                                  mapData: state, text: list[index].employeecode)
                          ),
                          onTap: () {
                            widget.onTap!(list[index]);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(height: 3.h);
                    },
                    itemCount: list.length,
                  ) : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MetaTextView(
                          mapData: jsonData['listView']['emptyData']['title']),
                      SizedBox(height: 10.h,),
                      MetaButton(
                          mapData: jsonData['listView']['emptyData']['bottomButtonRefresh'],
                          onButtonPressed: () {

                          })
                    ],
                  )),
            )
          ],
        ),
      );

  }

  void search(String key) {
    List<Data> newList=[];
    for(var item in dataList){
      print(jsonEncode(item));
      if (item.fullName!.toLowerCase().contains(key.toLowerCase()) ||
          item.employeecode!.toLowerCase().contains(key.toLowerCase())) {
        newList.add(item);
      }
    }
    setState(() {
      list=newList;
    });
  }

}
