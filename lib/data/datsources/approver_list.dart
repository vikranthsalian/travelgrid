class MetaApproverListResponse {
  bool? status;
  String? token;
  String? message;
  List<Data>? data;

  MetaApproverListResponse({this.status, this.token, this.message, this.data});

  MetaApproverListResponse.fromJson(Map<String, dynamic> json) {
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
  String? approverCode;
  String? approverName;

  Data(
      {this.approverCode,
        this.approverName});

  Data.fromJson(Map<String, dynamic> json) {
    approverCode = json['approverCode'];
    approverName = json['approverName'];;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['approverCode'] = this.approverCode;
    data['approverName'] = this.approverName;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'approverCode': this.approverCode,
      'approverName': this.approverName,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      approverCode: map['approverCode'] as String,
      approverName: map['approverName'] as String,
    );
  }
}
