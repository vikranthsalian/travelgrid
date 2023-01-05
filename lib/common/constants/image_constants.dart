import 'package:flutter_flavor/flutter_flavor.dart';

class ImageConstants {

  static const assetsBaseURL = "assets";
  static const assetsBaseURLImage = "$assetsBaseURL/images";
  static const assetsBaseURLSVG = "$assetsBaseURLImage/svg";
  static const assetsBaseURLJPG = "$assetsBaseURLImage/jpg";
  static const assetsBaseURLPNG = "$assetsBaseURLImage/png";

  //png
  static const cardGlossPng = "$assetsBaseURLPNG/card_gloss.png";


//Svg
  static const bottomHomeSvg = "$assetsBaseURLSVG/bottomHome.svg";

  static  String appLogo =  FlavorConfig.instance.variables["appLogo"];
}