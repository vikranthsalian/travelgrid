class GEGroupAccomModel {
  String? checkInDate;
  String? checkInTime;
  String? checkOutDate;
  String? checkOutTime;
  String? employeeCode;
  String? employeeName;


  GEGroupAccomModel(
      {
        this.checkInDate,
        this.checkInTime,
        this.checkOutDate,
        this.checkOutTime,
        this.employeeCode,
        this.employeeName});

  GEGroupAccomModel.fromJson(Map<String, dynamic> json) {
    checkInDate = json['checkInDate'];
    checkInTime = json['checkInTime'];
    checkOutDate = json['checkOutDate'];
    checkOutTime = json['checkOutTime'];
    employeeCode = json['employeeCode'] ?? "";
    employeeName = json['employeeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checkInDate'] = this.checkInDate;
    data['checkInTime'] = this.checkInTime;
    data['checkOutDate'] = this.checkOutDate;
    data['checkOutTime'] = this.checkOutTime;
    data['employeeCode'] = this.employeeCode;
    data['employeeName'] = this.employeeName;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'checkInDate': this.checkInDate,
      'checkInTime': this.checkInTime,
      'checkOutDate': this.checkOutDate,
      'checkOutTime': this.checkOutTime,
      'employeeName': this.employeeName,
      'employeeCode': this.employeeCode
    };
  }

  factory GEGroupAccomModel.fromMap(Map<String, dynamic> map) {
    return GEGroupAccomModel(
      checkInDate: map['checkInDate'] as String,
      checkInTime: map['checkInTime'] as String,
      checkOutDate: map['checkOutDate'] as String,
      employeeCode: map['employeeCode'] as String,
      employeeName: map['employeeName'] as String,
    );
  }
}
