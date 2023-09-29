import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelex/common/constants/flavour_constants.dart';
import 'package:travelex/presentation/widgets/button.dart';
import 'package:travelex/presentation/widgets/text_view.dart';


class DialogTripType extends StatelessWidget{
  Function? onPressed;
  String? title;
  DialogTripType({this.onPressed,this.title});
  Map<String,dynamic> jsonData = {};
  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.tripTypeData;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.18,
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
                Row(
                  children: [
                    Expanded(child: Container(
                      width: double.infinity,
                      child: MetaButton(mapData: jsonData['buttonYes'],
                          onButtonPressed: (){
                            Navigator.pop(context);
                            onPressed!("D");

                          }
                      ),
                    )),

                    Container(width: 1.w,color: Colors.white,padding: EdgeInsets.symmetric(vertical: 2.h),),
                    Expanded(child: Container(
                      width: double.infinity,
                      child: MetaButton(mapData: jsonData['buttonNo'],
                          onButtonPressed: (){
                            Navigator.pop(context);
                            onPressed!("O");

                          }
                      ),
                    )),
                  ],
                ),
            ]),
             )
         )
     )
    );
  }


}
