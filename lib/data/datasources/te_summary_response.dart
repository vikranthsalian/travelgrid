class TESummaryResponse {
  bool? status;
  String? token;
  String? message;
  Data? data;

  TESummaryResponse({this.status, this.token, this.message, this.data});

  TESummaryResponse.fromJson(Map<String, dynamic> json) {
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
  String? recordLocator;
  String? currentStatus;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  MaTravelRequest? maTravelRequest;
  List<ExpenseVisitDetails>? expenseVisitDetails;
  List<Null>? ticketExpenses;
  List<Null>? accommodationExpenses;
  List<Null>? conveyanceExpenses;
  List<Null>? miscellaneousExpenses;
  List<Null>? cashAdvances;
  List<Null>? dailyAllowances;
  List<Null>? matravelExpenseComment;
  MaExpenseSummary? maExpenseSummary;

  Data({this.id, this.recordLocator, this.currentStatus, this.startDate, this.startTime, this.endDate, this.endTime, this.maTravelRequest, this.expenseVisitDetails, this.ticketExpenses, this.accommodationExpenses, this.conveyanceExpenses, this.miscellaneousExpenses, this.cashAdvances, this.dailyAllowances, this.matravelExpenseComment, this.maExpenseSummary});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recordLocator = json['recordLocator'];
    currentStatus = json['currentStatus'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    endDate = json['endDate'];
    endTime = json['endTime'];
    maTravelRequest = json['maTravelRequest'] != null ? new MaTravelRequest.fromJson(json['maTravelRequest']) : null;
    if (json['expenseVisitDetails'] != null) {
      expenseVisitDetails = <ExpenseVisitDetails>[];
      json['expenseVisitDetails'].forEach((v) { expenseVisitDetails!.add(new ExpenseVisitDetails.fromJson(v)); });
    }
    // if (json['ticketExpenses'] != null) {
    //   ticketExpenses = <Null>[];
    //   json['ticketExpenses'].forEach((v) { ticketExpenses!.add(new Null.fromJson(v)); });
    // }
    // if (json['accommodationExpenses'] != null) {
    //   accommodationExpenses = <Null>[];
    //   json['accommodationExpenses'].forEach((v) { accommodationExpenses!.add(new Null.fromJson(v)); });
    // }
    // if (json['conveyanceExpenses'] != null) {
    //   conveyanceExpenses = <Null>[];
    //   json['conveyanceExpenses'].forEach((v) { conveyanceExpenses!.add(new Null.fromJson(v)); });
    // }
    // if (json['miscellaneousExpenses'] != null) {
    //   miscellaneousExpenses = <Null>[];
    //   json['miscellaneousExpenses'].forEach((v) { miscellaneousExpenses!.add(new Null.fromJson(v)); });
    // }
    // if (json['cashAdvances'] != null) {
    //   cashAdvances = <Null>[];
    //   json['cashAdvances'].forEach((v) { cashAdvances!.add(new Null.fromJson(v)); });
    // }
    // if (json['dailyAllowances'] != null) {
    //   dailyAllowances = <Null>[];
    //   json['dailyAllowances'].forEach((v) { dailyAllowances!.add(new Null.fromJson(v)); });
    // }
    // if (json['matravelExpenseComment'] != null) {
    //   matravelExpenseComment = <Null>[];
    //   json['matravelExpenseComment'].forEach((v) { matravelExpenseComment!.add(new Null.fromJson(v)); });
    // }
    maExpenseSummary = json['maExpenseSummary'] != null ? new MaExpenseSummary.fromJson(json['maExpenseSummary']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['recordLocator'] = this.recordLocator;
    data['currentStatus'] = this.currentStatus;
    data['startDate'] = this.startDate;
    data['startTime'] = this.startTime;
    data['endDate'] = this.endDate;
    data['endTime'] = this.endTime;
    if (this.maTravelRequest != null) {
      data['maTravelRequest'] = this.maTravelRequest!.toJson();
    }
    if (this.expenseVisitDetails != null) {
      data['expenseVisitDetails'] = this.expenseVisitDetails!.map((v) => v.toJson()).toList();
    }
    // if (this.ticketExpenses != null) {
    //   data['ticketExpenses'] = this.ticketExpenses!.map((v) => v.toJson()).toList();
    // }
    // if (this.accommodationExpenses != null) {
    //   data['accommodationExpenses'] = this.accommodationExpenses!.map((v) => v.toJson()).toList();
    // }
    // if (this.conveyanceExpenses != null) {
    //   data['conveyanceExpenses'] = this.conveyanceExpenses!.map((v) => v.toJson()).toList();
    // }
    // if (this.miscellaneousExpenses != null) {
    //   data['miscellaneousExpenses'] = this.miscellaneousExpenses!.map((v) => v.toJson()).toList();
    // }
    // if (this.cashAdvances != null) {
    //   data['cashAdvances'] = this.cashAdvances!.map((v) => v.toJson()).toList();
    // }
    // if (this.dailyAllowances != null) {
    //   data['dailyAllowances'] = this.dailyAllowances!.map((v) => v.toJson()).toList();
    // }
    // if (this.matravelExpenseComment != null) {
    //   data['matravelExpenseComment'] = this.matravelExpenseComment!.map((v) => v.toJson()).toList();
    // }
    if (this.maExpenseSummary != null) {
      data['maExpenseSummary'] = this.maExpenseSummary!.toJson();
    }
    return data;
  }
}

class MaTravelRequest {
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
  String? maTravelerDetails;
  List<MaCityPairs>? maCityPairs;
  Null? maAccomodationPlanDetail;
  Null? maTaxiPlanDetail;
  List<Null>? maCashAdvance;
  List<Null>? maForexAdvance;
  List<Null>? maTravelVisas;
  List<Null>? maTravelInsurance;
  List<TravelComments>? travelComments;

  MaTravelRequest({this.id, this.tripNumber, this.employeeName, this.mobileNumber, this.emergencyMobileNumber, this.startDate, this.endDate, this.purposeOfTravel, this.purposeOfVisit, this.origin, this.destination, this.currentStatus, this.tripType, this.tripBillable, this.approver1, this.approver2, this.approver3, this.segmentType, this.voilationMessage, this.travelerName, this.tripPlan, this.forexAdvance, this.comments, this.grade, this.maRequesterDetails, this.maTravelerDetails, this.maCityPairs, this.maAccomodationPlanDetail, this.maTaxiPlanDetail, this.maCashAdvance, this.maForexAdvance, this.maTravelVisas, this.maTravelInsurance, this.travelComments});

  MaTravelRequest.fromJson(Map<String, dynamic> json) {
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
    maTravelerDetails = json['maTravelerDetails'];
    if (json['maCityPairs'] != null) {
      maCityPairs = <MaCityPairs>[];
      json['maCityPairs'].forEach((v) { maCityPairs!.add(new MaCityPairs.fromJson(v)); });
    }
    maAccomodationPlanDetail = json['maAccomodationPlanDetail'];
    maTaxiPlanDetail = json['maTaxiPlanDetail'];
    // if (json['maCashAdvance'] != null) {
    //   maCashAdvance = <Null>[];
    //   json['maCashAdvance'].forEach((v) { maCashAdvance!.add(new Null.fromJson(v)); });
    // }
    // if (json['maForexAdvance'] != null) {
    //   maForexAdvance = <Null>[];
    //   json['maForexAdvance'].forEach((v) { maForexAdvance!.add(new Null.fromJson(v)); });
    // }
    // if (json['maTravelVisas'] != null) {
    //   maTravelVisas = <Null>[];
    //   json['maTravelVisas'].forEach((v) { maTravelVisas!.add(new Null.fromJson(v)); });
    // }
    // if (json['maTravelInsurance'] != null) {
    //   maTravelInsurance = <Null>[];
    //   json['maTravelInsurance'].forEach((v) { maTravelInsurance!.add(new Null.fromJson(v)); });
    // }
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
    if (this.maCityPairs != null) {
      data['maCityPairs'] = this.maCityPairs!.map((v) => v.toJson()).toList();
    }
    data['maAccomodationPlanDetail'] = this.maAccomodationPlanDetail;
    data['maTaxiPlanDetail'] = this.maTaxiPlanDetail;
    // if (this.maCashAdvance != null) {
    //   data['maCashAdvance'] = this.maCashAdvance!.map((v) => v.toJson()).toList();
    // }
    // if (this.maForexAdvance != null) {
    //   data['maForexAdvance'] = this.maForexAdvance!.map((v) => v.toJson()).toList();
    // }
    // if (this.maTravelVisas != null) {
    //   data['maTravelVisas'] = this.maTravelVisas!.map((v) => v.toJson()).toList();
    // }
    // if (this.maTravelInsurance != null) {
    //   data['maTravelInsurance'] = this.maTravelInsurance!.map((v) => v.toJson()).toList();
    // }
    if (this.travelComments != null) {
      data['travelComments'] = this.travelComments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MaRequesterDetails {
  int? id;
  String? travelerName;
  String? employeeCode;
  String? requestType;
  String? grade;
  String? gender;
  String? division;
  String? department;
  String? costCenter;
  String? email;
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
  LeavingFrom? goingTo;
  String? startDate;
  String? startTime;
  ByCompany? byCompany;
  ByCompany? fareClass;
  String? travelMode;
  String? pnr;
  double? price;
  String? ticketNo;
  Null? arrivalDate;
  Null? arrivalTime;
  Null? flightNo;
  Null? airlines;
  bool? booked;

  MaCityPairs({this.id, this.leavingFrom, this.goingTo, this.startDate, this.startTime, this.byCompany, this.fareClass, this.travelMode, this.pnr, this.price, this.ticketNo, this.arrivalDate, this.arrivalTime, this.flightNo, this.airlines, this.booked});

  MaCityPairs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leavingFrom = json['leavingFrom'] != null ? new LeavingFrom.fromJson(json['leavingFrom']) : null;
    goingTo = json['goingTo'] != null ? new LeavingFrom.fromJson(json['goingTo']) : null;
    startDate = json['startDate'];
    startTime = json['startTime'];
    byCompany = json['byCompany'] != null ? new ByCompany.fromJson(json['byCompany']) : null;
    fareClass = json['fareClass'] != null ? new ByCompany.fromJson(json['fareClass']) : null;
    travelMode = json['travelMode'];
    pnr = json['pnr'];
    price = json['price'];
    ticketNo = json['ticketNo'];
    arrivalDate = json['arrivalDate'];
    arrivalTime = json['arrivalTime'];
    flightNo = json['flightNo'];
    airlines = json['airlines'];
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
  SSState? state;

  LeavingFrom({this.id, this.name, this.locationName, this.enabled, this.cityCode, this.cityClass, this.state});

  LeavingFrom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    locationName = json['locationName'];
    enabled = json['enabled'];
    cityCode = json['cityCode'];
    cityClass = json['cityClass'];
    state = json['state'] != null ? new SSState.fromJson(json['state']) : null;
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

class SSState {
  int? id;
  String? name;
  String? printableName;
  String? iso;
  Null? iso3;
  bool? enabled;
  Country? country;

  SSState({this.id, this.name, this.printableName, this.iso, this.iso3, this.enabled, this.country});

  SSState.fromJson(Map<String, dynamic> json) {
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

class I18nTextName {
  String? defaultText;
  String? text;

  I18nTextName({this.defaultText, this.text});

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

class ExpenseVisitDetails {
int? id;
String? city;
String? evdStartDate;
String? evdStartTime;
String? evdEndDate;
String? evdEndTime;

ExpenseVisitDetails({this.id, this.city, this.evdStartDate, this.evdStartTime, this.evdEndDate, this.evdEndTime});

ExpenseVisitDetails.fromJson(Map<String, dynamic> json) {
id = json['id'];
city = json['city'];
evdStartDate = json['evdStartDate'];
evdStartTime = json['evdStartTime'];
evdEndDate = json['evdEndDate'];
evdEndTime = json['evdEndTime'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id;
data['city'] = this.city;
data['evdStartDate'] = this.evdStartDate;
data['evdStartTime'] = this.evdStartTime;
data['evdEndDate'] = this.evdEndDate;
data['evdEndTime'] = this.evdEndTime;
return data;
}
}

class MaExpenseSummary {
int? bookedTicketCost;
int? ticketByCompany;
int? ticketSelf;
int? accommodationByCompany;
int? accommodationSelf;
int? dailyAllowanceByCompany;
int? conveyanceByCompany;
int? conveyanceSelf;
int? miscellaneousByCompany;
int? miscellaneousSelf;
int? advanceByCash;
int? advanceByCard;
int? totalAmountByCompany;
int? totalAmountSelf;
int? totalExpense;
int? dueToCompany;
int? dueFromCompany;

MaExpenseSummary({this.bookedTicketCost, this.ticketByCompany, this.ticketSelf, this.accommodationByCompany, this.accommodationSelf, this.dailyAllowanceByCompany, this.conveyanceByCompany, this.conveyanceSelf, this.miscellaneousByCompany, this.miscellaneousSelf, this.advanceByCash, this.advanceByCard, this.totalAmountByCompany, this.totalAmountSelf, this.totalExpense, this.dueToCompany, this.dueFromCompany});

MaExpenseSummary.fromJson(Map<String, dynamic> json) {
bookedTicketCost = json['bookedTicketCost'];
ticketByCompany = json['ticketByCompany'];
ticketSelf = json['ticketSelf'];
accommodationByCompany = json['accommodationByCompany'];
accommodationSelf = json['accommodationSelf'];
dailyAllowanceByCompany = json['dailyAllowanceByCompany'];
conveyanceByCompany = json['conveyanceByCompany'];
conveyanceSelf = json['conveyanceSelf'];
miscellaneousByCompany = json['miscellaneousByCompany'];
miscellaneousSelf = json['miscellaneousSelf'];
advanceByCash = json['advanceByCash'];
advanceByCard = json['advanceByCard'];
totalAmountByCompany = json['totalAmountByCompany'];
totalAmountSelf = json['totalAmountSelf'];
totalExpense = json['totalExpense'];
dueToCompany = json['dueToCompany'];
dueFromCompany = json['dueFromCompany'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['bookedTicketCost'] = this.bookedTicketCost;
data['ticketByCompany'] = this.ticketByCompany;
data['ticketSelf'] = this.ticketSelf;
data['accommodationByCompany'] = this.accommodationByCompany;
data['accommodationSelf'] = this.accommodationSelf;
data['dailyAllowanceByCompany'] = this.dailyAllowanceByCompany;
data['conveyanceByCompany'] = this.conveyanceByCompany;
data['conveyanceSelf'] = this.conveyanceSelf;
data['miscellaneousByCompany'] = this.miscellaneousByCompany;
data['miscellaneousSelf'] = this.miscellaneousSelf;
data['advanceByCash'] = this.advanceByCash;
data['advanceByCard'] = this.advanceByCard;
data['totalAmountByCompany'] = this.totalAmountByCompany;
data['totalAmountSelf'] = this.totalAmountSelf;
data['totalExpense'] = this.totalExpense;
data['dueToCompany'] = this.dueToCompany;
data['dueFromCompany'] = this.dueFromCompany;
return data;
}
}

