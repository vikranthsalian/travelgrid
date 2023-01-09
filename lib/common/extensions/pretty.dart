import 'dart:convert';

void prettyPrint(jsonObject){
  var encoder = new JsonEncoder.withIndent("     ");
  print(encoder.convert(jsonObject));
}