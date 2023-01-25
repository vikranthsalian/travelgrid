import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class MetaSwitch extends StatefulWidget {

  Function(bool)? onSwitchPressed;
  Map mapData;
  bool value;

  MetaSwitch({
    this.onSwitchPressed,
    this.value = true,
    required this.mapData
  });

  @override
  State<StatefulWidget> createState() => _MetaSwitchState();
}

class _MetaSwitchState extends State<MetaSwitch> {
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(child: MetaTextView(mapData: widget.mapData['label'])),
          Switch(
            activeColor: Colors.green,
            value: widget.value,
            onChanged:(bool value) {
              setState(() {
                widget.value = value;
                widget.onSwitchPressed!(value);
              });
            },
          ),
        ],
      ),
    );

  }

}