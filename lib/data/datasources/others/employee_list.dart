class MetaEmployeeListResponse {
  bool? status;
  String? token;
  String? message;
  List<Data>? data;

  MetaEmployeeListResponse({this.status, this.token, this.message, this.data});

  MetaEmployeeListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] == "SUCCESS" ? true:false;
    token = json['token'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) { data!.add(new Data.fromJson(v)); });
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
  String? recordLocator;
  String? gender;
  // Null? maritalStatus;
  // Null? prefix;
  // String? given;
  // String? family;
  // Null? suffix;
  // Null? nickName;
  // String? fatherName;
  // Null? dateOfbirth;
  // Null? language;
  String? fullName;
  String? employeecode;
  PermanentContact? permanentContact;
  CurrentContact? currentContact;
 // Account? account;

  // int? employeeTypeId;
  // Null? externalId;
  // String? profitcenter;
  // Null? dateOfJoining;
  // Company? company;
  // CostCenter? costCenter;
  // Worklocation? worklocation;
  // Grade? grade;
  // Subgrade? subgrade;
  // String? deptCode;
  // String? deptName;
  // String? divisionCode;
  // String? divName;
  // Null? position;
  // Null? positionName;
  // Null? empVendorCode;
  // String? jobtext;
  // Null? uniqueIdentificationNumber;
  // Null? airSeatPreference;
  // Null? mealPreference;
  // Null? visa;
  // Null? travelDocs;
  // Null? frequentFlyer;
  // TravelVendor? travelVendor;

  Data({this.id, this.recordLocator,
    this.fullName, this.employeecode,
    this.permanentContact, this.currentContact,

     this.gender,
    // this.maritalStatus, this.prefix, this.given, this.family, this.suffix, this.nickName, this.fatherName, this.dateOfbirth,
    // this.language, this.account,this.employeeTypeId, this.externalId, this.profitcenter, this.dateOfJoining, this.company, this.costCenter,
    // this.worklocation, this.grade, this.subgrade, this.deptCode, this.deptName, this.divisionCode, this.divName, this.position,
    // this.positionName, this.empVendorCode, this.jobtext, this.uniqueIdentificationNumber, this.airSeatPreference, this.mealPreference,
    // this.visa, this.travelDocs, this.frequentFlyer, this.travelVendor
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recordLocator = json['recordLocator'];
    fullName = json['fullName'];
    employeecode = json['employeecode'];
    permanentContact = json['permanentContact'] != null ? new PermanentContact.fromJson(json['permanentContact']) : null;
    currentContact = json['currentContact'] != null ? new CurrentContact.fromJson(json['currentContact']) : null;
     gender = json['gender'];
    // maritalStatus = json['maritalStatus'];
    // prefix = json['prefix'];
    // given = json['given'];
    // family = json['family'];
    // suffix = json['suffix'];
    // nickName = json['nickName'];
    // fatherName = json['fatherName'];
    // dateOfbirth = json['dateOfbirth'];
    // language = json['language'];
    //
    // account = json['account'] != null ? new Account.fromJson(json['account']) : null;
    //
    // employeeTypeId = json['employeeTypeId'];
    // externalId = json['externalId'];
    // profitcenter = json['profitcenter'];
    // dateOfJoining = json['dateOfJoining'];
    // company = json['company'] != null ? new Company.fromJson(json['company']) : null;
    // costCenter = json['costCenter'] != null ? new CostCenter.fromJson(json['costCenter']) : null;
    // worklocation = json['worklocation'] != null ? new Worklocation.fromJson(json['worklocation']) : null;
    // grade = json['grade'] != null ? new Grade.fromJson(json['grade']) : null;
    // subgrade = json['subgrade'] != null ? new Subgrade.fromJson(json['subgrade']) : null;
    // deptCode = json['deptCode'];
    // deptName = json['deptName'];
    // divisionCode = json['divisionCode'];
    // divName = json['divName'];
    // position = json['position'];
    // positionName = json['positionName'];
    // empVendorCode = json['empVendorCode'];
    // jobtext = json['jobtext'];
    // uniqueIdentificationNumber = json['uniqueIdentificationNumber'];
    // airSeatPreference = json['airSeatPreference'];
    // mealPreference = json['mealPreference'];
    // visa = json['visa'];
    // travelDocs = json['travelDocs'];
    // frequentFlyer = json['frequentFlyer'];
    // travelVendor = json['travelVendor'] != null ? new TravelVendor.fromJson(json['travelVendor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['recordLocator'] = this.recordLocator;
    data['fullName'] = this.fullName;
    data['employeecode'] = this.employeecode;
    if (this.permanentContact != null) {
      data['permanentContact'] = this.permanentContact!.toJson();
    }
    if (this.currentContact != null) {
      data['currentContact'] = this.currentContact!.toJson();
    }



    data['gender'] = this.gender;
    // data['maritalStatus'] = this.maritalStatus;
    // data['prefix'] = this.prefix;
    // data['given'] = this.given;
    // data['family'] = this.family;
    // data['suffix'] = this.suffix;
    // data['nickName'] = this.nickName;
    // data['fatherName'] = this.fatherName;
    // data['dateOfbirth'] = this.dateOfbirth;
    // data['language'] = this.language;
    //
    // if (this.account != null) {
    //   data['account'] = this.account!.toJson();
    // }
    //
    // data['employeeTypeId'] = this.employeeTypeId;
    // data['externalId'] = this.externalId;
    // data['profitcenter'] = this.profitcenter;
    // data['dateOfJoining'] = this.dateOfJoining;
    // if (this.company != null) {
    //   data['company'] = this.company!.toJson();
    // }
    // if (this.costCenter != null) {
    //   data['costCenter'] = this.costCenter!.toJson();
    // }
    // if (this.worklocation != null) {
    //   data['worklocation'] = this.worklocation!.toJson();
    // }
    // if (this.grade != null) {
    //   data['grade'] = this.grade!.toJson();
    // }
    // if (this.subgrade != null) {
    //   data['subgrade'] = this.subgrade!.toJson();
    // }
    // data['deptCode'] = this.deptCode;
    // data['deptName'] = this.deptName;
    // data['divisionCode'] = this.divisionCode;
    // data['divName'] = this.divName;
    // data['position'] = this.position;
    // data['positionName'] = this.positionName;
    // data['empVendorCode'] = this.empVendorCode;
    // data['jobtext'] = this.jobtext;
    // data['uniqueIdentificationNumber'] = this.uniqueIdentificationNumber;
    // data['airSeatPreference'] = this.airSeatPreference;
    // data['mealPreference'] = this.mealPreference;
    // data['visa'] = this.visa;
    // data['travelDocs'] = this.travelDocs;
    // data['frequentFlyer'] = this.frequentFlyer;
    // if (this.travelVendor != null) {
    //   data['travelVendor'] = this.travelVendor!.toJson();
    // }
    return data;
  }
}

class PermanentContact {
  int? id;
  String? email;
  Null? addressLine1;
  Null? addressLine2;
  Null? location;
  String? mobile;
  String? telephoneNo;

  PermanentContact({this.id, this.email, this.addressLine1, this.addressLine2, this.location, this.mobile, this.telephoneNo});

  PermanentContact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    location = json['location'];
    mobile = json['mobile'];
    telephoneNo = json['telephoneNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['location'] = this.location;
    data['mobile'] = this.mobile;
    data['telephoneNo'] = this.telephoneNo;
    return data;
  }
}

class CurrentContact {
  int? id;
  String? email;
  String? addressLine1;
  String? addressLine2;
  Location? location;
  String? mobile;
  String? telephoneNo;

  CurrentContact({this.id, this.email, this.addressLine1, this.addressLine2, this.location, this.mobile, this.telephoneNo});

  CurrentContact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    location = json['location'] != null ? new Location.fromJson(json['location']) : null;
    mobile = json['mobile'];
    telephoneNo = json['telephoneNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['mobile'] = this.mobile;
    data['telephoneNo'] = this.telephoneNo;
    return data;
  }
}

class Location {
  String? city;
  Null? district;
  String? stateprov;
  String? postalCode;
  String? countryName;
  String? countryCode;
  Null? geolocation;

  Location({this.city, this.district, this.stateprov, this.postalCode, this.countryName, this.countryCode, this.geolocation});

  Location.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    district = json['district'];
    stateprov = json['stateprov'];
    postalCode = json['postalCode'];
    countryName = json['countryName'];
    countryCode = json['countryCode'];
    geolocation = json['geolocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['district'] = this.district;
    data['stateprov'] = this.stateprov;
    data['postalCode'] = this.postalCode;
    data['countryName'] = this.countryName;
    data['countryCode'] = this.countryCode;
    data['geolocation'] = this.geolocation;
    return data;
  }
}




