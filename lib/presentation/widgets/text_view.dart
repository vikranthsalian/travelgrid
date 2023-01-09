import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';

class MetaTextView extends StatelessWidget {
  Map mapData;
  MetaTextView({super.key, required this.mapData});

  @override
  Widget build(BuildContext context) {
    return  Container(
        alignment: ParseDataType().getAlign(mapData['align'] ?? ""),
        child: Text(
            mapData['text'],
            style:Theme.of(context).textTheme.
            caption?.copyWith(
                fontSize: ParseDataType().getDouble(mapData['size']).sp,
                color: ParseDataType().getHexToColor(mapData['color']) ,
                fontFamily: mapData['family'])
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
