import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/data/models/location_model.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class MetaToggleButton extends StatefulWidget {

  Function(int)? onCheckPressed;
  List<Widget> items;
  List<bool> steps;
  Color? enabledColor;
  double border;
  int type;


  MetaToggleButton({
    this.onCheckPressed,
    required this.items,
    required this.steps,
    this.enabledColor,
    this.border= 8.0,
    this.type= 1,
  });

  @override
  State<StatefulWidget> createState() => _MetaToggleButtonState();
}

class _MetaToggleButtonState extends State<MetaToggleButton> {


  @override
  Widget build(BuildContext context) {


    return Container(
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.all(Radius.circular(widget.border)),
      ),
      child:ToggleButtons(
        direction:Axis.horizontal,
        onPressed: (int index) {
          widget.onCheckPressed!(index);
          setState(() {
            // The button that is tapped is set to true, and the others to false.
            for (int i = 0; i < widget.steps.length; i++) {
              widget.steps[i] = i == index;
            }
          });
        },
        borderRadius:  BorderRadius.all(Radius.circular(widget.border)),
        selectedBorderColor: Colors.white,
        selectedColor: Colors.white,
        fillColor: widget.enabledColor,
        color: Colors.grey,
        borderColor: Colors.grey,
        constraints: BoxConstraints(
          minHeight: widget.type == 1 ? 40.0 : 15,
          minWidth: widget.type == 1 ? 100.0:70,
        ),
        isSelected: widget.steps,
        children: widget.items,
      ));
  }

}

