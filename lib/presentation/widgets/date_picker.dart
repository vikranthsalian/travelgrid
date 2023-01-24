import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class MetaDateView extends StatelessWidget {
  Map mapData;
  String? text;
  MetaDateView({super.key, required this.mapData,this.text});

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Column(
          children: [
            MetaTextView(mapData: mapData),
            InkWell(
              onTap: (){

              },
              child: Row(
                children: [
                  MetaDateView(mapData: mapData),
                  Column(
                    children: [
                      MetaDateView(mapData: mapData),
                      MetaDateView(mapData: mapData),
                    ],
                  )
                ],
              ),
            )
          ],
        )
    );
  }

}

class MetaStyle extends TextStyle {
  Map mapData;
  MetaStyle({required this.mapData});

  TextStyle getStyle(){
    return TextStyle(
        fontSize: ParseDataType().getDouble(mapData['size']).sp,
        color: ParseDataType().getHexToColor(mapData['color']) ,
        fontFamily: mapData['family']);
  }

}
