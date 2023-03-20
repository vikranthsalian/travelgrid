class MetaNonEmployeeListResponse {
  bool? status;
  String? token;
  String? message;
  List<Data>? data;

  MetaNonEmployeeListResponse(
      {this.status, this.token, this.message, this.data});

  MetaNonEmployeeListResponse.fromJson(Map<String, dynamic> json) {
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
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? telephoneNumber;
  String? emergencyContactNo;
  String? mobileNumber;
  String? email;
  String? name;
  String? gender;
  String? paxType;
  bool? primaryTraveler;
  String? travelRequest;
  String? travelerProfile;
  bool? ticketBooked;

  Data(
      {this.id,
        this.telephoneNumber,
        this.emergencyContactNo,
        this.mobileNumber,
        this.email,
        this.name,
        this.gender,
        this.paxType,
        this.primaryTraveler,
        this.travelRequest,
        this.travelerProfile,
        this.ticketBooked});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    telephoneNumber = json['telephoneNumber'];
    emergencyContactNo = json['emergencyContactNo'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    name = json['name'];
    gender = json['gender'];
    paxType = json['paxType'];
    primaryTraveler = json['primaryTraveler'];
    travelRequest = json['travelRequest'];
    travelerProfile = json['travelerProfile'];
    ticketBooked = json['ticketBooked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['telephoneNumber'] = this.telephoneNumber;
    data['emergencyContactNo'] = this.emergencyContactNo;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['paxType'] = this.paxType;
    data['primaryTraveler'] = this.primaryTraveler;
    data['travelRequest'] = this.travelRequest;
    data['travelerProfile'] = this.travelerProfile;
    data['ticketBooked'] = this.ticketBooked;
    return data;
  }
}
