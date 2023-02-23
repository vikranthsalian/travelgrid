import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/data/cubits/fare_class_cubit/fare_class_cubit.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

import '../../../data/datasources/fare_class_list.dart';



class FareClassScreen extends StatelessWidget {
  Function? onTap;
  String? mode;
  FareClassScreen({this.onTap,this.mode});


  Map<String,dynamic> jsonData = {};


  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.fareClassData;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Column(children: [
            SizedBox(height: 20.h,),
            MetaTextView(mapData: jsonData['title']),
            Expanded(child: getListView()),
            Container(
              width: double.infinity,
              child: MetaButton(mapData: jsonData['bottomButtonCentre'],
                  onButtonPressed: (){
                  Navigator.pop(context);
                  }
              ),
            )
          ])
      ),
    );
  }


  Widget getListView(){
    print("mode");
    print(mode);
    List<Data> list = [];
    list = appNavigatorKey.currentState!.context.read<FareClassCubit>().getFareClassResponse(mode);

    return  list.isNotEmpty ? ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {

        Map item = {
          "text" :"",
          "color" : "0xFF000000",
          "size": "15",
          "family": "regular",
          "align" : "center-left"
        };

        return InkWell(
          onTap: () {
            Navigator.pop(context);
            onTap!(list[index].toMap());
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              height: 35.h,
              alignment: Alignment.centerLeft,
              child: MetaTextView(mapData: item,
                  text:((index+1).toString() + ". "+ list[index].label.toString()  ))
          ),
        );


      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(height: 3.h);
      },
      itemCount:list.length,
    ):  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MetaTextView(mapData: jsonData['listView']['emptyData']['title'])
      ]
    );
  }

}
