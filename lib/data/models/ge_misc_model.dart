class GEMiscModel {
  String? miscellaneousTypeName;
  String? miscellaneousType;
  String? startDate;
  String? endDate;
  String? city;
  String? cityName;
  String? voucher;
  String? amount;
  String? description;
  String? voucherPath;

  GEMiscModel(
      {this.miscellaneousTypeName,
        this.miscellaneousType,
        this.startDate,
        this.endDate,
        this.city,
        this.cityName,
        this.voucher,
        this.amount,
        this.description,
        this.voucherPath});

  GEMiscModel.fromJson(Map<String, dynamic> json) {
    miscellaneousTypeName = json['miscellaneousTypeName'];
    miscellaneousType = json['miscellaneousType'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    city = json['city'];
    cityName = json['cityName'];
    voucher = json['voucher'];
    amount = json['amount'];
    description = json['description'];
    voucherPath = json['voucherPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['miscellaneousTypeName'] = this.miscellaneousTypeName;
    data['miscellaneousType'] = this.miscellaneousType;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['city'] = this.city;
    data['cityName'] = this.cityName;
    data['voucher'] = this.voucher;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['voucherPath'] = this.voucherPath;
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
      'voucher': this.voucher,
      'amount': this.amount,
      'description': this.description,
      'voucherPath': this.voucherPath,
    };
  }

  factory GEMiscModel.fromMap(Map<String, dynamic> map) {
    return GEMiscModel(
      miscellaneousTypeName: map['miscellaneousTypeName'] as String,
      miscellaneousType: map['miscellaneousType'] as String,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      city: map['city'] as String,
      cityName: map['cityName'] as String,
      voucher: map['voucher'] as String,
      amount: map['amount'] as String,
      description: map['description'] as String,
      voucherPath: map['voucherPath'] as String,
    );
  }
}