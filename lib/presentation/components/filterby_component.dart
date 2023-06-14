import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/presentation/components/choice_component.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class FilterComponent extends StatelessWidget {

   Function? selected;
  // int? tag;
   List<String> tags;
   List<String> options = [];
   FilterComponent(
      {
      // required this.tag,
       required this.tags,
       required this.selected,
       required this.options,
      });


  Map<String,dynamic> jsonData={};

   // multiple choice value
  // List<String> tags = ['news'];


   var data;


  Widget build(BuildContext context) {

    jsonData = FlavourConstants.filterData;

    return Scaffold(
      bottomNavigationBar: Container(
        child: BottomAppBar(
          color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          elevation: 2.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MetaButton(mapData: jsonData['bottomButtonLeft'],
                  onButtonPressed: (){
                Navigator.pop(context);

                  }
              ),
              MetaButton(mapData: jsonData['bottomButtonRight'],
                  onButtonPressed: (){
                    selected!(data);
                  }
              )
            ],
          ),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     MetaTextView(mapData: jsonData['title']),
                        MetaIcon(mapData:jsonData['filterIcon'],
                        onButtonPressed: (){

                        }),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: MetaIcon(mapData:jsonData['closeIcon'],
                            onButtonPressed: (){
                              Navigator.pop(context);
                            }),
                      ),
                    ),
                      ],
                )
            ),
            Container(
              child: ChoiceComponent(
                options: options,
                tags: tags,
                onChange: (ids){

                print("Select Filters");
                print(ids);
                data=ids;

              },),
            )
          ],
        ),
      ),
    );
  }
}