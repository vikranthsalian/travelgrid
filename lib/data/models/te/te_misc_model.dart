class TEMiscModel {
  String? miscellaneousExpenseDate;
  String? miscellaneousExpenseEndDate;
  int? miscellaneousType;
  String? voucherNumber;
  int? amount;
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
  String? groupEmployees;
  bool? groupExpense;

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
        this.groupEmployees,
        this.groupExpense,
        this.modified});

  TEMiscModel.fromJson(Map<String, dynamic> json) {
    miscellaneousExpenseDate = json['miscellaneousExpenseDate'];
    miscellaneousExpenseEndDate = json['miscellaneousExpenseEndDate'];
    miscellaneousType = json['miscellaneousType'];
    voucherNumber = json['voucherNumber'];
    amount = json['amount'];
    byCompany = json['byCompany']?? false;
    currency = json['currency'];
    unitType = json['unitType'] ?? 0;
    exchangeRate = json['exchangeRate'];
    voucherPath = json['voucherPath'];
    description = json['description'];
    voilationMessage = json['voilationMessage']??"";
    requireApproval = json['requireApproval']?? false;
    withBill = json['withBill']?? false;
    modified = json['modified']?? false;
    groupEmployees = json['groupEmployees'];
    groupExpense = json['groupExpense'];
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
    data['groupEmployees'] = this.groupEmployees;
    data['groupExpense'] = this.groupExpense;
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
      'groupExpense': this.groupExpense,
      'groupEmployees': this.groupEmployees,
    };
  }

  factory TEMiscModel.fromMap(Map<String, dynamic> map) {
    return TEMiscModel(
      miscellaneousExpenseDate: map['miscellaneousExpenseDate'] as String,
      miscellaneousExpenseEndDate: map['miscellaneousExpenseEndDate'] as String,
      miscellaneousType: map['miscellaneousType'] as int,
      voucherNumber: map['voucherNumber'] ?? "",
      amount: map['amount'] as int,
      byCompany: map['byCompany'] ?? false,
      currency: map['currency'] as String,
      unitType: map['unitType'] ,
      exchangeRate: map['exchangeRate'] as int,
      voucherPath: map['voucherPath'] ?? "",
      description: map['description'] ?? "",
      voilationMessage: map['voilationMessage'] ?? "",
      requireApproval: map['requireApproval'] ?? false,
      withBill: map['withBill'] ?? false,
      modified: map['modified'] ?? false,
      groupExpense: map['groupExpense'] ?? false,
      groupEmployees: map['groupEmployees'] ?? "" ,
    );
  }
}
