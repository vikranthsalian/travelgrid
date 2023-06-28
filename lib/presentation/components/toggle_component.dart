import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class ToggleComponent extends StatefulWidget {
  Function? onChange;
  List<Widget>? list;
  ToggleComponent({this.onChange,this.list});

  @override
  _ToggleComponentState createState() => _ToggleComponentState();
}

class _ToggleComponentState extends State<ToggleComponent> {

  List<bool> isSelected = [true, false, false];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      // list of booleans
        isSelected: isSelected,
        // text color of selected toggle
        selectedColor: Colors.white,
        // text color of not selected toggle
        color: Colors.blue,
        // fill color of selected toggle
        fillColor: Colors.lightBlue.shade900,
        // when pressed, splash color is seen
        splashColor: Colors.red,
        // long press to identify highlight color
        highlightColor: Colors.orange,
        // if consistency is needed for all text style
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        // border properties for each toggle
        renderBorder: true,
        borderColor: Colors.black,
        borderWidth: 1.5,
        borderRadius: BorderRadius.circular(10),
        selectedBorderColor: Colors.pink,

        children: widget.list!,

        onPressed: (int newIndex) {
          print("ontap");

          setState(() {
            // looping through the list of booleans values
            for (int index = 0; index < isSelected.length; index++) {
              if (index == newIndex) {
                // toggling between the button to set it to true
                isSelected[index] = !isSelected[index];
              } else {
                // other two buttons will not be selected and are set to false
                isSelected[index] = false;
              }
            }
          });
        }
    );
  }



}
