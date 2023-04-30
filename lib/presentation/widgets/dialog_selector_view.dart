import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/presentation/components/dialog_group.dart';
import 'package:travelgrid/presentation/components/dialog_type.dart';
import 'package:travelgrid/presentation/screens/common/accom_type_screen.dart';
import 'package:travelgrid/presentation/screens/common/common_type_screen.dart';
import 'package:travelgrid/presentation/screens/common/currency_screen.dart';
import 'package:travelgrid/presentation/screens/common/fare_class_screen.dart';
import 'package:travelgrid/presentation/screens/common/misc_type_screen.dart';
import 'package:travelgrid/presentation/screens/common/travel_mode_screen.dart';
import 'package:travelgrid/presentation/screens/common/travel_purpose_screen.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class MetaDialogSelectorView extends StatefulWidget {
  Map mapData;
  String? text;
  String? modeType;
  Function(Map)? onChange;
  MetaDialogSelectorView({super.key, required this.mapData,this.text,this.onChange,this.modeType});

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
          MetaTextView(mapData: widget.mapData['label'],textAlign: TextAlign.start,),
          InkWell(
            onTap: () async {


              if(widget.mapData['key']=="click_type"){
                showDialog(
                    context: appNavigatorKey.currentState!.context,
                    builder: (_) =>
                        DialogGrooup(
                            isName:widget.mapData['value'],
                            isAccommodation: true,
                            onSubmit: (value) {
                              widget.text=widget.mapData['value']=="Name" ? value['name']:value['code'];
                              widget.onChange!(value);
                            }));
                return;
              }

              if(widget.mapData['key']!="disabled"){
                await showDialog(
                    context: context,
                    builder: (_) => DialogType(
                      size: getSize(widget.mapData['key']),
                      child: getDialogViews(widget.mapData),
                    ));
              }


            },
              child: MetaTextView(mapData: widget.mapData['dataText'],text: widget.text,textAlign: TextAlign.start,)),
        ],
        )
    );
  }

  Widget getDialogViews(text){
    switch(text['key']){
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
        case "currency_type_view":
        return CurrencyScreen(
            onTap:(value){
              setState(() {
                widget.text= value['label'];
                widget.onChange!(value);
              });
            });
      case "fare_class_view":
        return FareClassScreen(
          mode:widget.modeType!=null ?widget.modeType: text['modeType'],
            onTap:(value){
              setState(() {
                widget.text= value['label'];
                widget.onChange!(value);
              });
            });
        case "travel_purpose_view":
        return TravelPurposeScreen(
            onTap:(value){
              setState(() {
                widget.text= value['label'];
                widget.onChange!(value);
              });
            });
      case "common_type_view":
        return CommonTypeScreen(
            mapData: widget.mapData,
            onTap:(value){
              setState(() {
                widget.text= value['text'];
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
      case "fare_class_view":
        return 0.5;
      case "travel_mode_view":
        return 0.5;
      case "travel_purpose_view":
        return 0.7;
      case "currency_type_view":
        return 0.7;
      default:
        return 0.3;
    }
  }

}


