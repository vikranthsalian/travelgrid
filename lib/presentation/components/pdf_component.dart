import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/extensions/pretty.dart';
import 'package:travelgrid/presentation/widgets/icon.dart';
import 'package:travelgrid/presentation/widgets/pdf.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

class PDFComponent extends StatelessWidget{
  PDFComponent({super.key,required this.path});
  String path;
  Map<String,dynamic> jsonData = {};
  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.policyData;
    prettyPrint(jsonData);


    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              color:ParseDataType().getHexToColor(jsonData['backgroundColor']),
              height: 100.h,
              child:  Column(
                children: [
                  SizedBox(height:40.h),
                  Container(
                    height: 40.h,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MetaIcon(mapData:jsonData['backBar'],
                            onButtonPressed: (){
                              Navigator.pop(context);
                            }),
                        Container(
                          child:MetaTextView(mapData: jsonData['title']),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height:10.h),
                ],
              ),
            ),
            Expanded(child: MetaPDFView(path: path))
          ],
        )
    );
  }

}
