class TEListResponse {
  bool? status;
  String? token;
  String? message;
  List<Data>? data;

  TEListResponse({this.status, this.token, this.message, this.data});

  TEListResponse.fromJson(Map<String, dynamic> json) {
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
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? date;
  String? recordLocator;
  String? status;
  String? employeeName;
  double? totalAmount;

  Data(
      {this.date,
        this.recordLocator,
        this.status,
        this.employeeName,
        this.totalAmount});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    recordLocator = json['recordLocator'];
    status = json['status'];
    employeeName = json['employeeName'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['recordLocator'] = this.recordLocator;
    data['status'] = this.status;
    data['employeeName'] = this.employeeName;
    data['totalAmount'] = this.totalAmount;
    return data;
  }
}
