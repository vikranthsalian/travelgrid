class TETicketModel {
  String? travelDate;
  String? traveltime;
  String? leavingFrom;
  String? goingTo;
  String? travelMode;
  bool? byCompany;
  String? fareClass;
  String? pnrNumber;
  String? ticketNumber;
  String? flightTrainBusNo;
  int? amount;
  int? exchangeRate;
  String? currency;
  String? description;
  String? voucherPath;
  bool? withBill;
  String? voilationMessage;
  Null? receivedApproval;
  Null? requireApproval;
  Null? modified;

  TETicketModel(
      {this.travelDate,
        this.traveltime,
        this.leavingFrom,
        this.goingTo,
        this.travelMode,
        this.byCompany,
        this.fareClass,
        this.pnrNumber,
        this.ticketNumber,
        this.flightTrainBusNo,
        this.amount,
        this.exchangeRate,
        this.currency,
        this.description,
        this.voucherPath,
        this.withBill,
        this.voilationMessage,
        this.receivedApproval,
        this.requireApproval,
        this.modified});

  TETicketModel.fromJson(Map<String, dynamic> json) {
    travelDate = json['travelDate'];
    traveltime = json['traveltime'];
    leavingFrom = json['leavingFrom'];
    goingTo = json['goingTo'];
    travelMode = json['travelMode'];
    byCompany = json['byCompany'];
    fareClass = json['fareClass'];
    pnrNumber = json['pnrNumber'];
    ticketNumber = json['ticketNumber'];
    flightTrainBusNo = json['flightTrainBusNo'];
    amount = json['amount'];
    exchangeRate = json['exchangeRate'];
    currency = json['currency'];
    description = json['description'];
    voucherPath = json['voucherPath'];
    withBill = json['withBill'];
    voilationMessage = json['voilationMessage'];
    receivedApproval = json['receivedApproval'];
    requireApproval = json['requireApproval'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['travelDate'] = this.travelDate;
    data['traveltime'] = this.traveltime;
    data['leavingFrom'] = this.leavingFrom;
    data['goingTo'] = this.goingTo;
    data['travelMode'] = this.travelMode;
    data['byCompany'] = this.byCompany;
    data['fareClass'] = this.fareClass;
    data['pnrNumber'] = this.pnrNumber;
    data['ticketNumber'] = this.ticketNumber;
    data['flightTrainBusNo'] = this.flightTrainBusNo;
    data['amount'] = this.amount;
    data['exchangeRate'] = this.exchangeRate;
    data['currency'] = this.currency;
    data['description'] = this.description;
    data['voucherPath'] = this.voucherPath;
    data['withBill'] = this.withBill;
    data['voilationMessage'] = this.voilationMessage;
    data['receivedApproval'] = this.receivedApproval;
    data['requireApproval'] = this.requireApproval;
    data['modified'] = this.modified;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'travelDate': this.travelDate,
      'traveltime': this.traveltime,
      'leavingFrom': this.leavingFrom,
      'goingTo': this.goingTo,
      'travelMode': this.travelMode,
      'byCompany': this.byCompany,
      'fareClass': this.fareClass,
      'pnrNumber': this.pnrNumber,
      'ticketNumber': this.ticketNumber,
      'flightTrainBusNo': this.flightTrainBusNo,
      'amount': this.amount,
      'exchangeRate': this.exchangeRate,
      'currency': this.currency,
      'description': this.description,
      'voucherPath': this.voucherPath,
      'withBill': this.withBill,
      'voilationMessage': this.voilationMessage,
      'receivedApproval': this.receivedApproval,
      'requireApproval': this.requireApproval,
      'modified': this.modified,
    };
  }

  factory TETicketModel.fromMap(Map<String, dynamic> map) {
    return TETicketModel(
      travelDate: map['travelDate'] as String,
      traveltime: map['traveltime'] as String,
      leavingFrom: map['leavingFrom'] as String,
      goingTo: map['goingTo'] as String,
      travelMode: map['travelMode'] as String,
      byCompany: map['byCompany'] as bool,
      fareClass: map['fareClass'] as String,
      pnrNumber: map['pnrNumber'] as String,
      ticketNumber: map['ticketNumber'] as String,
      flightTrainBusNo: map['flightTrainBusNo'] as String,
      amount: map['amount'] as int,
      exchangeRate: map['exchangeRate'] as int,
      currency: map['currency'] as String,
      description: map['description'] as String,
      voucherPath: map['voucherPath'] as String,
      withBill: map['withBill'] as bool,
      voilationMessage: map['voilationMessage'] as String,
      receivedApproval: map['receivedApproval'] as Null,
      requireApproval: map['requireApproval'] as Null,
      modified: map['modified'] as Null,
    );
  }
}
