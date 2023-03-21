class TRListResponse {
  bool? status;
  String? token;
  String? message;
  List<Data>? data;

  TRListResponse({this.status, this.token, this.message, this.data});

  TRListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] =="SUCCESS" ? true:false;
    token = json['token'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? tripNumber;
  String? employeeName;
  String? startDate;
  String? endDate;
  String? origin;
  String? destination;
  String? currentStatus;
  String? tripType;
  String? travelerName;
  String? tripPlan;
  List<MaCityPairs>? maCityPairs;

  Data({this.id,
    this.tripNumber,
    this.employeeName,
    this.startDate,
    this.endDate,
    this.origin,
    this.destination,
    this.currentStatus,
    this.tripType,
    this.travelerName,
    this.maCityPairs,
    this.tripPlan});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tripNumber = json['tripNumber'];
    employeeName = json['employeeName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    origin = json['origin'];
    destination = json['destination'];
    currentStatus = json['currentStatus'];
    tripType = json['tripType'];
    travelerName = json['travelerName'];
    tripPlan = json['tripPlan'];
    if (json['maCityPairs'] != null) {
      maCityPairs = <MaCityPairs>[];
      json['maCityPairs'].forEach((v) {
        maCityPairs!.add(new MaCityPairs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tripNumber'] = this.tripNumber;
    data['employeeName'] = this.employeeName;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['origin'] = this.origin;
    data['destination'] = this.destination;
    data['currentStatus'] = this.currentStatus;
    data['tripType'] = this.tripType;
    data['travelerName'] = this.travelerName;
    data['tripPlan'] = this.tripPlan;
    if (this.maCityPairs != null) {
      data['maCityPairs'] = this.maCityPairs!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

  class MaCityPairs {
  int? id;
  LeavingFrom? leavingFrom;
  LeavingFrom? goingTo;

  MaCityPairs({this.id, this.leavingFrom, this.goingTo});

  MaCityPairs.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  leavingFrom = json['leavingFrom'] != null ? new LeavingFrom.fromJson(json['leavingFrom']) : null;
  goingTo = json['goingTo'] != null ? new LeavingFrom.fromJson(json['goingTo']) : null;
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  if (this.leavingFrom != null) {
  data['leavingFrom'] = this.leavingFrom!.toJson();
  }
  if (this.goingTo != null) {
  data['goingTo'] = this.goingTo!.toJson();
  }
  return data;
  }
}
class LeavingFrom {
  int? id;
  String? name;
  String? locationName;
  bool? enabled;
  String? cityCode;
  String? cityClass;
 // State? state;

  LeavingFrom({this.id, this.name, this.locationName, this.enabled, this.cityCode, this.cityClass});

  LeavingFrom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    locationName = json['locationName'];
    enabled = json['enabled'];
    cityCode = json['cityCode'] ?? "";
    cityClass = json['cityClass'];
   // state = json['state'] != null ? new State.fromJson(json['state']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['locationName'] = this.locationName;
    data['enabled'] = this.enabled;
    data['cityCode'] = this.cityCode;
    data['cityClass'] = this.cityClass;
    // if (this.state != null) {
    //   data['state'] = this.state!.toJson();
    // }
    return data;
  }
}
