import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MetaDateTime{

  String getDate(String date,{String format = 'MM/dd/yyyy'}) {
    // var formatter = new DateFormat('yyyy-MM-dd');
    // DateTime dateTime = formatter.parse(date);
    DateTime parseDate = new DateFormat("dd-MM-yyyy").parse(date);
    if(date !="null") {
      final DateFormat formatter = DateFormat(format);
      final String formatted = formatter.format(DateTime.parse(parseDate.toString()));
      return formatted;
    }
    return "";
  }

  String getTime(String date) {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(date);
      return DateFormat.Hm().format(dateTime).toString(); //5:08 PM
    }
    catch (e) {
      return date;
    }
  }
  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }
}