import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:travelgrid/common/constants/color_constants.dart';

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
          color: Colors.grey.withOpacity(0.6),
          borderWidth: 1,
          backgroundColor: ColorConstants.primaryColor,
          selectedStyle: const C2ChipStyle(
            // avatarBackgroundColor: ColorConstants.primaryColor,
            // overlayColor: ColorConstants.primaryColor,
             foregroundColor: ColorConstants.primaryColor,
            // backgroundColor: ColorConstants.primaryColor,
            borderColor: ColorConstants.primaryColor,
          ),
        ),
        wrapped: true,
      ),
    );
  }

}
