class MetaCountryListResponse {
  bool? status;
  String? token;
  String? message;
  List<Data>? data;

  MetaCountryListResponse({this.status, this.token, this.message, this.data});

  MetaCountryListResponse.fromJson(Map<String, dynamic> json) {
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
  String? countryName;
  String? countryCode;

  Data({
        this.countryName,
        this.countryCode});

  Data.fromJson(Map<String, dynamic> json) {
    countryName = json['countryName'];
    countryCode = json['countryCode'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryName'] = this.countryName;
    data['countryCode'] = this.countryCode;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'countryName': this.countryName,
      'countryCode': this.countryCode,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      countryName: map['countryName'] as String,
      countryCode: map['countryCode'] as String
    );
  }
}
