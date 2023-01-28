import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/presentation/components/dialog_accom_type.dart';
import 'package:travelgrid/presentation/screens/common/accom_type_screen.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';
class MetaDialogSelectorView extends StatefulWidget {

  Map mapData;
  String? text;
  MetaDialogSelectorView({super.key, required this.mapData,this.text});

  @override
  State<StatefulWidget> createState() => _MetaDialogSelectorViewState();
}

class _MetaDialogSelectorViewState extends State<MetaDialogSelectorView> {


  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
        child: Column(
        children: [
          MetaTextView(mapData: widget.mapData['label']),
          InkWell(
            onTap: () async{
              await showDialog(
                  context: context,
                  builder: (_) => DialogAccomType(
                    child: getDialogViews(widget.mapData['key']),
              ));
            },
              child: MetaTextView(mapData: widget.mapData['dataText'],text: widget.text,)),
        ],
        )
    );
  }

  Widget getDialogViews(text){

    switch(text){
      case "accom_type_view":
        return AccommodationTypeScreen(
            onTap:(value){
              widget.text= value['label'];
          });
      case "travel_mode_view":
        return AccommodationTypeScreen(
            onTap:(value){
              widget.text= value['label'];
            });
      default:
       return Container();
    }

  }

}


