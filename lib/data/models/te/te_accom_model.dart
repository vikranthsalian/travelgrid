class TEAccomModel {
  String? checkInDate;
  String? checkInTime;
  String? checkOutDate;
  String? checkOutTime;
  int? accomodationType;
  String? hotelName;
  int? city;
  double? amount;
  double? tax;
  bool? byCompany;
  int? exchangeRate;
  String? currency;
  String? voucherNumber;
  String? voucherPath;
  double? eligibleAmount;
  bool? withBill;
  String? description;
  String? voilationMessage;
  bool? receivedApproval;
  bool? requireApproval;
  bool? modified;

  TEAccomModel(
      {this.checkInDate,
        this.checkInTime,
        this.checkOutDate,
        this.checkOutTime,
        this.accomodationType,
        this.hotelName,
        this.city,
        this.amount,
        this.tax,
        this.byCompany,
        this.exchangeRate,
        this.currency,
        this.voucherNumber,
        this.voucherPath,
        this.eligibleAmount,
        this.withBill,
        this.description,
        this.voilationMessage,
        this.receivedApproval,
        this.requireApproval,
        this.modified});

  TEAccomModel.fromJson(Map<String, dynamic> json) {
    checkInDate = json['checkInDate'];
    checkInTime = json['checkInTime'];
    checkOutDate = json['checkOutDate'];
    checkOutTime = json['checkOutTime'];
    accomodationType = json['accomodationType'];
    hotelName = json['hotelName'];
    city = json['city'];
    amount = json['amount'];
    tax = json['tax'];
    byCompany = json['byCompany'];
    exchangeRate = json['exchangeRate'];
    currency = json['currency'];
    voucherNumber = json['voucherNumber'];
    voucherPath = json['voucherPath'];
    eligibleAmount = json['eligibleAmount'];
    withBill = json['withBill'];
    description = json['description'];
    voilationMessage = json['voilationMessage'];
    receivedApproval = json['receivedApproval'];
    requireApproval = json['requireApproval'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checkInDate'] = this.checkInDate;
    data['checkInTime'] = this.checkInTime;
    data['checkOutDate'] = this.checkOutDate;
    data['checkOutTime'] = this.checkOutTime;
    data['accomodationType'] = this.accomodationType;
    data['hotelName'] = this.hotelName;
    data['city'] = this.city;
    data['amount'] = this.amount;
    data['tax'] = this.tax;
    data['byCompany'] = this.byCompany;
    data['exchangeRate'] = this.exchangeRate;
    data['currency'] = this.currency;
    data['voucherNumber'] = this.voucherNumber;
    data['voucherPath'] = this.voucherPath;
    data['eligibleAmount'] = this.eligibleAmount;
    data['withBill'] = this.withBill;
    data['description'] = this.description;
    data['voilationMessage'] = this.voilationMessage;
    data['receivedApproval'] = this.receivedApproval;
    data['requireApproval'] = this.requireApproval;
    data['modified'] = this.modified;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'checkInDate': this.checkInDate,
      'checkInTime': this.checkInTime,
      'checkOutDate': this.checkOutDate,
      'checkOutTime': this.checkOutTime,
      'accomodationType': this.accomodationType,
      'hotelName': this.hotelName,
      'city': this.city,
      'amount': this.amount,
      'tax': this.tax,
      'byCompany': this.byCompany,
      'exchangeRate': this.exchangeRate,
      'currency': this.currency,
      'voucherNumber': this.voucherNumber,
      'voucherPath': this.voucherPath,
      'eligibleAmount': this.eligibleAmount,
      'withBill': this.withBill,
      'description': this.description,
      'voilationMessage': this.voilationMessage,
      'receivedApproval': this.receivedApproval,
      'requireApproval': this.requireApproval,
      'modified': this.modified,
    };
  }

  factory TEAccomModel.fromMap(Map<String, dynamic> map) {
    return TEAccomModel(
      checkInDate: map['checkInDate'] as String,
      checkInTime: map['checkInTime'] as String,
      checkOutDate: map['checkOutDate'] as String,
      checkOutTime: map['checkOutTime'] as String,
      accomodationType: map['accomodationType'] as int,
      hotelName: map['hotelName'] as String,
      city: map['city'] as int,
      amount: map['amount'] as double,
      tax: map['tax'] as double,
      byCompany: map['byCompany'] as bool,
      exchangeRate: map['exchangeRate'] as int,
      currency: map['currency'] as String,
      voucherNumber: map['voucherNumber'] as String,
      voucherPath: map['voucherPath'] as String,
      eligibleAmount: map['eligibleAmount'] as double,
      withBill: map['withBill'] as bool,
      description: map['description'] as String,
      voilationMessage: map['voilationMessage'] as String,
      receivedApproval: map['receivedApproval'] as bool,
      requireApproval: map['requireApproval'] as bool,
      modified: map['modified'] as bool,
    );
  }
}
