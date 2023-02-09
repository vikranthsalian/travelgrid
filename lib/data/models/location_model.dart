import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class LocationModel {
  String? location;
  double? longitude;
  double? latitude;
  String? date;
  String? time;
  bool? isChecked;

  LocationModel(
      {this.location,
        this.longitude,
        this.latitude,
        this.date,
        this.time,
        this.isChecked=false});

  LocationModel.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    date = json['date'];
    time = json['time'];
    isChecked = json['isChecked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['date'] = this.date;
    data['time'] = this.time;
    data['isChecked'] = this.isChecked;
    return data;
  }
}