import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class MetaCheckBox extends StatefulWidget {

  Function(bool?)? onCheckPressed;
  Map mapData;
  bool? value;

  MetaCheckBox({
    this.onCheckPressed,
    this.value = false,
    required this.mapData
  });

  @override
  State<StatefulWidget> createState() => _MetaCheckBoxState();
}

class _MetaCheckBoxState extends State<MetaCheckBox> {
  bool? value;

  @override
  Widget build(BuildContext context) {


    return Container(
      child: CheckboxListTile(
        title: MetaTextView(mapData: widget.mapData['label']),
        controlAffinity: ListTileControlAffinity.leading,
        value: widget.value,
        onChanged: (bool? value) {
          setState(() {
            widget.value = value;
            widget.onCheckPressed!(value);
          });
        },
      ),
    );
  }

}