class MetaCityListResponse {
  bool? status;
  String? token;
  String? message;
  List<Data>? data;

  MetaCityListResponse({this.status, this.token, this.message, this.data});

  MetaCityListResponse.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String code="";
  String? state;
  String? country;
  String? countryCode;

  Data(
      {this.id,
        this.name,
        this.code="",
        this.state,
        this.countryCode,
        this.country});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'] ?? "";
    state = json['state'];
    country = json['country'];
    countryCode = json['countryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['state'] = this.state;
    data['country'] = this.country;
    data['countryCode'] = this.countryCode;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'code': this.code,
      'state': this.state,
      'country': this.country,
      'countryCode': this.countryCode,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id'] as int,
      name: map['name'] as String,
      code: map['code'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      countryCode: map['countryCode'] as String,
    );
  }
}
