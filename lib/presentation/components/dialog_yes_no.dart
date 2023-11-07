import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelex/common/constants/flavour_constants.dart';
import 'package:travelex/presentation/widgets/button.dart';
import 'package:travelex/presentation/widgets/text_view.dart';


class DialogYesNo extends StatelessWidget{
  Function? onPressed;
  String? title;
  Widget? widgetView;
  DialogYesNo({this.onPressed,this.title,this.widgetView});
  Map<String,dynamic> jsonData = {};
  @override
  Widget build(BuildContext context) {
    double adder =0;
    jsonData = FlavourConstants.yesNoData;

    if(widgetView!=null){
      adder=10.h;
    }


    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height:( MediaQuery.of(context).size.height + adder )* 0.22,
        child:ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(children: [
                Expanded(child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: MetaTextView(mapData: jsonData['title'],text: title,))
                ),
               if(widgetView!=null)
                widgetView!,
                Row(
                  children: [
                    Expanded(child: Container(
                      width: double.infinity,
                      child: MetaButton(mapData: jsonData['buttonNo'],
                          onButtonPressed: (){
                            onPressed!("NO");
                            Navigator.pop(context);
                          }
                      ),
                    )),
                    Container(width: 1.w,color: Colors.white,padding: EdgeInsets.symmetric(vertical: 2.h),),
                    Expanded(child: Container(
                      width: double.infinity,
                      child: MetaButton(mapData: jsonData['buttonYes'],
                          onButtonPressed: (){
                            Navigator.pop(context);
                            onPressed!("YES");

                          }
                      ),
                    ))
                  ],
                ),
            ]),
             )
         )
     )
    );
  }


}
