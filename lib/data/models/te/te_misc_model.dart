class TEMiscModel {
  String? miscellaneousExpenseDate;
  String? miscellaneousExpenseEndDate;
  int? miscellaneousType;
  String? voucherNumber;
  double? amount;
  bool? byCompany;
  String? currency;
  int? unitType;
  int? exchangeRate;
  String? voucherPath;
  String? description;
  String? voilationMessage;
  bool? requireApproval;
  bool? withBill;
  bool? modified;

  TEMiscModel(
      {this.miscellaneousExpenseDate,
        this.miscellaneousExpenseEndDate,
        this.miscellaneousType,
        this.voucherNumber,
        this.amount,
        this.byCompany,
        this.currency,
        this.unitType,
        this.exchangeRate,
        this.voucherPath,
        this.description,
        this.voilationMessage,
        this.requireApproval,
        this.withBill,
        this.modified});

  TEMiscModel.fromJson(Map<String, dynamic> json) {
    miscellaneousExpenseDate = json['miscellaneousExpenseDate'];
    miscellaneousExpenseEndDate = json['miscellaneousExpenseEndDate'];
    miscellaneousType = json['miscellaneousType'];
    voucherNumber = json['voucherNumber'];
    amount = json['amount'];
    byCompany = json['byCompany'];
    currency = json['currency'];
    unitType = json['unitType'];
    exchangeRate = json['exchangeRate'];
    voucherPath = json['voucherPath'];
    description = json['description'];
    voilationMessage = json['voilationMessage'];
    requireApproval = json['requireApproval'];
    withBill = json['withBill'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['miscellaneousExpenseDate'] = this.miscellaneousExpenseDate;
    data['miscellaneousExpenseEndDate'] = this.miscellaneousExpenseEndDate;
    data['miscellaneousType'] = this.miscellaneousType;
    data['voucherNumber'] = this.voucherNumber;
    data['amount'] = this.amount;
    data['byCompany'] = this.byCompany;
    data['currency'] = this.currency;
    data['unitType'] = this.unitType;
    data['exchangeRate'] = this.exchangeRate;
    data['voucherPath'] = this.voucherPath;
    data['description'] = this.description;
    data['voilationMessage'] = this.voilationMessage;
    data['requireApproval'] = this.requireApproval;
    data['withBill'] = this.withBill;
    data['modified'] = this.modified;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'miscellaneousExpenseDate': this.miscellaneousExpenseDate,
      'miscellaneousExpenseEndDate': this.miscellaneousExpenseEndDate,
      'miscellaneousType': this.miscellaneousType,
      'voucherNumber': this.voucherNumber,
      'amount': this.amount,
      'byCompany': this.byCompany,
      'currency': this.currency,
      'unitType': this.unitType,
      'exchangeRate': this.exchangeRate,
      'voucherPath': this.voucherPath,
      'description': this.description,
      'voilationMessage': this.voilationMessage,
      'requireApproval': this.requireApproval,
      'withBill': this.withBill,
      'modified': this.modified,
    };
  }

  factory TEMiscModel.fromMap(Map<String, dynamic> map) {
    return TEMiscModel(
      miscellaneousExpenseDate: map['miscellaneousExpenseDate'] as String,
      miscellaneousExpenseEndDate: map['miscellaneousExpenseEndDate'] as String,
      miscellaneousType: map['miscellaneousType'] as int,
      voucherNumber: map['voucherNumber'] as String,
      amount: map['amount'] as double,
      byCompany: map['byCompany'] as bool,
      currency: map['currency'] as String,
      unitType: map['unitType'] as int,
      exchangeRate: map['exchangeRate'] as int,
      voucherPath: map['voucherPath'] as String,
      description: map['description'] as String,
      voilationMessage: map['voilationMessage'] as String,
      requireApproval: map['requireApproval'] as bool,
      withBill: map['withBill'] as bool,
      modified: map['modified'] as bool,
    );
  }
}
