import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class SwitchComponent extends StatefulWidget {
  Map<String,dynamic> jsonData;
  Widget childWidget;
  bool? initialValue;
  Color color;
  SwitchComponent({required this.jsonData,required this.childWidget,this.initialValue=false,required this.color});

  @override
  _CreateSwitchComponentState createState() => _CreateSwitchComponentState();
}

class _CreateSwitchComponentState extends State<SwitchComponent> {
 bool switchData = true;
  @override
  void initState() {

    super.initState();
    switchData=widget.initialValue!;

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildHeaders(widget.jsonData),
          switchData ?  widget.childWidget :SizedBox()
        ],
      ),
    );
  }

  Container buildHeaders(Map<String,dynamic> map) {
    return Container(
      height: 40.h,
      color:  widget.color,
      child: Row(

        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: MetaTextView(mapData: map['label'])),
           Expanded(child: Container(
            alignment: Alignment.centerLeft,
            child: MetaSwitch(mapData: map['showDetails'],
              value: switchData,
              onSwitchPressed: (value){
                setState(() {
                  switchData=value;
                });
              },),
          ))
        ],
      ),
    );
  }


}
