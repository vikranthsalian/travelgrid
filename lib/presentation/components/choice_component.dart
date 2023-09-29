import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:travelex/common/constants/color_constants.dart';

class ChoiceComponent extends StatefulWidget {
  List<String> tags;
 // int tag;
  List<String> options;
  Function? onChange;

  ChoiceComponent({
    required this.tags,
   // required this.tag,
    required this.options,this.onChange});
  @override
  _ChoiceComponentState createState() => _ChoiceComponentState();
}

class _ChoiceComponentState extends State<ChoiceComponent> {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: ChipsChoice<String>.multiple(
        value: widget.tags,
        onChanged: (val) {
          if(val.length >1  && val.first=="All"){
            val.remove("All");
          }else if(val.length >1  && val.last=="All"){
            val=["All"];
          }
            setState(() {
               widget.tags = val;
           });
            widget.onChange!(widget.tags );
        },
        choiceItems:
        C2Choice.listFrom<String, String>(
          source: widget.options,
          value: (i, v) => v,
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
