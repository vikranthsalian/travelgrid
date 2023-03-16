import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class SortComponent extends StatelessWidget {

   String? type;
   int? selected;
   Function? onSelect;
   SortComponent(
      {
        this.selected = 0,
        this.onSelect,
        this.type,
      });


  Map<String,dynamic>? jsonData;
  List list=[];
  Widget build(BuildContext context) {

    jsonData = FlavourConstants.sortData;


    list = jsonData!['listView'];

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
                      MetaIcon(mapData:jsonData!['sortIcon'],
                      onButtonPressed: (){
                        Navigator.pop(context);
                      }),
                    ],
              )
          ),
          for (int i = 0; i <list.length; i++)
            Container(
              decoration:  BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade200,
                      width:0.5,
                    ),
                  )),

              child: InkWell(
                onTap: (){
                  selected =list[i]['id'];
                  onSelect!(list[i]['id'],list[i]);
                },
                child: ListTile(
                  leading: null,
                  minLeadingWidth: 0,
                  title:Container(
                    child: MetaTextView(
                      textAlign: TextAlign.start,
                        mapData: jsonData!['header'],text: list[i]['value']),
                  ),
                  trailing: Radio(
                    value: i,
                    groupValue: selected,
                    onChanged:(value) {
                      selected = list[i]['id'];
                      onSelect!(list[i]['id'],list[i]);
                    },
                  ),
                ),
              )
            ),
        ],
      ),
    );
  }
}