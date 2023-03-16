import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/presentation/components/choice_component.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class FilterComponent extends StatelessWidget {

   Function? selected;
   int? tag;
   List<String> options = [];
   FilterComponent(
      {
       required this.tag,
       required this.selected,
       required this.options,
      });


  Map<String,dynamic>? jsonData;

   // multiple choice value
   List<String> tags = ['news'];




  Widget build(BuildContext context) {

    jsonData = FlavourConstants.filterData;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              color:ParseDataType().getHexToColor(jsonData!['backgroundColor']),
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   MetaTextView(mapData: jsonData!['title']),
                      MetaIcon(mapData:jsonData!['filterIcon'],
                      onButtonPressed: (){
                        Navigator.pop(context);
                      }),
                    ],
              )
          ),
          Container(
            color: Colors.white,
            child: ChoiceComponent(options: options,tag: tag!,
              onChange: (int id){
              print(id);
                selected!(id);
            },),
          )
        ],
      ),
    );
  }
}