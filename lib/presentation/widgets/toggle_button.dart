import 'package:flutter/material.dart';

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
        color: Colors.grey.withOpacity(0.3),
        borderRadius:  BorderRadius.all(Radius.circular(widget.border)),
      ),
      child:ToggleButtons(
        direction:Axis.horizontal,

        onPressed: (index) {
          print("asd");
          print(index);
          widget.onCheckPressed!(index);
          for (int i = 0; i < widget.steps.length; i++) {
            widget.steps[i] = i == index;
          }
          setState(() {
            // The button that is tapped is set to true, and the others to false.

          });
        },
        borderRadius:  BorderRadius.all(Radius.circular(widget.border)),
       // / selectedBorderColor: Colors.white,
       // selectedColor: Colors.white,
        fillColor: widget.enabledColor,
        //color: Colors.grey,
       // borderColor: Colors.grey,
        constraints: BoxConstraints(
          minHeight:15,
          minWidth: 70,
        ),
        isSelected: widget.steps,
        children: widget.items,
      ));
  }

}

