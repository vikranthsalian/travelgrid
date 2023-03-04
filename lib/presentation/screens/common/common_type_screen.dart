import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';



class CommonTypeScreen extends StatelessWidget {
  Function? onTap;
  Map mapData;
  CommonTypeScreen({this.onTap,required this.mapData});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Column(children: [
            SizedBox(height: 20.h,),
            MetaTextView(mapData: mapData['title']),
            Expanded(child: getListView()),
            Container(
              width: double.infinity,
              child: MetaButton(mapData: mapData['bottomButtonCentre'],
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
    List list = [];
    list = mapData['listView']['data'];

    return  list.isNotEmpty ? ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {

        return InkWell(
          onTap: () {
            Navigator.pop(context);
            onTap!(list[index]);
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              height: 35.h,
              alignment: Alignment.centerLeft,
              child: MetaTextView(mapData: list[index],
                  text:((index+1).toString() + ". "+ list[index]['text']  ))
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
        MetaTextView(mapData: mapData['listView']['emptyData']['title'])
      ]
    );
  }

}
