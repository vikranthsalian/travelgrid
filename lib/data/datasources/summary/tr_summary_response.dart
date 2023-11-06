class TRSummaryResponse {
  bool? status;
  String? token;
  String? message;
  Data? data;

  TRSummaryResponse({this.status, this.token, this.message, this.data});

  TRSummaryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] == "SUCCESS" ? true:false;
    token = json['token'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
}

class Data {
  int? id;
  String? tripNumber;
  String? employeeName;
  String? mobileNumber;
  String? emergencyMobileNumber;
  String? startDate;
  String? endDate;
  String? purposeOfTravel;
  String? purposeOfVisit;
  String? origin;
  String? destination;
  String? currentStatus;
  String? tripType;
  String? tripBillable;
  String? approver1;
  String? approver2;
  String? approver3;
  String? segmentType;
  String? voilationMessage;
  String? travelerName;
  String? tripPlan;
  Null? forexAdvance;
  String? comments;
  String? grade;
  MaRequesterDetails? maRequesterDetails;
  List<MaTravelerDetails>? maTravelerDetails;
  List<MaCityPairs>? maCityPairs;
  List<MaCashAdvance>? maCashAdvance;
  List<MaForexAdvance>? maForexAdvance;
  List<MaTravelVisas>? maTravelVisas;
  List<MaTravelInsurance>? maTravelInsurance;
  List<TravelComments>? travelComments;

  Data({this.id, this.tripNumber, this.employeeName, this.mobileNumber, this.emergencyMobileNumber, this.startDate, this.endDate, this.purposeOfTravel, this.purposeOfVisit, this.origin, this.destination, this.currentStatus, this.tripType, this.tripBillable, this.approver1, this.approver2, this.approver3, this.segmentType, this.voilationMessage, this.travelerName, this.tripPlan, this.forexAdvance, this.comments, this.grade, this.maRequesterDetails,
    this.maTravelerDetails,
    this.maCityPairs, this.maCashAdvance, this.maForexAdvance, this.maTravelVisas, this.maTravelInsurance, this.travelComments});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tripNumber = json['tripNumber'];
    employeeName = json['employeeName'];
    mobileNumber = json['mobileNumber'];
    emergencyMobileNumber = json['emergencyMobileNumber'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    purposeOfTravel = json['purposeOfTravel'];
    purposeOfVisit = json['purposeOfVisit'];
    origin = json['origin'];
    destination = json['destination'];
    currentStatus = json['currentStatus'];
    tripType = json['tripType'];
    tripBillable = json['tripBillable'];
    approver1 = json['approver1'];
    approver2 = json['approver2'];
    approver3 = json['approver3'];
    segmentType = json['segmentType'];
    voilationMessage = json['voilationMessage'];
    travelerName = json['travelerName'];
    tripPlan = json['tripPlan'];
    forexAdvance = json['forexAdvance'];
    comments = json['comments'];
    grade = json['grade'];
    maRequesterDetails = json['maRequesterDetails'] != null ? new MaRequesterDetails.fromJson(json['maRequesterDetails']) : null;
    if (json['maTravelerDetails'] != null) {
      maTravelerDetails = <MaTravelerDetails>[];
      json['maTravelerDetails'].forEach((v) { maTravelerDetails!.add(new MaTravelerDetails.fromJson(v)); });
    }
    if (json['maCityPairs'] != null) {
      maCityPairs = <MaCityPairs>[];
      json['maCityPairs'].forEach((v) { maCityPairs!.add(new MaCityPairs.fromJson(v)); });
    }
    if (json['maCashAdvance'] != null) {
      maCashAdvance = <MaCashAdvance>[];
      json['maCashAdvance'].forEach((v) { maCashAdvance!.add(new MaCashAdvance.fromJson(v)); });
    }
    if (json['maForexAdvance'] != null) {
      maForexAdvance = <MaForexAdvance>[];
      json['maForexAdvance'].forEach((v) { maForexAdvance!.add(new MaForexAdvance.fromJson(v)); });
    }
    if (json['maTravelVisas'] != null) {
      maTravelVisas = <MaTravelVisas>[];
      json['maTravelVisas'].forEach((v) { maTravelVisas!.add(new MaTravelVisas.fromJson(v)); });
    }
    if (json['maTravelInsurance'] != null) {
      maTravelInsurance = <MaTravelInsurance>[];
      json['maTravelInsurance'].forEach((v) { maTravelInsurance!.add(new MaTravelInsurance.fromJson(v)); });
    }
    if (json['travelComments'] != null) {
      travelComments = <TravelComments>[];
      json['travelComments'].forEach((v) { travelComments!.add(new TravelComments.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tripNumber'] = this.tripNumber;
    data['employeeName'] = this.employeeName;
    data['mobileNumber'] = this.mobileNumber;
    data['emergencyMobileNumber'] = this.emergencyMobileNumber;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['purposeOfTravel'] = this.purposeOfTravel;
    data['purposeOfVisit'] = this.purposeOfVisit;
    data['origin'] = this.origin;
    data['destination'] = this.destination;
    data['currentStatus'] = this.currentStatus;
    data['tripType'] = this.tripType;
    data['tripBillable'] = this.tripBillable;
    data['approver1'] = this.approver1;
    data['approver2'] = this.approver2;
    data['approver3'] = this.approver3;
    data['segmentType'] = this.segmentType;
    data['voilationMessage'] = this.voilationMessage;
    data['travelerName'] = this.travelerName;
    data['tripPlan'] = this.tripPlan;
    data['forexAdvance'] = this.forexAdvance;
    data['comments'] = this.comments;
    data['grade'] = this.grade;
    if (this.maRequesterDetails != null) {
      data['maRequesterDetails'] = this.maRequesterDetails!.toJson();
    }
    data['maTravelerDetails'] = this.maTravelerDetails;
    if (this.maTravelerDetails != null) {
      data['maTravelerDetails'] = this.maTravelerDetails!.map((v) => v.toJson()).toList();
    }
    if (this.maCityPairs != null) {
      data['maCityPairs'] = this.maCityPairs!.map((v) => v.toJson()).toList();
    }
    if (this.maCashAdvance != null) {
      data['maCashAdvance'] = this.maCashAdvance!.map((v) => v.toJson()).toList();
    }
    if (this.maForexAdvance != null) {
      data['maForexAdvance'] = this.maForexAdvance!.map((v) => v.toJson()).toList();
    }
    if (this.maTravelVisas != null) {
      data['maTravelVisas'] = this.maTravelVisas!.map((v) => v.toJson()).toList();
    }
    if (this.maTravelInsurance != null) {
      data['maTravelInsurance'] = this.maTravelInsurance!.map((v) => v.toJson()).toList();
    }
    if (this.travelComments != null) {
      data['travelComments'] = this.travelComments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class MaTravelerDetails {
  String? employeeCode;
  String? employeeName;
  String? employeeType;
  String? telephoneNumber;
  String? emergencyContactNo;
  String? mobileNumber;
  String? email;
  String? name;
  String? gender;
  String? costCenterName;
  String? organizationGrade;
  String? profitcenter;
  String? costcenter;
  String? divisionName;
  String? deptName;
  String? companyCode;
  String? location;
  bool? primary;

  MaTravelerDetails(
      {this.employeeCode,
        this.employeeName,
        this.employeeType,
        this.telephoneNumber,
        this.emergencyContactNo,
        this.mobileNumber,
        this.email,
        this.name,
        this.gender,
        this.costCenterName,
        this.organizationGrade,
        this.profitcenter,
        this.costcenter,
        this.divisionName,
        this.deptName,
        this.companyCode,
        this.primary,
        this.location});

  MaTravelerDetails.fromJson(Map<String, dynamic> json) {
    employeeCode = json['employeeCode'];
    employeeName = json['employeeName'];
    employeeType = json['employeeType'];
    telephoneNumber = json['telephoneNumber'];
    emergencyContactNo = json['emergencyContactNo'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    name = json['name'];
    gender = json['gender'];
    costCenterName = json['costCenterName'];
    organizationGrade = json['organizationGrade'];
    profitcenter = json['profitcenter'];
    costcenter = json['costcenter'];
    divisionName = json['divisionName'];
    deptName = json['deptName'];
    companyCode = json['companyCode'];
    location = json['location'];
    primary = json['primary'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeCode'] = this.employeeCode;
    data['employeeName'] = this.employeeName;
    data['employeeType'] = this.employeeType;
    data['telephoneNumber'] = this.telephoneNumber;
    data['emergencyContactNo'] = this.emergencyContactNo;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['costCenterName'] = this.costCenterName;
    data['organizationGrade'] = this.organizationGrade;
    data['profitcenter'] = this.profitcenter;
    data['costcenter'] = this.costcenter;
    data['divisionName'] = this.divisionName;
    data['deptName'] = this.deptName;
    data['companyCode'] = this.companyCode;
    data['location'] = this.location;
    data['primary'] = this.primary;
    return data;
  }
}



class MaRequesterDetails {
  Null? id;
  String? travelerName;
  String? employeeCode;
  String? requestType;
  String? grade;
  String? gender;
  String? division;
  String? department;
  String? costCenter;
  Null? email;
  bool? primaryTraveler;
  String? mobileNumber;
  String? emergencyMobileNumber;
  String? location;
  String? profitCenter;
  String? compCode;

  MaRequesterDetails({this.id, this.travelerName, this.employeeCode, this.requestType, this.grade, this.gender, this.division, this.department, this.costCenter, this.email, this.primaryTraveler, this.mobileNumber, this.emergencyMobileNumber, this.location, this.profitCenter, this.compCode});

  MaRequesterDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    travelerName = json['travelerName'];
    employeeCode = json['employeeCode'];
    requestType = json['requestType'];
    grade = json['grade'];
    gender = json['gender'];
    division = json['division'];
    department = json['department'];
    costCenter = json['costCenter'];
    email = json['email'];
    primaryTraveler = json['primaryTraveler'];
    mobileNumber = json['mobileNumber'];
    emergencyMobileNumber = json['emergencyMobileNumber'];
    location = json['location'];
    profitCenter = json['profitCenter'];
    compCode = json['compCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['travelerName'] = this.travelerName;
    data['employeeCode'] = this.employeeCode;
    data['requestType'] = this.requestType;
    data['grade'] = this.grade;
    data['gender'] = this.gender;
    data['division'] = this.division;
    data['department'] = this.department;
    data['costCenter'] = this.costCenter;
    data['email'] = this.email;
    data['primaryTraveler'] = this.primaryTraveler;
    data['mobileNumber'] = this.mobileNumber;
    data['emergencyMobileNumber'] = this.emergencyMobileNumber;
    data['location'] = this.location;
    data['profitCenter'] = this.profitCenter;
    data['compCode'] = this.compCode;
    return data;
  }
}

class MaCityPairs {
  int? id;
  LeavingFrom? leavingFrom;
  GoingTo? goingTo;
  String? startDate;
  String? startTime;
  ByCompany? byCompany;
  FareClass? fareClass;
  String? travelMode;
  String? pnr;
  double? price;
  String? ticketNo;
  String? arrivalDate;
  String? arrivalTime;
  String? flightNo;
  String? airlines;
  String? selectedFare;
  int? numberOfStops;
  bool? sbt;
  bool? booked;

  MaCityPairs({this.id,
    this.sbt,
    this.selectedFare,
    this.numberOfStops,
    this.leavingFrom, this.goingTo, this.startDate, this.startTime, this.byCompany, this.fareClass, this.travelMode, this.pnr, this.price, this.ticketNo, this.arrivalDate, this.arrivalTime, this.flightNo, this.airlines, this.booked});

  MaCityPairs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leavingFrom = json['leavingFrom'] != null ? new LeavingFrom.fromJson(json['leavingFrom']) : null;
    goingTo = json['goingTo'] != null ? new GoingTo.fromJson(json['goingTo']) : null;
    startDate = json['startDate'];
    startTime = json['startTime'];
    byCompany = json['byCompany'] != null ? new ByCompany.fromJson(json['byCompany']) : null;
    fareClass = json['fareClass'] != null ? new FareClass.fromJson(json['fareClass']) : null;
    travelMode = json['travelMode'];
    pnr = json['pnr'];
    price = json['price'];
    ticketNo = json['ticketNo'];
    arrivalDate = json['arrivalDate'];
    arrivalTime = json['arrivalTime'];
    flightNo = json['flightNo'];
    airlines = json['airlines'];
    selectedFare = json['selectedFare'];
    numberOfStops = json['numberOfStops'] ?? 0;
    sbt = json['sbt'] ?? false;
    booked = json['booked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.leavingFrom != null) {
      data['leavingFrom'] = this.leavingFrom!.toJson();
    }
    if (this.goingTo != null) {
      data['goingTo'] = this.goingTo!.toJson();
    }
    data['startDate'] = this.startDate;
    data['startTime'] = this.startTime;
    if (this.byCompany != null) {
      data['byCompany'] = this.byCompany!.toJson();
    }
    if (this.fareClass != null) {
      data['fareClass'] = this.fareClass!.toJson();
    }
    data['travelMode'] = this.travelMode;
    data['pnr'] = this.pnr;
    data['price'] = this.price;
    data['ticketNo'] = this.ticketNo;
    data['arrivalDate'] = this.arrivalDate;
    data['arrivalTime'] = this.arrivalTime;
    data['flightNo'] = this.flightNo;
    data['airlines'] = this.airlines;
    data['booked'] = this.booked;
    data['selectedFare'] = this.selectedFare;
    data['numberOfStops'] = this.numberOfStops;
    data['sbt'] = this.sbt;
    return data;
  }
}

class LeavingFrom {
  int? id;
  String? name;
  String? locationName;
  bool? enabled;
  String? cityCode;
  String? cityClass;
  SState? state;

  LeavingFrom({this.id, this.name, this.locationName, this.enabled, this.cityCode, this.cityClass, this.state});

  LeavingFrom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    locationName = json['locationName'];
    enabled = json['enabled'];
    cityCode = json['cityCode'];
    cityClass = json['cityClass'];
    state = json['state'] != null ? new SState.fromJson(json['state']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['locationName'] = this.locationName;
    data['enabled'] = this.enabled;
    data['cityCode'] = this.cityCode;
    data['cityClass'] = this.cityClass;
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    return data;
  }
}

class SState {
  int? id;
  String? name;
  String? printableName;
  String? iso;
  Null? iso3;
  bool? enabled;
  Country? country;

  SState({this.id, this.name, this.printableName, this.iso, this.iso3, this.enabled, this.country});

  SState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    printableName = json['printableName'];
    iso = json['iso'];
    iso3 = json['iso3'];
    enabled = json['enabled'];
    country = json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['printableName'] = this.printableName;
    data['iso'] = this.iso;
    data['iso3'] = this.iso3;
    data['enabled'] = this.enabled;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    return data;
  }
}

class Country {
  int? id;
  String? iso;
  String? name;
  String? printableName;
  String? iso3;
  String? currency;
  bool? enabled;
  String? countryClass;

  Country({this.id, this.iso, this.name, this.printableName, this.iso3, this.currency, this.enabled, this.countryClass});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iso = json['iso'];
    name = json['name'];
    printableName = json['printableName'];
    iso3 = json['iso3'];
    currency = json['currency'];
    enabled = json['enabled'];
    countryClass = json['countryClass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iso'] = this.iso;
    data['name'] = this.name;
    data['printableName'] = this.printableName;
    data['iso3'] = this.iso3;
    data['currency'] = this.currency;
    data['enabled'] = this.enabled;
    data['countryClass'] = this.countryClass;
    return data;
  }
}

class GoingTo {
  int? id;
  String? name;
  String? locationName;
  bool? enabled;
  String? cityCode;
  String? cityClass;
  SState? state;

  GoingTo({this.id, this.name, this.locationName, this.enabled, this.cityCode, this.cityClass, this.state});

  GoingTo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    locationName = json['locationName'];
    enabled = json['enabled'];
    cityCode = json['cityCode'];
    cityClass = json['cityClass'];
    state = json['state'] != null ? new SState.fromJson(json['state']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['locationName'] = this.locationName;
    data['enabled'] = this.enabled;
    data['cityCode'] = this.cityCode;
    data['cityClass'] = this.cityClass;
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    return data;
  }
}

class ByCompany {
  int? id;
  String? value;
  bool? disabled;
  bool? deleted;
  I18nTextName? i18nTextName;
  String? label;

  ByCompany({this.id, this.value, this.disabled, this.deleted, this.i18nTextName, this.label});

  ByCompany.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    disabled = json['disabled'];
    deleted = json['deleted'];
    i18nTextName = json['i18nTextName'] != null ? new I18nTextName.fromJson(json['i18nTextName']) : null;
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['disabled'] = this.disabled;
    data['deleted'] = this.deleted;
    if (this.i18nTextName != null) {
      data['i18nTextName'] = this.i18nTextName!.toJson();
    }
    data['label'] = this.label;
    return data;
  }
}

class FareClass {
  int? id;
  String? value;
  bool? disabled;
  bool? deleted;
  I18nTextName? i18nTextName;
  String? label;

  FareClass({this.id, this.value, this.disabled, this.deleted, this.i18nTextName, this.label});

  FareClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    disabled = json['disabled'];
    deleted = json['deleted'];
    i18nTextName = json['i18nTextName'] != null ? new I18nTextName.fromJson(json['i18nTextName']) : null;
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['disabled'] = this.disabled;
    data['deleted'] = this.deleted;
    if (this.i18nTextName != null) {
      data['i18nTextName'] = this.i18nTextName!.toJson();
    }
    data['label'] = this.label;
    return data;
  }
}

class I18nTextName {
  String? defaultText;
  String? text;

  I18nTextName({ this.defaultText, this.text});

  I18nTextName.fromJson(Map<String, dynamic> json) {
    defaultText = json['defaultText'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['defaultText'] = this.defaultText;
    data['text'] = this.text;
    return data;
  }
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
return data;
}


class MaCashAdvance {
int? totalCashAmount;
String? violation;
String? currentStatus;

MaCashAdvance({this.totalCashAmount, this.violation, this.currentStatus});

MaCashAdvance.fromJson(Map<String, dynamic> json) {
totalCashAmount = json['totalCashAmount'];
violation = json['violation'];
currentStatus = json['currentStatus'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['totalCashAmount'] = this.totalCashAmount;
data['violation'] = this.violation;
data['currentStatus'] = this.currentStatus;
return data;
}
}

class MaForexAdvance {
int? totalForexAmount;
int? cash;
int? card;
String? currency;
String? address;
String? violationMessage;

MaForexAdvance({this.totalForexAmount, this.cash, this.card, this.currency, this.address, this.violationMessage});

MaForexAdvance.fromJson(Map<String, dynamic> json) {
totalForexAmount = json['totalForexAmount'];
cash = json['cash'];
card = json['card'];
currency = json['currency'];
address = json['address'];
violationMessage = json['violationMessage'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['totalForexAmount'] = this.totalForexAmount;
data['cash'] = this.cash;
data['card'] = this.card;
data['currency'] = this.currency;
data['address'] = this.address;
data['violationMessage'] = this.violationMessage;
return data;
}
}

class MaTravelVisas {
int? serviceType;
String? visitingCountry;
int? durationOfStay;
String? visaRequirement;
String? numberOfEntries;
String? visaType;

MaTravelVisas({this.serviceType, this.visitingCountry, this.durationOfStay, this.visaRequirement, this.numberOfEntries, this.visaType});

MaTravelVisas.fromJson(Map<String, dynamic> json) {
serviceType = json['serviceType'];
visitingCountry = json['visitingCountry'];
durationOfStay = json['durationOfStay'];
visaRequirement = json['visaRequirement'];
numberOfEntries = json['numberOfEntries'];
visaType = json['visaType'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['serviceType'] = this.serviceType;
data['visitingCountry'] = this.visitingCountry;
data['durationOfStay'] = this.durationOfStay;
data['visaRequirement'] = this.visaRequirement;
data['numberOfEntries'] = this.numberOfEntries;
data['visaType'] = this.visaType;
return data;
}
}

class MaTravelInsurance {
int? serviceType;
String? visitingCountry;
int? durationOfStay;
String? insuranceRequirement;

MaTravelInsurance({this.serviceType, this.visitingCountry, this.durationOfStay, this.insuranceRequirement});

MaTravelInsurance.fromJson(Map<String, dynamic> json) {
serviceType = json['serviceType'];
visitingCountry = json['visitingCountry'];
durationOfStay = json['durationOfStay'];
insuranceRequirement = json['insuranceRequirement'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['serviceType'] = this.serviceType;
data['visitingCountry'] = this.visitingCountry;
data['durationOfStay'] = this.durationOfStay;
data['insuranceRequirement'] = this.insuranceRequirement;
return data;
}
}

class TravelComments {
String? comments;
String? action;
String? actionForm;
String? actionBy;
String? actionOn;

TravelComments({this.comments, this.action, this.actionForm, this.actionBy, this.actionOn});

TravelComments.fromJson(Map<String, dynamic> json) {
comments = json['comments'];
action = json['action'];
actionForm = json['actionForm'];
actionBy = json['actionBy'];
actionOn = json['actionOn'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['comments'] = this.comments;
data['action'] = this.action;
data['actionForm'] = this.actionForm;
data['actionBy'] = this.actionBy;
data['actionOn'] = this.actionOn;
return data;
}
}

