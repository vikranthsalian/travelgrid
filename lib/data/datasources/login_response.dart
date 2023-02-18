class MetaLoginResponse {
  bool? status;
  String? token;
  String? message;
  Data? data;

  MetaLoginResponse({this.status, this.token, this.message, this.data});

  MetaLoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] =="SUCCESS" ? true:false;
    token = json['token'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'data': this.data,
    };
  }

  factory MetaLoginResponse.fromMap(Map<String, dynamic> map) {
    return MetaLoginResponse(
      data: map['data'] as Data,
    );
  }
}

class Data {
  int? id;
  String? recordLocator;
  String? gender;
  Null? maritalStatus;
  Null? prefix;
  String? given;
  String? family;
  Null? suffix;
  Null? nickName;
  String? fatherName;
  Null? dateOfbirth;
  Null? language;
  Null? permanentContact;
  CurrentContact? currentContact;
  Account? account;
  String? fullName;
  String? employeecode;
  int? employeeTypeId;
  Null? externalId;
  String? profitcenter;
  Null? dateOfJoining;
  Company? company;
  CostCenter? costCenter;
  Worklocation? worklocation;
  Grade? grade;
  SubGrade? Subgrade;
  String? deptCode;
  String? deptName;
  String? divisionCode;
  String? divName;
  Null? position;
  Null? positionName;
  Null? empVendorCode;
  String? jobtext;
  Null? uniqueIdentificationNumber;
  Null? airSeatPreference;
  Null? mealPreference;
  Null? visa;
  Null? travelDocs;
  Null? frequentFlyer;
  Null? travelVendor;

  Data({this.id, this.recordLocator, this.gender, this.maritalStatus, this.prefix, this.given, this.family, this.suffix, this.nickName, this.fatherName, this.dateOfbirth, this.language, this.permanentContact, this.currentContact, this.account, this.fullName, this.employeecode, this.employeeTypeId, this.externalId, this.profitcenter, this.dateOfJoining, this.company, this.costCenter, this.worklocation, this.grade, this.Subgrade, this.deptCode, this.deptName, this.divisionCode, this.divName, this.position, this.positionName, this.empVendorCode, this.jobtext, this.uniqueIdentificationNumber, this.airSeatPreference, this.mealPreference, this.visa, this.travelDocs, this.frequentFlyer, this.travelVendor});


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recordLocator = json['recordLocator'];
    gender = json['gender'];
    maritalStatus = json['maritalStatus'];
    prefix = json['prefix'];
    given = json['given'];
    family = json['family'];
    suffix = json['suffix'];
    nickName = json['nickName'];
    fatherName = json['fatherName'];
    dateOfbirth = json['dateOfbirth'];
    language = json['language'];
    permanentContact = json['permanentContact'];
    currentContact = json['currentContact'] != null ? new CurrentContact.fromJson(json['currentContact']) : null;
    account = json['account'] != null ? new Account.fromJson(json['account']) : null;
    fullName = json['fullName'];
    employeecode = json['employeecode'];
    employeeTypeId = json['employeeTypeId'];
    externalId = json['externalId'];
    profitcenter = json['profitcenter'];
    dateOfJoining = json['dateOfJoining'];
    company = json['company'] != null ? new Company.fromJson(json['company']) : null;
    costCenter = json['costCenter'] != null ? new CostCenter.fromJson(json['costCenter']) : null;
    worklocation = json['worklocation'] != null ? new Worklocation.fromJson(json['worklocation']) : null;
    grade = json['grade'] != null ? new Grade.fromJson(json['grade']) : null;
    Subgrade = json['SubGrade'] != null ? new SubGrade.fromJson(json['SubGrade']) : null;
    deptCode = json['deptCode'];
    deptName = json['deptName'];
    divisionCode = json['divisionCode'];
    divName = json['divName'];
    position = json['position'];
    positionName = json['positionName'];
    empVendorCode = json['empVendorCode'];
    jobtext = json['jobtext'];
    uniqueIdentificationNumber = json['uniqueIdentificationNumber'];
    airSeatPreference = json['airSeatPreference'];
    mealPreference = json['mealPreference'];
    visa = json['visa'];
    travelDocs = json['travelDocs'];
    frequentFlyer = json['frequentFlyer'];
    travelVendor = json['travelVendor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['recordLocator'] = this.recordLocator;
    data['gender'] = this.gender;
    data['maritalStatus'] = this.maritalStatus;
    data['prefix'] = this.prefix;
    data['given'] = this.given;
    data['family'] = this.family;
    data['suffix'] = this.suffix;
    data['nickName'] = this.nickName;
    data['fatherName'] = this.fatherName;
    data['dateOfbirth'] = this.dateOfbirth;
    data['language'] = this.language;
    data['permanentContact'] = this.permanentContact;
    if (this.currentContact != null) {
      data['currentContact'] = this.currentContact!.toJson();
    }
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    data['fullName'] = this.fullName;
    data['employeecode'] = this.employeecode;
    data['employeeTypeId'] = this.employeeTypeId;
    data['externalId'] = this.externalId;
    data['profitcenter'] = this.profitcenter;
    data['dateOfJoining'] = this.dateOfJoining;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    if (this.costCenter != null) {
      data['costCenter'] = this.costCenter!.toJson();
    }
    if (this.worklocation != null) {
      data['worklocation'] = this.worklocation!.toJson();
    }
    if (this.grade != null) {
      data['grade'] = this.grade!.toJson();
    }
    if (this.Subgrade != null) {
      data['SubGrade'] = this.Subgrade!.toJson();
    }
    data['deptCode'] = this.deptCode;
    data['deptName'] = this.deptName;
    data['divisionCode'] = this.divisionCode;
    data['divName'] = this.divName;
    data['position'] = this.position;
    data['positionName'] = this.positionName;
    data['empVendorCode'] = this.empVendorCode;
    data['jobtext'] = this.jobtext;
    data['uniqueIdentificationNumber'] = this.uniqueIdentificationNumber;
    data['airSeatPreference'] = this.airSeatPreference;
    data['mealPreference'] = this.mealPreference;
    data['visa'] = this.visa;
    data['travelDocs'] = this.travelDocs;
    data['frequentFlyer'] = this.frequentFlyer;
    data['travelVendor'] = this.travelVendor;
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
  Null? telephoneNo;

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

class Account {
  int? id;
  String? loginId;
  bool? active;
  bool? locked;
  bool? agreedTerms;
  bool? expired;
  bool? hidden;
  int? failedLogins;
  String? lastfailedLoginOn;
  String? lastLoginOn;
  Null? password;
  Null? confirmPassword;
  bool? reset;
  Null? authorities;
  String? accessToken;
  String? accessTokenExpiryDate;
  Null? deviceRegistrationId;
  String? domain;

  Account({this.id, this.loginId, this.active, this.locked, this.agreedTerms, this.expired, this.hidden, this.failedLogins, this.lastfailedLoginOn, this.lastLoginOn, this.password, this.confirmPassword, this.reset, this.authorities, this.accessToken, this.accessTokenExpiryDate, this.deviceRegistrationId, this.domain});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loginId = json['loginId'];
    active = json['active'];
    locked = json['locked'];
    agreedTerms = json['agreedTerms'];
    expired = json['expired'];
    hidden = json['hidden'];
    failedLogins = json['failedLogins'];
    lastfailedLoginOn = json['lastfailedLoginOn'];
    lastLoginOn = json['lastLoginOn'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    reset = json['reset'];
    authorities = json['authorities'];
    accessToken = json['accessToken'];
    accessTokenExpiryDate = json['accessTokenExpiryDate'];
    deviceRegistrationId = json['deviceRegistrationId'];
    domain = json['domain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loginId'] = this.loginId;
    data['active'] = this.active;
    data['locked'] = this.locked;
    data['agreedTerms'] = this.agreedTerms;
    data['expired'] = this.expired;
    data['hidden'] = this.hidden;
    data['failedLogins'] = this.failedLogins;
    data['lastfailedLoginOn'] = this.lastfailedLoginOn;
    data['lastLoginOn'] = this.lastLoginOn;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    data['reset'] = this.reset;
    data['authorities'] = this.authorities;
    data['accessToken'] = this.accessToken;
    data['accessTokenExpiryDate'] = this.accessTokenExpiryDate;
    data['deviceRegistrationId'] = this.deviceRegistrationId;
    data['domain'] = this.domain;
    return data;
  }
}

class Company {
  int? id;
  String? companyName;
  String? companyCode;
  Enterprise? enterprise;
  bool? selected;

  Company({this.id, this.companyName, this.companyCode, this.enterprise, this.selected});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    companyCode = json['companyCode'];
    enterprise = json['enterprise'] != null ? new Enterprise.fromJson(json['enterprise']) : null;
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyName'] = this.companyName;
    data['companyCode'] = this.companyCode;
    if (this.enterprise != null) {
      data['enterprise'] = this.enterprise!.toJson();
    }
    data['selected'] = this.selected;
    return data;
  }
}

class Enterprise {
  int? id;
  String? name;
  String? shortname;
  Null? contact;
  Null? email;
  License? license;
  String? domain;

  Enterprise({this.id, this.name, this.shortname, this.contact, this.email, this.license, this.domain});

  Enterprise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortname = json['shortname'];
    contact = json['contact'];
    email = json['email'];
    license = json['license'] != null ? new License.fromJson(json['license']) : null;
    domain = json['domain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shortname'] = this.shortname;
    data['contact'] = this.contact;
    data['email'] = this.email;
    if (this.license != null) {
      data['license'] = this.license!.toJson();
    }
    data['domain'] = this.domain;
    return data;
  }
}

class License {
  int? id;
  bool? configured;
  bool? agreedTerms;
  String? domain;
  String? domainOne;
  String? domainTwo;
  bool? valid;
  Null? validupto;
  Null? licenseType;
  Null? client;
  Null? shortName;
  Null? agreementNo;
  Null? agreementDate;
  int? users;
  Null? terms;
  ContentsAsStream? contentsAsStream;

  License({this.id, this.configured, this.agreedTerms, this.domain, this.domainOne, this.domainTwo, this.valid, this.validupto, this.licenseType, this.client, this.shortName, this.agreementNo, this.agreementDate, this.users, this.terms, this.contentsAsStream});

  License.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    configured = json['configured'];
    agreedTerms = json['agreedTerms'];
    domain = json['domain'];
    domainOne = json['domainOne'];
    domainTwo = json['domainTwo'];
    valid = json['valid'];
    validupto = json['validupto'];
    licenseType = json['licenseType'];
    client = json['client'];
    shortName = json['shortName'];
    agreementNo = json['agreementNo'];
    agreementDate = json['agreementDate'];
    users = json['users'];
    terms = json['terms'];
    contentsAsStream = json['contentsAsStream'] != null ? new ContentsAsStream.fromJson(json['contentsAsStream']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['configured'] = this.configured;
    data['agreedTerms'] = this.agreedTerms;
    data['domain'] = this.domain;
    data['domainOne'] = this.domainOne;
    data['domainTwo'] = this.domainTwo;
    data['valid'] = this.valid;
    data['validupto'] = this.validupto;
    data['licenseType'] = this.licenseType;
    data['client'] = this.client;
    data['shortName'] = this.shortName;
    data['agreementNo'] = this.agreementNo;
    data['agreementDate'] = this.agreementDate;
    data['users'] = this.users;
    data['terms'] = this.terms;
    if (this.contentsAsStream != null) {
      data['contentsAsStream'] = this.contentsAsStream!.toJson();
    }
    return data;
  }
}

class ContentsAsStream {


  ContentsAsStream();

ContentsAsStream.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}

class CostCenter {
  int? id;
  String? costcenterName;
  String? costcenter;
  Company? company;

  CostCenter({this.id, this.costcenterName, this.costcenter, this.company});

  CostCenter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    costcenterName = json['costcenterName'];
    costcenter = json['costcenter'];
    company = json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['costcenterName'] = this.costcenterName;
    data['costcenter'] = this.costcenter;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class Worklocation {
  int? id;
  String? locationCode;
  String? locationName;
  Null? locale;
  Null? timeZone;
  Enterprise? enterprise;
  bool? selected;

  Worklocation({this.id, this.locationCode, this.locationName, this.locale, this.timeZone, this.enterprise, this.selected});

  Worklocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationCode = json['locationCode'];
    locationName = json['locationName'];
    locale = json['locale'];
    timeZone = json['timeZone'];
    enterprise = json['enterprise'] != null ? new Enterprise.fromJson(json['enterprise']) : null;
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['locationCode'] = this.locationCode;
    data['locationName'] = this.locationName;
    data['locale'] = this.locale;
    data['timeZone'] = this.timeZone;
    if (this.enterprise != null) {
      data['enterprise'] = this.enterprise!.toJson();
    }
    data['selected'] = this.selected;
    return data;
  }
}

class Grade {
  int? id;
  Company? companyId;
  String? organizationGrade;
  String? organizationGradeName;

  Grade({this.id, this.companyId, this.organizationGrade, this.organizationGradeName});

  Grade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['companyId'] != null ? new Company.fromJson(json['companyId']) : null;
    organizationGrade = json['organizationGrade'];
    organizationGradeName = json['organizationGradeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.companyId != null) {
      data['companyId'] = this.companyId!.toJson();
    }
    data['organizationGrade'] = this.organizationGrade;
    data['organizationGradeName'] = this.organizationGradeName;
    return data;
  }
}

class SubGrade {
  int? id;
  Company? company;
  String? organizationSubGradeName;
  String? organizationGrade;

  SubGrade({this.id, this.company, this.organizationSubGradeName, this.organizationGrade});

  SubGrade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company = json['company'] != null ? new Company.fromJson(json['company']) : null;
    organizationSubGradeName = json['organizationSubGradeName'];
    organizationGrade = json['organizationGrade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['organizationSubGradeName'] = this.organizationSubGradeName;
    data['organizationGrade'] = this.organizationGrade;
    return data;
  }
}
