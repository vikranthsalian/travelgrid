import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:travelgrid/common/constants/flavour_constants.dart';

class MetaPDFView extends StatelessWidget {
  MetaPDFView({super.key,required this.path});
  String path;

  @override
  Widget build(BuildContext context) {
    print( FlavourConstants.path +"pdfs/"+ path);
     return Container(
         child: SfPdfViewer.asset( FlavourConstants.path +"pdfs/"+ path)
     );
  }

}
