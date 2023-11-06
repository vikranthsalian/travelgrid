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

  String? arrivalDate;
  String? arrivalTime;
  String? flightNo;
  String? airlines;
  String? airlinesCode;
  String? selectedFare;
  int? numberOfStops;
  bool? sbt;


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
        this.arrivalDate,
        this.arrivalTime,
        this.flightNo,
        this.airlines,
        this.airlinesCode,
        this.selectedFare,
        this.numberOfStops,
        this.sbt,
        this.ticket});

  TRCityPairModel.fromJson(Map<String, dynamic> json) {
    try {
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

      arrivalDate = json['arrivalDate'];
      arrivalTime = json['arrivalTime'];
      flightNo = json['flightNo'];
      airlines = json['airlines'];
      airlinesCode = json['airlinesCode'];
      selectedFare = json['selectedFare'];
      numberOfStops = json['numberOfStops'];
      sbt = json['sbt'];
    }catch(e){
      print(e);
    }
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

    data['arrivalDate'] = this.arrivalDate;
    data['arrivalTime'] = this.arrivalTime;
    data['flightNo'] = this.flightNo;
    data['airlines'] = this.airlines;
    data['airlinesCode'] = this.airlinesCode;
    data['selectedFare'] = this.selectedFare;
    data['numberOfStops'] = this.numberOfStops;
    data['sbt'] = this.sbt;
    return data;
  }
}
