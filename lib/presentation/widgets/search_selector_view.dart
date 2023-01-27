import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/presentation/screens/common/cities_screen.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class MetaSearchSelectorView extends StatefulWidget {

  Map mapData;
  String? text;
  MetaSearchSelectorView({super.key, required this.mapData,this.text});

  @override
  State<StatefulWidget> createState() => _MetaSearchSelectorViewState();
}

class _MetaSearchSelectorViewState extends State<MetaSearchSelectorView> {

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
        child: Column(
        children: [
          MetaTextView(mapData: widget.mapData['label']),
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CityScreen(
                onTap: (Map data){
                  Navigator.pop(context);
                  prettyPrint("MetaSearchSelectorView");
                  prettyPrint(data);

                  setState(() {
                    widget.text=data['name'];
                  });
                },
              )));
            },
              child: MetaTextView(mapData: widget.mapData['dataText'],text: widget.text)),
        ],
        )
    );
  }

}

