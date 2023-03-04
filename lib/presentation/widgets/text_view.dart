import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';

class MetaTextView extends StatelessWidget {
  Map mapData;
  String? text;
  TextAlign? textAlign;
  MetaTextView({super.key, required this.mapData,this.text,this.textAlign=TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return  Container(
        alignment: ParseDataType().getAlign(mapData['align'] ?? ""),
        child: Text(
            text==null ?
            mapData['value']!=null ? (mapData['value'].toString() +" "+ mapData['text'].toString()) :mapData['text'] :text,
            textAlign: textAlign,
            style:Theme.of(context).textTheme.
            bodySmall?.copyWith(
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
