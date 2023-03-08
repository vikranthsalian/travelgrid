class TRTravelInsurance {
  int? serviceType;
  String? visitingCountry;
  int? durationOfStay;
  String? insuranceRequirement;

  TRTravelInsurance({this.serviceType, this.visitingCountry, this.durationOfStay, this.insuranceRequirement});

  TRTravelInsurance.fromJson(Map<String, dynamic> json) {
    serviceType = json['serviceType'];
    visitingCountry = json['visitingCountry'];
    durationOfStay = json['durationOfStay'];
    insuranceRequirement = json['insuranceRequirement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceType'] = this.serviceType;
    data['visitingCountry'] = this.visitingCountry;
    data['durationOfStay'] = this.durationOfStay;
    data['insuranceRequirement'] = this.insuranceRequirement;
    return data;
  }
}