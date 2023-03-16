import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/presentation/components/dialog_upload_type.dart';
import 'package:travelgrid/presentation/components/dialog_yes_no.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

import 'package:dotted_border/dotted_border.dart';

class ChoiceComponent extends StatefulWidget {
 // List<String> tags;
  int tag;
  List<String> options;
  Function? onChange;

  ChoiceComponent({
   // required this.tags,
    required this.tag,
    required this.options,this.onChange});
  @override
  _ChoiceComponentState createState() => _ChoiceComponentState();
}

class _ChoiceComponentState extends State<ChoiceComponent> {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: ChipsChoice<int>.single(
        value: widget.tag,
        onChanged: (val) {
            setState(() {
               widget.tag = val;
           });
            widget.onChange!(widget.tag);
        },
        choiceItems:
        C2Choice.listFrom<int, String>(
          source: widget.options,
          value: (i, v) => i,
          label: (i, v) => v,
          tooltip: (i, v) => v,
        ),
        choiceStyle: C2ChipStyle.outlined(
          borderWidth: 2,
          selectedStyle: const C2ChipStyle(
            borderColor: Colors.green,
            foregroundColor: Colors.green,
          ),
        ),
        wrapped: true,
      ),
    );
  }

}
