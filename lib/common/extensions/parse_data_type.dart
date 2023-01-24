import 'package:flutter/material.dart';


class ParseDataType{

  Color getHexToColor(String color){
    if(color=="transparent"){
      return Colors.transparent;
    }
    return Color(int.parse(color));
  }

  double getDouble(String text){
    return double.parse(text);
  }

  Alignment getAlign(String text){

    switch(text){
      case 'center':
       return Alignment.center;

      case 'center-left':
       return Alignment.centerLeft;

      case 'center-right':
        return Alignment.centerRight;

      default:
        return Alignment.center;
    }

  }

  TextInputType getInputType(String text){

    switch(text){
      case 'text':
        return TextInputType.text;

      case 'phone':
        return TextInputType.phone;

      case 'number':
        return TextInputType.number;

      default:
        return TextInputType.text;
    }

  }

}
