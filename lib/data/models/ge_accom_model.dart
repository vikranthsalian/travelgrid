class GEAccomModel {
  String? checkInDate;
  String? checkInTime;
  String? checkOutDate;
  String? checkOutTime;
  int? noOfDays;
  int? city;
  String? cityName;
  int? accomodationType;
  String? accomodationTypeName;
  int? amount;
  int? tax;
  String? description;
  bool? withBill;
  String? voucherPath;
  String? voucherNumber;

  GEAccomModel(
      {
        this.checkInDate,
        this.checkInTime,
        this.checkOutDate,
        this.checkOutTime,
        this.noOfDays,
        this.city,
        this.cityName,
        this.accomodationType,
        this.accomodationTypeName,
        this.amount,
        this.tax,
        this.description,
        this.withBill,
        this.voucherPath,
        this.voucherNumber});

  GEAccomModel.fromJson(Map<String, dynamic> json) {
    checkInDate = json['checkInDate'];
    checkInTime = json['checkInTime'];
    checkOutDate = json['checkOutDate'];
    checkOutTime = json['checkOutTime'];
    noOfDays = json['noOfDays'];
    city = json['city'];
    cityName = json['cityName'];
    accomodationType = json['accomodationType'];
    accomodationTypeName = json['accomodationTypeName'];
    amount = json['amount'];
    tax = json['tax'];
    description = json['description'];
    withBill = json['withBill'] =="true" ? true:false;
    voucherPath = json['voucherPath'];
    voucherNumber = json['voucherNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checkInDate'] = this.checkInDate;
    data['checkInTime'] = this.checkInTime;
    data['checkOutDate'] = this.checkOutDate;
    data['checkOutTime'] = this.checkOutTime;
    data['noOfDays'] = this.noOfDays;
    data['city'] = this.city;
    data['cityName'] = this.cityName;
    data['accomodationType'] = this.accomodationType;
    data['accomodationTypeName'] = this.accomodationTypeName;
    data['amount'] = this.amount;
    data['tax'] = this.tax;
    data['description'] = this.description;
    data['withBill'] = this.withBill;
    data['voucherPath'] = this.voucherPath;
    data['voucherNumber'] = this.voucherNumber;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'checkInDate': this.checkInDate,
      'checkInTime': this.checkInTime,
      'checkOutDate': this.checkOutDate,
      'checkOutTime': this.checkOutTime,
      'noOfDays': this.noOfDays,
      'city': this.city,
      'cityName': this.cityName,
      'accomodationType': this.accomodationType,
      'accomodationTypeName': this.accomodationTypeName,
      'amount': this.amount,
      'tax': this.tax,
      'description': this.description,
      'withBill': this.withBill,
      'voucherPath': this.voucherPath,
      'voucherNumber': this.voucherNumber,
    };
  }

  factory GEAccomModel.fromMap(Map<String, dynamic> map) {
    return GEAccomModel(
      checkInDate: map['checkInDate'] as String,
      checkInTime: map['checkInTime'] as String,
      checkOutDate: map['checkOutDate'] as String,
      checkOutTime: map['checkOutTime'] as String,
      noOfDays: map['noOfDays'] as int,
      city: map['city'] as int,
      cityName: map['cityName'] as String,
      accomodationType: map['accomodationType'] as int,
      accomodationTypeName: map['accomodationTypeName'] as String,
      amount: map['amount'] as int,
      tax: map['tax'] as int,
      description: map['description'] as String,
      withBill: map['withBill'] as bool,
      voucherPath: map['voucherPath'] as String,
      voucherNumber: map['voucherNumber'] as String,
    );
  }
}
