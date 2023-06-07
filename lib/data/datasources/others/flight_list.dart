  class MetaFlightListResponse {
  bool? status;
  String? token;
  String? message;
  List<Data>? data;

  MetaFlightListResponse({this.status, this.token, this.message, this.data});

  MetaFlightListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] == "SUCCESS" ? true:false;
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
  int? id;
  String? flight;
  String? from;
  String? to;
  String? departDate;
  String? arriveDate;
  double? retailFare;
  double? corpFare;

  Data({this.id, this.flight, this.from, this.to, this.departDate, this.arriveDate,this.retailFare,this.corpFare});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flight = json['flight'];
    from = json['from'];
    to = json['to'];
    departDate = json['departDate'] ;
    arriveDate = json['arriveDate'];
    retailFare = json['retailFare'];
    corpFare = json['corpFare'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['flight'] = this.flight;
    data['from'] = this.from;
    data['to'] = this.to;
    data['departDate'] = this.departDate;
    data['arriveDate'] = this.arriveDate;
    data['retailFare'] = this.retailFare;
    data['corpFare'] = this.corpFare;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'flight': this.flight,
      'from': this.from,
      'to': this.to,
      'departDate': this.departDate,
      'arriveDate': this.arriveDate,
      'retailFare': this.retailFare,
      'corpFare': this.corpFare,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id'] as int,
      flight: map['flight'] as String,
      from: map['from'] as String,
      to: map['to'] as String,
      departDate: map['departDate'] as String,
      retailFare: map['retailFare'] as double,
      corpFare: map['corpFare'] as double,
    );
  }
}
