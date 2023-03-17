import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:travelgrid/presentation/components/dialog_upload_type.dart';
import 'package:travelgrid/presentation/components/dialog_yes_no.dart';
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
 // late CameraController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   // setupCamera();


  }
  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
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
            height: 60.h,
            width: 60.h,
            child: Stack(
              alignment: Alignment.bottomCenter,
                children: [
                  Container(
                      height:60.h,
                      width: 60.h,
                      child: Image.file(File(file!.path))
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
                        width: 60.h,
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
        // await showDialog(
        //     context: context,
        //     builder: (_) => DialogUploadType(
        //         mapData: widget.jsonData,
        //         onSelected: (value)async{
        //           if(value == "Gallery"){
        //             FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);
        //             if (result != null) {
        //               file =   File(result.files.single.path.toString());
        //
        //               setState(() {
        //
        //               });
        //             } else {
        //               // User canceled the picker
        //             }
        //           }else{
        //           MetaAlert.showErrorAlert(message: "Working on it.");
        //         //  takePicture();
        //           }
        //
        //
        //         }
        //     ));
      },
      child: Container(
        height: 55.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 25.w,
                width: 25.w,
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

  // void setupCamera() {
  //   availableCameras().then((_cameras) {
  //     print(_cameras[0]);
  //     controller = CameraController(_cameras[0], ResolutionPreset.medium);
  //     controller.initialize().then((_) {
  //       if (!mounted) {
  //         return;
  //       }
  //       setState(() {});
  //     }).catchError((Object e) {
  //       print(e);
  //       if (e is CameraException) {
  //         switch (e.code) {
  //           case 'CameraAccessDenied':
  //           // Handle access errors here.
  //             break;
  //           default:
  //           // Handle other errors here.
  //             break;
  //         }
  //       }
  //     });
  //   });
  // }
  //
  // Future takePicture() async {
  //   if (!controller.value.isInitialized) {
  //     print("!isInitialized");
  //     return null;
  //   }
  //   if (controller.value.isTakingPicture) {
  //     print("!isTakingPicture");
  //     return null;
  //   }
  //   try {
  //     await controller.setFlashMode(FlashMode.off);
  //     XFile picture = await controller.takePicture();
  //
  //
  //     setState(() {
  //     file = picture;
  //     });
  //
  //   } on CameraException catch (e) {
  //     debugPrint('Error occured while taking picture: $e');
  //     return null;
  //   }
  // }
}
