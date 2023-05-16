
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareUtils{
  ShareUtils._();
  static onShareFiles(imagePath,text,subject) async {

    if (imagePath.isNotEmpty) {
      Share.shareFiles(['$imagePath'],text: text+" "+subject,subject:subject);
    } else {
     Share.share(text);
    }

  }
  static onShareMsg(text) async {
    // final bytes = await rootBundle.load('assets/app_icon.png');
    // final list = bytes.buffer.asUint8List();
    // final tempDir = await getTemporaryDirectory();
    // final file = await File('${tempDir.path}/image.jpg').create();
    // file.writeAsBytesSync(list);
    Share.share(text);
  }

}