import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/switch.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class ExpandableComponent extends StatefulWidget {
  Map<String,dynamic> jsonData;
  Widget childWidget;
  bool? initialValue;
  Color color;
  ExpandableComponent({required this.jsonData,required this.childWidget,this.initialValue=false,required this.color});

  @override
  _ExpandableComponentState createState() => _ExpandableComponentState();
}

class _ExpandableComponentState extends State<ExpandableComponent> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        title: MetaTextView(mapData: widget.jsonData['label']),
        children:[widget.childWidget],
      )
    );
  }



}
