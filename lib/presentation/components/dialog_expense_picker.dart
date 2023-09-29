import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelex/common/constants/flavour_constants.dart';
import 'package:travelex/common/extensions/parse_data_type.dart';
import 'package:travelex/presentation/widgets/button.dart';
import 'package:travelex/presentation/widgets/svg_view.dart';
import 'package:travelex/presentation/widgets/text_view.dart';

class DialogExpensePicker extends StatelessWidget{
  List mapData;
  Function? onSelected;
  DialogExpensePicker({required this.mapData,this.onSelected});

  Map<String,dynamic> jsonData = {};
  @override
  Widget build(BuildContext context) {
    
    
    jsonData= FlavourConstants.expensePickerData;
    
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        child:ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(children: [
                SizedBox(height: 20.h,),
                MetaTextView(mapData: jsonData['title']),
                Expanded(child: getListView(mapData)),
                Container(
                  width: double.infinity,
                  child: MetaButton(mapData: jsonData['bottomButtonCentre'],
                      onButtonPressed: (){
                        Navigator.pop(context);
                   }
                  ),
                )
            ]),
             )
         )
     )
    );
  }

  Widget getListView(list){
    return  list.isNotEmpty ? GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: list.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,mainAxisSpacing: 3.h,childAspectRatio: 2),
      itemBuilder: (BuildContext context, int index) {

        return InkWell(
            onTap: () async{
              Navigator.pop(context);
              onSelected!(list[index]);
            },
            child:Container(
              height: 40.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                            height: 35.w,
                            width: 35.w,
                            decoration: BoxDecoration(
                              color: ParseDataType().getHexToColor(jsonData['backgroundColor']),
                              shape: BoxShape.circle,
                            ),
                        ),
                        Container(
                            height: 25.w,
                            width: 25.w,
                            child: MetaSVGView(mapData: list[index]['svgIcon'],)
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 20.h,
                      alignment: Alignment.center,
                      child: MetaTextView(mapData: list[index]['title'])
                  )
                ],
              ),
            )
        );
      },
    ):  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MetaTextView(mapData: jsonData['listView']['emptyData']['title'])
        ]
    );
  }



}
