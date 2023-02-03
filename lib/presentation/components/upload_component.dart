import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelgrid/common/constants/asset_constants.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/constants/route_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/presentation/components/dialog_upload_type.dart';
import 'package:travelgrid/presentation/components/dialog_yes_no.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

import 'package:dotted_border/dotted_border.dart';

class UploadComponent extends StatefulWidget {
  Map<String,dynamic> jsonData;
  Function? onSelected;

  UploadComponent({required this.jsonData,this.onSelected});
  @override
  _UploadComponentState createState() => _UploadComponentState();
}

class _UploadComponentState extends State<UploadComponent> {
  File? file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: _roundedRectBorderWidget);
  }
  /// Draw a border with a rounded rectangular border
  Widget get _roundedRectBorderWidget {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12.r),
      padding: EdgeInsets.all(16.w),
      color: ParseDataType().getHexToColor(widget.jsonData['backgroundColor']),
      strokeCap: StrokeCap.butt,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child:file!=null ? getViewer() : getUploaderView(),
      ),
    );
  }

  getViewer() {
    Map remove = {
      "text" : "Remove",
      "color" : "0xFFFFFFFF",
      "size": "10",
      "family": "regular",
      "align" : "center"
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            height: 70.h,
            width: 70.h,
            child: Stack(
              alignment: Alignment.bottomCenter,
                children: [
                  Container(
                      height: 70.h,
                      width: 70.h,
                      child: Image.file(file!)
                  ),
                  InkWell(
                    onTap: ()async{
                      await showDialog(
                          context: context,
                          builder: (_) => DialogYesNo(onPressed: (value){

                            if(value=="YES"){
                              file = null;
                            }
                            setState(() {

                            });

                          }));
                    },
                    child: Container(
                      color: Colors.red,
                        height: 20.h,
                        width: 70.h,
                        child: MetaTextView(mapData: remove)
                    ),
                  )
                ])
        ),
        getUploaderView()
      ],
    );
  }

  getUploaderView(){
    return InkWell(
      onTap:()async{
        await showDialog(
            context: context,
            builder: (_) => DialogUploadType(
                mapData: widget.jsonData,
                imageSelected: (dataFile){
                  Navigator.pop(context);
                  widget.onSelected!(dataFile);
                  setState(() {
                    file=dataFile;
                  });
                }
            ));
      },
      child: Container(
        height: 65.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 30.w,
                width: 30.w,
                child: MetaSVGView(mapData:  widget.jsonData['svgIcon'])
            ),
            Container(
              child:MetaTextView(mapData: widget.jsonData['title']),
            ),
            Container(
              child:MetaTextView(mapData: widget.jsonData['subtitle']),
            ),
          ],
        ),
      ),
    );
  }

}
