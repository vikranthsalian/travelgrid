class TeConveyanceModel {
  String? conveyanceDate;
  String? fromPlace;
  String? toPlace;
  int? travelMode;
  int? amount;
  bool? byCompany;
  int? exchangeRate;
  String? currency;
  String? voucherPath;
  String? voucherNumber;
  String? description;
  String? voilationMessage;
  bool? requireApproval;
  bool? withBill;
  bool? modified;

  TeConveyanceModel(
      {this.conveyanceDate,
        this.fromPlace,
        this.toPlace,
        this.travelMode,
        this.amount,
        this.byCompany,
        this.exchangeRate,
        this.currency,
        this.voucherPath,
        this.voucherNumber,
        this.description,
        this.voilationMessage,
        this.requireApproval,
        this.withBill,
        this.modified});

  TeConveyanceModel.fromJson(Map<String, dynamic> json) {
    conveyanceDate = json['conveyanceDate'];
    fromPlace = json['fromPlace'];
    toPlace = json['toPlace'];
    travelMode = json['travelMode'];
    amount = json['amount'];
    byCompany = json['byCompany']?? false;
    exchangeRate = json['exchangeRate'];
    currency = json['currency'];
    voucherPath = json['voucherPath'];
    voucherNumber = json['voucherNumber'];
    description = json['description'];
    voilationMessage = json['voilationMessage']??"";
    requireApproval = json['requireApproval']?? false;
    withBill = json['withBill']?? false;
    modified = json['modified']?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conveyanceDate'] = this.conveyanceDate;
    data['fromPlace'] = this.fromPlace;
    data['toPlace'] = this.toPlace;
    data['travelMode'] = this.travelMode;
    data['amount'] = this.amount;
    data['byCompany'] = this.byCompany;
    data['exchangeRate'] = this.exchangeRate;
    data['currency'] = this.currency;
    data['voucherPath'] = this.voucherPath;
    data['voucherNumber'] = this.voucherNumber;
    data['description'] = this.description;
    data['voilationMessage'] = this.voilationMessage;
    data['requireApproval'] = this.requireApproval;
    data['withBill'] = this.withBill;
    data['modified'] = this.modified;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'conveyanceDate': this.conveyanceDate,
      'fromPlace': this.fromPlace,
      'toPlace': this.toPlace,
      'travelMode': this.travelMode,
      'amount': this.amount,
      'byCompany': this.byCompany,
      'exchangeRate': this.exchangeRate,
      'currency': this.currency,
      'voucherPath': this.voucherPath,
      'voucherNumber': this.voucherNumber,
      'description': this.description,
      'voilationMessage': this.voilationMessage,
      'requireApproval': this.requireApproval,
      'withBill': this.withBill,
      'modified': this.modified,
    };
  }

  factory TeConveyanceModel.fromMap(Map<String, dynamic> map) {
    return TeConveyanceModel(
      conveyanceDate: map['conveyanceDate'] as String,
      fromPlace: map['fromPlace'] as String,
      toPlace: map['toPlace'] as String,
      travelMode: map['travelMode'] as int,
      amount: map['amount'] as int,
      byCompany: map['byCompany'] as bool,
      exchangeRate: map['exchangeRate'] as int,
      currency: map['currency'] as String,
      voucherPath: map['voucherPath'] ?? "",
      voucherNumber: map['voucherNumber'] ?? "",
      description: map['description'] ?? "",
      voilationMessage: map['voilationMessage'] ?? "",
      requireApproval: map['requireApproval'] ?? false,
      withBill: map['withBill'] ?? false,
      modified: map['modified'] ?? false,
    );
  }
}
