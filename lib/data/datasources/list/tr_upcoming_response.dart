class MetaUpcomingTRResponse {
  bool? status;
  String? token;
  String? message;
  List<Data>? data;

  MetaUpcomingTRResponse({this.status, this.token, this.message, this.data});

  MetaUpcomingTRResponse.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? startDate;
  String? endDate;
  String? url;
  String? tripNumber;
  String? origin;
  String? destination;
  String? currentStatus;
  String? requestType;
  String? segmentType;
  String? trRequestedBy;
  String? shortTitle;

  Data(
      {this.id,
        this.title,
        this.startDate,
        this.endDate,
        this.url,
        this.tripNumber,
        this.origin,
        this.destination,
        this.currentStatus,
        this.requestType,
        this.segmentType,
        this.trRequestedBy,
        this.shortTitle});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    url = json['url'];
    tripNumber = json['tripNumber'];
    origin = json['origin'];
    destination = json['destination'];
    currentStatus = json['currentStatus'] ?? "";
    requestType = json['requestType'];
    segmentType = json['segmentType'];
    trRequestedBy = json['trRequestedBy'];
    shortTitle = json['shortTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['url'] = this.url;
    data['tripNumber'] = this.tripNumber;
    data['origin'] = this.origin;
    data['destination'] = this.destination;
    data['currentStatus'] = this.currentStatus;
    data['requestType'] = this.requestType;
    data['segmentType'] = this.segmentType;
    data['trRequestedBy'] = this.trRequestedBy;
    data['shortTitle'] = this.shortTitle;
    return data;
  }
}
