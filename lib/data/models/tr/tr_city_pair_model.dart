class TRCityPairModel {
  String? leavingFrom;
  String? goingTo;
  String? startDate;
  String? startTime;
  int? byCompany;
  int? fareClass;
  String? travelMode;
  double? price;
  String? pnr;
  String? ticket;


  TRCityPairModel(
      {this.leavingFrom,
        this.goingTo,
        this.startDate,
        this.startTime,
        this.byCompany,
        this.fareClass,
        this.travelMode,
        this.price,
        this.pnr,
        this.ticket});

  TRCityPairModel.fromJson(Map<String, dynamic> json) {
    leavingFrom = json['leavingFrom'];
    goingTo = json['goingTo'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    byCompany = json['byCompany'];
    fareClass = json['fareClass'];
    travelMode = json['travelMode'];
    price = json['price'];
    pnr = json['pnr'];
    ticket = json['ticket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leavingFrom'] = this.leavingFrom;
    data['goingTo'] = this.goingTo;
    data['startDate'] = this.startDate;
    data['startTime'] = this.startTime;
    data['byCompany'] = this.byCompany;
    data['fareClass'] = this.fareClass;
    data['travelMode'] = this.travelMode;
    data['price'] = this.price;
    data['pnr'] = this.pnr;
    data['ticket'] = this.ticket;
    return data;
  }
}
