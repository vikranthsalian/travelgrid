class TRTravellerDetails {
  String? employeeCode;
  String? employeeName;
  String? employeeType;
  String? telephoneNumber;
  String? emergencyContactNo;
  String? mobileNumber;
  String? email;
  String? name;
  String? gender;
  String? costCenterName;
  String? organizationGrade;
  String? profitcenter;
  String? costcenter;
  String? divisionName;
  String? deptName;
  String? companyCode;
  String? location;

  TRTravellerDetails(
      {this.employeeCode,
        this.employeeName,
        this.employeeType,
        this.telephoneNumber,
        this.emergencyContactNo,
        this.mobileNumber,
        this.email,
        this.name,
        this.gender,
        this.costCenterName,
        this.organizationGrade,
        this.profitcenter,
        this.costcenter,
        this.divisionName,
        this.deptName,
        this.companyCode,
        this.location});

  TRTravellerDetails.fromJson(Map<String, dynamic> json) {
    employeeCode = json['employeeCode'];
    employeeName = json['employeeName'];
    employeeType = json['employeeType'];
    telephoneNumber = json['telephoneNumber'];
    emergencyContactNo = json['emergencyContactNo'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    name = json['name'];
    gender = json['gender'];
    costCenterName = json['costCenterName'];
    organizationGrade = json['organizationGrade'];
    profitcenter = json['profitcenter'];
    costcenter = json['costcenter'];
    divisionName = json['divisionName'];
    deptName = json['deptName'];
    companyCode = json['companyCode'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeCode'] = this.employeeCode;
    data['employeeName'] = this.employeeName;
    data['employeeType'] = this.employeeType;
    data['telephoneNumber'] = this.telephoneNumber;
    data['emergencyContactNo'] = this.emergencyContactNo;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['costCenterName'] = this.costCenterName;
    data['organizationGrade'] = this.organizationGrade;
    data['profitcenter'] = this.profitcenter;
    data['costcenter'] = this.costcenter;
    data['divisionName'] = this.divisionName;
    data['deptName'] = this.deptName;
    data['companyCode'] = this.companyCode;
    data['location'] = this.location;
    return data;
  }
}
