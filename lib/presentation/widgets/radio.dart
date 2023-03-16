import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MetaRadio extends StatefulWidget {

  Function(bool)? onRadioSwitched;
  bool? value;

  MetaRadio({
    this.onRadioSwitched,
    this.value,
  });

  @override
  State<StatefulWidget> createState() => _MetaRadioState();
}

class _MetaRadioState extends State<MetaRadio> {
  int _value = 0;
  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
      child: Radio(
        value: widget.value,
        groupValue: _value,
        onChanged:(value) {
          setState(() {

          });
        },
      )
    );
  }

}
