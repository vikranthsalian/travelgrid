import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class MetaDateTimeView extends StatelessWidget {
  Map mapData;
  String? text;
  MetaDateTimeView({super.key, required this.mapData,this.text});

  @override
  Widget build(BuildContext context) {

    if(mapData['showView'] == "date"){
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 5.h),
          child: dateView()
      );
    }else if(mapData['showView'] == "time"){
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 5.h),
          child: timeView()
      );
    }else{
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 5.h),
          child: dateTimeView()
      );
    }
  }


  Widget dateView(){
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: MetaTextView(mapData: mapData['dateView']['label'])),
            InkWell(
              onTap: (){

              },
              child: Row(
                children: [
                  MetaTextView(mapData: mapData['dateView']['dateText']),
                  SizedBox(width: 5.w,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MetaTextView(mapData: mapData['dateView']['monthYearText']),
                        MetaTextView(mapData: mapData['dateView']['weekText']),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );
  }

  Widget timeView(){
    return Container(
        child: Column(
          children: [
            MetaTextView(mapData: mapData['timeView']['label']),
            MetaTextView(mapData: mapData['timeView']['timeText']),
          ],
        )
    );
  }


  Widget dateTimeView(){
    return Container(
        child: Row(
          children: [
            Expanded(child: dateView()),
            Expanded(child: timeView()),
          ],
        )
    );
  }

}
