import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class MetaDialogSelectorView extends StatelessWidget {
  Map mapData;
  String? text;
  MetaDialogSelectorView({super.key, required this.mapData,this.text});

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
        child: Column(
        children: [
          MetaTextView(mapData: mapData['label']),
          InkWell(
            onTap: (){

            },
              child: MetaTextView(mapData: mapData['dataText'])),
        ],
        )
    );
  }

}

