class SuccessModel {
  bool? status;
  String? token;
  String? message;
  String? data;

  SuccessModel({this.status, this.token, this.message, this.data});

  SuccessModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] == "SUCCESS" ? true:false;
    token = json['token'];
    message = json['message'];
    data = json['data'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }


}
