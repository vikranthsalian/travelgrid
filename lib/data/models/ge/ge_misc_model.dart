class GEMiscModel {
  String? miscellaneousTypeName;
  int? miscellaneousType;
  String? startDate;
  String? endDate;
  int? city;
  String? cityName;
  int? unitType;
  double? amount;
  String? voucherNumber;
  String? description;
  String? voucherPath;
  String? voucherFile;
  String? voilationMessage;
  String? groupEmployees;
  bool? groupExpense;

  GEMiscModel(
      {this.miscellaneousTypeName,
        this.miscellaneousType,
        this.startDate,
        this.endDate,
        this.city,
        this.cityName,
        this.unitType,
        this.amount,
        this.voucherNumber,
        this.description,
        this.voucherPath,
        this.voucherFile,
        this.groupEmployees,
        this.groupExpense,
        this.voilationMessage});

  GEMiscModel.fromJson(Map<String, dynamic> json) {
    miscellaneousTypeName = json['miscellaneousTypeName'];
    miscellaneousType = json['miscellaneousType'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    city = json['city'];
    cityName = json['cityName'];
    unitType = json['unitType'];
    amount = json['amount'];
    voucherNumber = json['voucherNumber'];
    description = json['description'];
    voucherPath = json['voucherPath'];
    voucherFile = json['voucherFile'];
    voilationMessage = json['voilationMessage'];
    groupEmployees = json['groupEmployees'];
    groupExpense = json['groupExpense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['miscellaneousTypeName'] = this.miscellaneousTypeName;
    data['miscellaneousType'] = this.miscellaneousType;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['city'] = this.city;
    data['cityName'] = this.cityName;
    data['unitType'] = this.unitType;
    data['amount'] = this.amount;
    data['voucherNumber'] = this.voucherNumber;
    data['description'] = this.description;
    data['voucherPath'] = this.voucherPath;
    data['voucherFile'] = this.voucherFile;
    data['voilationMessage'] = this.voilationMessage;
    data['groupEmployees'] = this.groupEmployees;
    data['groupExpense'] = this.groupExpense;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'miscellaneousTypeName': this.miscellaneousTypeName,
      'miscellaneousType': this.miscellaneousType,
      'startDate': this.startDate,
      'endDate': this.endDate,
      'city': this.city,
      'cityName': this.cityName,
      'unitType': this.unitType,
      'amount': this.amount,
      'voucherNumber': this.voucherNumber,
      'description': this.description,
      'voucherPath': this.voucherPath,
      'voucherFile': this.voucherFile,
      'voilationMessage': this.voilationMessage,
      'groupExpense': this.groupExpense,
      'groupEmployees': this.groupEmployees,
    };
  }

  factory GEMiscModel.fromMap(Map<String, dynamic> map) {
    return GEMiscModel(
      miscellaneousTypeName: map['miscellaneousTypeName'] as String,
      miscellaneousType: map['miscellaneousType'] as int,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      city: map['city'] as int,
      cityName: map['cityName'] as String,
      unitType: map['unitType'] ?? 0,
      amount: map['amount'] as double,
      voucherNumber: map['voucherNumber'] as String,
      description: map['description'] as String,
      voucherPath: map['voucherPath'] as String,
      voucherFile: map['voucherPath']!=null ? map['voucherFile']  : "",
      voilationMessage: map['voilationMessage'] as String,
      groupExpense: map['groupExpense'] ?? false,
      groupEmployees: map['groupEmployees'] ?? "" ,
    );
  }
}