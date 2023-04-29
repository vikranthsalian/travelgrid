class GESummaryResponse {
  bool? status;
  String? token;
  String? message;
  List<Data>? data;

  GESummaryResponse({this.status, this.token, this.message, this.data});

  GESummaryResponse.fromJson(Map<String, dynamic> json) {
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
  String? recordLocator;
  String? currentStatus;
  bool? violated;
  String? expenseSubmissionDate;
  double? accommodationSelf;
  double? conveyanceSelf;
  double? dailyAllowanceByCompany;
  double? miscellaneousSelf;
  double? channelEngagementself;
  double? department;
  double? totalExpense;
  bool? selfApprovals;
  List<MaGeAccomodationExpense>? maGeAccomodationExpense;
  List<MaGeConveyanceExpense>? maGeConveyanceExpense;
  List<MaGeMiscellaneousExpense>? maGeMiscellaneousExpense;
//  List<Null>? maGeDailyAllowance;
  List<MaGeneralExpenseComment>? maGeneralExpenseComment;
  String? employeeName;

  Data(
      {this.id,
        this.recordLocator,
        this.currentStatus,
        this.violated,
        this.expenseSubmissionDate,
        this.accommodationSelf,
        this.conveyanceSelf,
        this.dailyAllowanceByCompany,
        this.miscellaneousSelf,
        this.channelEngagementself,
        this.department,
        this.totalExpense,
        this.selfApprovals,
        this.maGeConveyanceExpense,
        // this.maGeAccomodationExpense,
        // this.maGeMiscellaneousExpense,
        // this.maGeDailyAllowance,
        // this.maGeneralExpenseComment,
        this.employeeName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recordLocator = json['recordLocator'];
    currentStatus = json['currentStatus'];
    violated = json['violated'];
    expenseSubmissionDate = json['expenseSubmissionDate'];
    accommodationSelf = json['accommodationSelf'];
    conveyanceSelf = json['conveyanceSelf'];
    dailyAllowanceByCompany = json['dailyAllowanceByCompany'];
    miscellaneousSelf = json['miscellaneousSelf'];
    channelEngagementself = json['channelEngagementself'];
    department = json['department'];
    totalExpense = json['totalExpense'];
    selfApprovals = json['selfApprovals'];
    if (json['maGeConveyanceExpense'] != null) {
      maGeConveyanceExpense = <MaGeConveyanceExpense>[];
      json['maGeConveyanceExpense'].forEach((v) {
        maGeConveyanceExpense!.add(new MaGeConveyanceExpense.fromJson(v));
      });
    }
    if (json['maGeAccomodationExpense'] != null) {
      maGeAccomodationExpense = <MaGeAccomodationExpense>[];
      json['maGeAccomodationExpense'].forEach((v) {
        maGeAccomodationExpense!.add(new MaGeAccomodationExpense.fromJson(v));
      });
    }

    if (json['maGeMiscellaneousExpense'] != null) {
      maGeMiscellaneousExpense = <MaGeMiscellaneousExpense>[];
      json['maGeMiscellaneousExpense'].forEach((v) {
        maGeMiscellaneousExpense!.add(new MaGeMiscellaneousExpense.fromJson(v));
      });
    }
    // if (json['maGeDailyAllowance'] != null) {
    //   maGeDailyAllowance = <Null>[];
    //   json['maGeDailyAllowance'].forEach((v) {
    //     maGeDailyAllowance!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['maGeneralExpenseComment'] != null) {
      maGeneralExpenseComment = <MaGeneralExpenseComment>[];
      json['maGeneralExpenseComment'].forEach((v) {
        maGeneralExpenseComment!.add(new MaGeneralExpenseComment.fromJson(v));
      });
    }
    employeeName = json['employeeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['recordLocator'] = this.recordLocator;
    data['currentStatus'] = this.currentStatus;
    data['violated'] = this.violated;
    data['expenseSubmissionDate'] = this.expenseSubmissionDate;
    data['accommodationSelf'] = this.accommodationSelf;
    data['conveyanceSelf'] = this.conveyanceSelf;
    data['dailyAllowanceByCompany'] = this.dailyAllowanceByCompany;
    data['miscellaneousSelf'] = this.miscellaneousSelf;
    data['channelEngagementself'] = this.channelEngagementself;
    data['department'] = this.department;
    data['totalExpense'] = this.totalExpense;
    data['selfApprovals'] = this.selfApprovals;
    if (this.maGeConveyanceExpense != null) {
      data['maGeConveyanceExpense'] =
          this.maGeConveyanceExpense!.map((v) => v.toJson()).toList();
    }

    if (this.maGeAccomodationExpense != null) {
      data['maGeAccomodationExpense'] =
          this.maGeAccomodationExpense!.map((v) => v.toJson()).toList();
    }

    if (this.maGeMiscellaneousExpense != null) {
      data['maGeMiscellaneousExpense'] =
          this.maGeMiscellaneousExpense!.map((v) => v.toJson()).toList();
    }
    // if (this.maGeDailyAllowance != null) {
    //   data['maGeDailyAllowance'] =
    //       this.maGeDailyAllowance!.map((v) => v.toJson()).toList();
    // }
    if (this.maGeneralExpenseComment != null) {
      data['maGeneralExpenseComment'] =
          this.maGeneralExpenseComment!.map((v) => v.toJson()).toList();
    }
    data['employeeName'] = this.employeeName;
    return data;
  }
}

class MaGeAccomodationExpense {
  int? id;
  String? checkInDate;
  String? checkInTime;
  String? checkOutDate;
  String? checkOutTime;
  int? noOfDays;
  int? city;
  String? cityName;
  String? hotelName;
  int? accomodationType;
  String? accomodationTypeName;
  double? amount;
  double? tax;
  String? description;
  bool? withBill;
  String? voilationMessage;
  String? voucherPath;
  bool? violated;
  String? voucherNumber;
  String? groupEmployees;
  bool? groupExpense;

  MaGeAccomodationExpense(
      {this.id,
        this.checkInDate,
        this.checkInTime,
        this.checkOutDate,
        this.checkOutTime,
        this.noOfDays,
        this.city,
        this.cityName,
        this.hotelName,
        this.accomodationType,
        this.accomodationTypeName,
        this.amount,
        this.tax,
        this.description,
        this.withBill,
        this.voilationMessage,
        this.voucherPath,
        this.violated,
        this.groupEmployees,
        this.groupExpense,
        this.voucherNumber});

  MaGeAccomodationExpense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkInDate = json['checkInDate'];
    checkInTime = json['checkInTime'];
    checkOutDate = json['checkOutDate'];
    checkOutTime = json['checkOutTime'];
    noOfDays = json['noOfDays'];
    city = json['city'];
    cityName = json['cityName'];
    hotelName = json['hotelName'];
    accomodationType = json['accomodationType'];
    accomodationTypeName = json['accomodationTypeName'];
    amount = double.parse(json['amount'].toString());
    tax = double.parse(json['tax'].toString());
    description = json['description'];
    withBill = json['withBill'];
    voilationMessage = json['voilationMessage'];
    voucherPath = json['voucherPath'];
    violated = json['violated'];
    voucherNumber = json['voucherNumber'];
    groupEmployees = json['groupEmployees'];
    groupExpense = json['groupExpense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['checkInDate'] = this.checkInDate;
    data['checkInTime'] = this.checkInTime;
    data['checkOutDate'] = this.checkOutDate;
    data['checkOutTime'] = this.checkOutTime;
    data['noOfDays'] = this.noOfDays;
    data['city'] = this.city;
    data['cityName'] = this.cityName;
    data['hotelName'] = this.hotelName;
    data['accomodationType'] = this.accomodationType;
    data['accomodationTypeName'] = this.accomodationTypeName;
    data['amount'] = this.amount;
    data['tax'] = this.tax;
    data['description'] = this.description;
    data['withBill'] = this.withBill;
    data['voilationMessage'] = this.voilationMessage;
    data['voucherPath'] = this.voucherPath;
    data['violated'] = this.violated;
    data['voucherNumber'] = this.voucherNumber;
    data['groupEmployees'] = this.groupEmployees;
    data['groupExpense'] = this.groupExpense;
    return data;
  }
}

class MaGeMiscellaneousExpense {
  int? id;
  double? amount;
  String? description;
  String? voucherNumber;
  bool? violated;
  String? voilationMessage;
  int? miscellaneousType;
  String? startDate;
  String? endDate;
  String? voucherPath;
  String? voucherFile;
  int? city;
  String? cityName;
  String? miscellaneousTypeName;
  int? unitType;
  String? groupEmployees;
  bool? groupExpense;

  MaGeMiscellaneousExpense(
      {this.id,
        this.amount,
        this.description,
        this.voucherNumber,
        this.violated,
        this.voilationMessage,
        this.miscellaneousType,
        this.startDate,
        this.endDate,
        this.voucherPath,
        this.voucherFile,
        this.city,
        this.cityName,
        this.miscellaneousTypeName,
        this.groupEmployees,
        this.groupExpense,
        this.unitType});

  MaGeMiscellaneousExpense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    description = json['description'];
    voucherNumber = json['voucherNumber'];
    violated = json['violated'];
    voilationMessage = json['voilationMessage'];
    miscellaneousType = json['miscellaneousType'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    voucherPath = json['voucherPath'];
    voucherFile = json['voucherFile'];
    city = json['city'];
    cityName = json['cityName'];
    miscellaneousTypeName = json['miscellaneousTypeName'];
    unitType = json['unitType'];
    groupEmployees = json['groupEmployees'] ?? "";
    groupExpense = json['groupExpense'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['voucherNumber'] = this.voucherNumber;
    data['violated'] = this.violated;
    data['voilationMessage'] = this.voilationMessage;
    data['miscellaneousType'] = this.miscellaneousType;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['voucherPath'] = this.voucherPath;
    data['voucherFile'] = this.voucherFile;
    data['city'] = this.city;
    data['cityName'] = this.cityName;
    data['miscellaneousTypeName'] = this.miscellaneousTypeName;
    data['unitType'] = this.unitType;
    data['groupEmployees'] = this.groupEmployees;
    data['groupExpense'] = this.groupExpense;
    return data;
  }
}


class MaGeConveyanceExpense {
  int? id;
  String? city;
  String? origin;
  String? destination;
  String? conveyanceDate;
  String? startTime;
  String? endTime;
  double? amount;
  double? distance;
  String? voucherNumber;
  bool? withBill;
  String? voilationMessage;
  bool? violated;
  int? travelMode;
  int? vehicleType;
  String? travelModeName;
  String? description;
  String? voucherPath;
  String? voucherFile;
  List<MaGeConveyanceCityPair>? maGeConveyanceCityPair;

  MaGeConveyanceExpense(
      {this.id,
        this.city,
        this.origin,
        this.destination,
        this.conveyanceDate,
        this.startTime,
        this.endTime,
        this.amount,
        this.distance,
        this.voucherNumber,
        this.withBill,
        this.voilationMessage,
        this.violated,
        this.travelMode,
        this.vehicleType,
        this.travelModeName,
        this.description,
        this.voucherPath,
        this.voucherFile,
        this.maGeConveyanceCityPair});

  MaGeConveyanceExpense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    origin = json['origin'];
    destination = json['destination'];
    conveyanceDate = json['conveyanceDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    amount = json['amount'];
    distance = json['distance'];
    voucherNumber = json['voucherNumber'];
    withBill = json['withBill'];
    voilationMessage = json['voilationMessage'];
    violated = json['violated'];
    travelMode = json['travelMode'];
    vehicleType = json['vehicleType'];
    travelModeName = json['travelModeName'];
    description = json['description'];
    voucherPath = json['voucherPath'];
    voucherFile = json['voucherFile'];
    if (json['maGeConveyanceCityPair'] != null) {
      maGeConveyanceCityPair = <MaGeConveyanceCityPair>[];
      json['maGeConveyanceCityPair'].forEach((v) {
        maGeConveyanceCityPair!.add(new MaGeConveyanceCityPair.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city'] = this.city;
    data['origin'] = this.origin;
    data['destination'] = this.destination;
    data['conveyanceDate'] = this.conveyanceDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['amount'] = this.amount;
    data['distance'] = this.distance;
    data['voucherNumber'] = this.voucherNumber;
    data['withBill'] = this.withBill;
    data['voilationMessage'] = this.voilationMessage;
    data['violated'] = this.violated;
    data['travelMode'] = this.travelMode;
    data['vehicleType'] = this.vehicleType;
    data['travelModeName'] = this.travelModeName;
    data['description'] = this.description;
    data['voucherPath'] = this.voucherPath;
    data['voucherFile'] = this.voucherFile;
    if (this.maGeConveyanceCityPair != null) {
      data['maGeConveyanceCityPair'] =
          this.maGeConveyanceCityPair!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MaGeConveyanceCityPair {
  int? id;
  double? distance;
  double? amount;
  String? srcLatLog;
  String? desLatLog;
  String? origin;
  String? destination;
  int? travelMode;
  String? startTime;
  String? endTime;

  MaGeConveyanceCityPair(
      {this.id,
        this.distance,
        this.amount,
        this.srcLatLog,
        this.desLatLog,
        this.origin,
        this.destination,
        this.travelMode,
        this.startTime,
        this.endTime});

  MaGeConveyanceCityPair.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    distance = json['distance'];
    amount = json['amount'];
    srcLatLog = json['srcLatLog'];
    desLatLog = json['desLatLog'];
    origin = json['origin'];
    destination = json['destination'];
    travelMode = json['travelMode'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['distance'] = this.distance;
    data['amount'] = this.amount;
    data['srcLatLog'] = this.srcLatLog;
    data['desLatLog'] = this.desLatLog;
    data['origin'] = this.origin;
    data['destination'] = this.destination;
    data['travelMode'] = this.travelMode;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    return data;
  }
}

class MaGeneralExpenseComment {
  Null? id;
  String? comments;
  String? action;
  String? actionFrom;
  String? actionBy;
  String? actionOn;

  MaGeneralExpenseComment(
      {this.id,
        this.comments,
        this.action,
        this.actionFrom,
        this.actionBy,
        this.actionOn});

  MaGeneralExpenseComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comments = json['comments'];
    action = json['action'];
    actionFrom = json['actionFrom'];
    actionBy = json['actionBy'];
    actionOn = json['actionOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comments'] = this.comments;
    data['action'] = this.action;
    data['actionFrom'] = this.actionFrom;
    data['actionBy'] = this.actionBy;
    data['actionOn'] = this.actionOn;
    return data;
  }
}
