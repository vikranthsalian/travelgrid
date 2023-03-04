import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MetaCheckBox extends StatefulWidget {

  Function(bool)? onCheckPressed;
  Map mapData;
  bool? value;

  MetaCheckBox({
    this.onCheckPressed,
    this.value = false,
    required this.mapData,
  });

  @override
  State<StatefulWidget> createState() => _MetaCheckBoxState();
}

class _MetaCheckBoxState extends State<MetaCheckBox> {


  @override
  Widget build(BuildContext context) {


    return Container(
      child:Checkbox(
        value: widget.value!,
        activeColor: Colors.green,
        onChanged:(bool? newValue)
          {
            setState(() {
              widget.value = newValue;
            });
            widget.onCheckPressed!(newValue!);

        }
    ));
  }

}

