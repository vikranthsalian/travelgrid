import 'package:flutter_flavor/flutter_flavor.dart';

class AssetConstants {

  static const assetsBaseURL = "assets/build-runner";
  static const assetsBaseURLImage = "$assetsBaseURL/images";
  static const assetsBaseURLSVG = "$assetsBaseURL/svg";
  static const assetsBaseURLJPG = "$assetsBaseURL/jpg";
  static const assetsBaseURLPNG = "$assetsBaseURL/png";

  //png
  static const cardGlossPng = "$assetsBaseURLPNG/card_gloss.png";


//Svg
  static const pdfSvg = "$assetsBaseURLSVG/pdf.svg";

  static  String appLogo =  FlavorConfig.instance.variables["appLogo"];
}