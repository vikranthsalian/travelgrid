import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/presentation/widgets/button.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';


class FileUploadScreen extends StatelessWidget {
  Function? onTap;
  FileUploadScreen({this.onTap});


  Map<String,dynamic> jsonData = {};


  @override
  Widget build(BuildContext context) {
    jsonData = FlavourConstants.uploadData;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Column(children: [
            SizedBox(height: 20.h,),
            MetaTextView(mapData: jsonData['title']),
         //   Expanded(child: getListView()),
            Container(
              width: double.infinity,
              child: MetaButton(mapData: jsonData['bottomButtonCentre'],
                  onButtonPressed: (){
                  Navigator.pop(context);
                  }
              ),
            )
          ])
      ),
    );
  }


}
