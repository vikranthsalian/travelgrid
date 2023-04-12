import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class Utility {

  static Image imageFromBase64String(String base64String,context) {
    return Image.memory(
      base64Decode(base64String),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

      alignment: Alignment.center,
      fit: BoxFit.cover,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}