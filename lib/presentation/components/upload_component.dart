import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';
import 'package:travelgrid/common/extensions/parse_data_type.dart';
import 'package:travelgrid/presentation/components/dialog_upload_type.dart';
import 'package:travelgrid/presentation/components/dialog_yes_no.dart';
import 'package:travelgrid/presentation/screens/wallet/wallet_screen.dart';
import 'package:travelgrid/presentation/widgets/svg_view.dart';
import 'package:travelgrid/presentation/widgets/text_view.dart';

import 'package:dotted_border/dotted_border.dart';

class UploadComponent extends StatefulWidget {
  Map<String,dynamic> jsonData;
  Function? onSelected;
  String? url;
  bool? isViewOnly;

  UploadComponent({required this.jsonData,this.onSelected,this.url,this.isViewOnly=false});
  @override
  _UploadComponentState createState() => _UploadComponentState();
}

class _UploadComponentState extends State<UploadComponent> {
   File? file;
   final ImagePicker _picker = ImagePicker();

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
        child:widget.isViewOnly! ? urlViewer() :
           (file==null && (widget.url==null || widget.url!.isEmpty)) ? getUploaderView() : getViewer(),
      ),
    );
  }

  Widget urlViewer(){
    print("urlViewer");

    if(widget.url!.isEmpty){
      return MetaTextView(mapData: widget.jsonData['title'],text: "No Document Found",);
    }

    return Image.network(FlavourConstants.apiHost+"downloadAttachment?filePath="+widget.url.toString());
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
                  (widget.url!=null && widget.url!.isNotEmpty) ?
                  Image.network(FlavourConstants.apiHost+"downloadAttachment?filePath="+widget.url.toString()):
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
        await showDialog(
            context: context,
            builder: (_) => DialogUploadType(
                mapData: widget.jsonData,
                onSelected: (value)async{
                  if(value == "Gallery"){

                    final XFile? pickedFile = await _picker.pickImage(
                      source: ImageSource.gallery
                    );


                    if (pickedFile != null) {
                      file =   File(pickedFile.path.toString());

                      setState(() {

                      });
                      widget.onSelected!(file);
                    } else {
                      // User canceled the picker
                    }
                  }else  if(value == "Documents"){

                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                            WalletHome(
                              isSelectable: true,
                              selected:(val)async {
                                Navigator.pop(context);
                                file =   await convertImageToFile(val);
                                setState(() {});
                                widget.onSelected!(file);
                              })));

                  }else {
                    final XFile? pickedFile = await _picker.pickImage(
                        source: ImageSource.camera
                    );
                    if (pickedFile != null) {
                      file = File(pickedFile.path.toString());
                      setState(() {});
                      widget.onSelected!(file);
                    }
                  }


                }
            ));
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
   Future<File> convertImageToFile(byteData) async {

     Uint8List bytes = base64.decode(byteData);
     String dir = (await getApplicationDocumentsDirectory()).path;
     File file = File(
         "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".png");
     await file.writeAsBytes(bytes);
     print(file);
     return file;
   }
}
