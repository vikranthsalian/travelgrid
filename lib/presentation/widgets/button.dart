import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class MetaGradButton extends StatelessWidget {
  MetaGradButton({super.key,  required this.buttonText, required this.onButtonPressed });
  final String buttonText;
  VoidCallback onButtonPressed;


  @override
  Widget build(BuildContext context) {
     return Container(
       height: 50.h,
       width:1.sw,
       padding: EdgeInsets.zero,
       decoration: BoxDecoration(
         gradient: LinearGradient(
           colors: [
             Theme.of(context).colorScheme.primary,
             Theme.of(context).colorScheme.secondary,
           ],
           begin: Alignment.centerLeft,
           end: Alignment.centerRight,
         ),
       ),
       child: Align(
         alignment: Alignment.center,
         child: Text(
             buttonText,
             textAlign: TextAlign.center,
             style:Theme.of(context).textTheme.button!),
       ),
     );
  }

}

class MetaButton extends StatelessWidget {

  Function() onButtonPressed;
  Map mapData;
  String? text;

  MetaButton({super.key,
    required this.onButtonPressed ,
    required this.mapData,
     this.text,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onButtonPressed();
      },
      child: Container(
        height:  mapData['height']!=null ? mapData['height'] : 50.h,
        width:100.w,
        decoration: BoxDecoration(
            color: ParseDataType().getHexToColor(mapData['backgroundColor']),
            borderRadius: BorderRadius.all(Radius.circular(
                mapData['borderRadius']!=null ? (mapData['borderRadius']) as double : 0))
        ),
        padding: EdgeInsets.zero,
        child: Align(
          alignment: Alignment.center,
          child: Text(
              text==null ? mapData['text']: text,
              textAlign: TextAlign.center,
              style:MetaStyle(mapData: mapData).getStyle()),
        ),
      ),
    );
  }

}