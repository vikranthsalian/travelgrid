import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/presentation/components/dialog_type.dart';
import 'package:travelgrid/presentation/screens/common/accom_type_screen.dart';
import 'package:travelgrid/presentation/screens/common/misc_type_screen.dart';
import 'package:travelgrid/presentation/screens/common/travel_mode_screen.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class MetaDialogSelectorView extends StatefulWidget {
  Map mapData;
  String? text;
  Function(Map)? onChange;
  MetaDialogSelectorView({super.key, required this.mapData,this.text,this.onChange});

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
                  builder: (_) => DialogType(
                    size: getSize(widget.mapData['key']),
                    child: getDialogViews(widget.mapData['key']),
              ));
            },
              child: MetaTextView(mapData: widget.mapData['dataText'],text: widget.text,)),
        ],
        )
    );
  }

  Widget getDialogViews(text){
    print(text);

    switch(text){
      case "accom_type_view":
        return AccommodationTypeScreen(
            onTap:(value){
              setState(() {
                widget.text= value['label'];
                widget.onChange!(value);

              });

          });
      case "misc_type_view":
        return MiscellaneousTypeScreen(
            onTap:(value){
              setState(() {
                widget.text= value['label'];
                widget.onChange!(value);
              });

            });
      case "travel_mode_view":
        return TravelModeScreen(
            onTap:(value){
              setState(() {
                widget.text= value['label'];
                widget.onChange!(value);
              });
            });
      default:
       return Container();
    }

  }

  getSize(key) {
    print(key);
    switch(key){
      case "accom_type_view":
        return 0.3;
      case "misc_type_view":
        return 0.8;
      case "travel_mode_view":
        return 0.5;
      default:
        return 0.3;
    }
  }

}


