class TRTravelVisas {
  int? serviceType;
  String? visitingCountry;
  int? durationOfStay;
  String? visaRequirement;
  int? numberOfEntries;
  String? visaType;

  TRTravelVisas({this.serviceType, this.visitingCountry, this.durationOfStay, this.visaRequirement, this.numberOfEntries, this.visaType});

  TRTravelVisas.fromJson(Map<String, dynamic> json) {
    serviceType = json['serviceType'];
    visitingCountry = json['visitingCountry'];
    durationOfStay = json['durationOfStay'];
    visaRequirement = json['visaRequirement'];
    numberOfEntries = json['numberOfEntries'];
    visaType = json['visaType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceType'] = this.serviceType;
    data['visitingCountry'] = this.visitingCountry;
    data['durationOfStay'] = this.durationOfStay;
    data['visaRequirement'] = this.visaRequirement;
    data['numberOfEntries'] = this.numberOfEntries;
    data['visaType'] = this.visaType;
    return data;
  }
}