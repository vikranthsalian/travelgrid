class MetaFlightListResponse {
  bool? status;
  String? token;
  String? message;
  Data? data;

  MetaFlightListResponse({this.status, this.token, this.message, this.data});

  MetaFlightListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] == "SUCCESS" ? true:false;
    token = json['token'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<AirFareResults>? airFareResults;
  Null? returnAirFareResults;
  bool? rountTrip;
  bool? multi;
  int? errorCode;
  Null? errorMessage;
  bool? intl;

  Data(
      {this.airFareResults,
        this.returnAirFareResults,
        this.rountTrip,
        this.multi,
        this.errorCode,
        this.errorMessage,
        this.intl});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['airFareResults'] != null) {
      airFareResults = <AirFareResults>[];
      json['airFareResults'].forEach((v) {
        airFareResults!.add(new AirFareResults.fromJson(v));
      });
    }
    returnAirFareResults = json['returnAirFareResults'];
    rountTrip = json['rountTrip'];
    multi = json['multi'];
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    intl = json['intl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.airFareResults != null) {
      data['airFareResults'] =
          this.airFareResults!.map((v) => v.toJson()).toList();
    }
    data['returnAirFareResults'] = this.returnAirFareResults;
    data['rountTrip'] = this.rountTrip;
    data['multi'] = this.multi;
    data['errorCode'] = this.errorCode;
    data['errorMessage'] = this.errorMessage;
    data['intl'] = this.intl;
    return data;
  }
}

class AirFareResults {
  String? origin;
  String? originCode;
  String? destination;
  String? destinationCode;
  String? departureDate;
  String? arrivalDate;
  String? duration;
  Null? fareClass;
  String? carrierCode;
  String? carrierName;
  String? flightNumber;
  double? publishedPrice;
  double? baseFare;
  double? tax;
  String? fareKey;
  String? departureTime;
  String? arrivalTime;
  double? corpPublishedPrice;
  double? corpBaseFare;
  double? corpTax;
  Null? corpFareKey;
  double? splrtPublishedPrice;
  double? splrtBaseFare;
  double? splrtTax;
  Null? splrtFareKey;
  Null? splrtCC;
  int? totalStops;
  List<Segments>? segments;
  Null? returnsegments;
  Null? returnOrigin;
  Null? returnDestination;
  Null? returnDepartureDate;
  Null? returnArrivalDate;
  Null? returnCarrierCode;
  Null? returnCarrierName;
  Null? returnFlightNumber;
  int? returnTotalStops;
  Null? corpFare;

  AirFareResults(
      {this.origin,
        this.originCode,
        this.destination,
        this.destinationCode,
        this.departureDate,
        this.departureTime,
        this.arrivalTime,
        this.duration,
        this.arrivalDate,
        this.fareClass,
        this.carrierCode,
        this.carrierName,
        this.flightNumber,
        this.publishedPrice,
        this.baseFare,
        this.tax,
        this.fareKey,
        this.corpPublishedPrice,
        this.corpBaseFare,
        this.corpTax,
        this.corpFareKey,
        this.splrtPublishedPrice,
        this.splrtBaseFare,
        this.splrtTax,
        this.splrtFareKey,
        this.splrtCC,
        this.totalStops,
        this.segments,
        this.returnsegments,
        this.returnOrigin,
        this.returnDestination,
        this.returnDepartureDate,
        this.returnArrivalDate,
        this.returnCarrierCode,
        this.returnCarrierName,
        this.returnFlightNumber,
        this.returnTotalStops,
        this.corpFare});

  AirFareResults.fromJson(Map<String, dynamic> json) {
    origin = json['origin'];
    originCode = json['originCode'];
    destination = json['destination'];
    destinationCode = json['destinationCode'];
    departureDate = json['departureDate'];
    arrivalDate = json['arrivalDate'];
    arrivalTime = json['arrivalTime'];
    departureTime = json['departureTime'];
    fareClass = json['fareClass'];
    duration = json['duration'];
    carrierCode = json['carrierCode'];
    carrierName = json['carrierName'];
    flightNumber = json['flightNumber'];
    publishedPrice = json['publishedPrice'];
    baseFare = json['baseFare'];
    tax = json['tax'];
    fareKey = json['fareKey'];
    corpPublishedPrice = json['corpPublishedPrice'];
    corpBaseFare = json['corpBaseFare'];
    corpTax = json['corpTax'];
    corpFareKey = json['corpFareKey'];
    splrtPublishedPrice = json['splrtPublishedPrice'];
    splrtBaseFare = json['splrtBaseFare'];
    splrtTax = json['splrtTax'];
    splrtFareKey = json['splrtFareKey'];
    splrtCC = json['splrtCC'];
    totalStops = json['totalStops'];
    if (json['segments'] != null) {
      segments = <Segments>[];
      json['segments'].forEach((v) {
        segments!.add(new Segments.fromJson(v));
      });
    }
    returnsegments = json['returnsegments'];
    returnOrigin = json['returnOrigin'];
    returnDestination = json['returnDestination'];
    returnDepartureDate = json['returnDepartureDate'];
    returnArrivalDate = json['returnArrivalDate'];
    returnCarrierCode = json['returnCarrierCode'];
    returnCarrierName = json['returnCarrierName'];
    returnFlightNumber = json['returnFlightNumber'];
    returnTotalStops = json['returnTotalStops'];
    corpFare = json['corpFare'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['origin'] = this.origin;
    data['originCode'] = this.originCode;
    data['destination'] = this.destination;
    data['destinationCode'] = this.destinationCode;
    data['departureDate'] = this.departureDate;
    data['departureTime'] = this.departureTime;
    data['duration'] = this.duration;
    data['arrivalDate'] = this.arrivalDate;
    data['arrivalTime'] = this.arrivalTime;
    data['fareClass'] = this.fareClass;
    data['carrierCode'] = this.carrierCode;
    data['carrierName'] = this.carrierName;
    data['flightNumber'] = this.flightNumber;
    data['publishedPrice'] = this.publishedPrice;
    data['baseFare'] = this.baseFare;
    data['tax'] = this.tax;
    data['fareKey'] = this.fareKey;
    data['corpPublishedPrice'] = this.corpPublishedPrice;
    data['corpBaseFare'] = this.corpBaseFare;
    data['corpTax'] = this.corpTax;
    data['corpFareKey'] = this.corpFareKey;
    data['splrtPublishedPrice'] = this.splrtPublishedPrice;
    data['splrtBaseFare'] = this.splrtBaseFare;
    data['splrtTax'] = this.splrtTax;
    data['splrtFareKey'] = this.splrtFareKey;
    data['splrtCC'] = this.splrtCC;
    data['totalStops'] = this.totalStops;
    if (this.segments != null) {
      data['segments'] = this.segments!.map((v) => v.toJson()).toList();
    }
    data['returnsegments'] = this.returnsegments;
    data['returnOrigin'] = this.returnOrigin;
    data['returnDestination'] = this.returnDestination;
    data['returnDepartureDate'] = this.returnDepartureDate;
    data['returnArrivalDate'] = this.returnArrivalDate;
    data['returnCarrierCode'] = this.returnCarrierCode;
    data['returnCarrierName'] = this.returnCarrierName;
    data['returnFlightNumber'] = this.returnFlightNumber;
    data['returnTotalStops'] = this.returnTotalStops;
    data['corpFare'] = this.corpFare;
    return data;
  }
}

class Segments {
  String? origin;
  String? originCode;
  String? destination;
  String? destinationCode;
  String? departureDate;
  String? arrivalDate;
  String? carrierCode;
  String? carrierName;
  String? flightNumber;

  Segments(
      {this.origin,
        this.originCode,
        this.destination,
        this.destinationCode,
        this.departureDate,
        this.arrivalDate,
        this.carrierCode,
        this.carrierName,
        this.flightNumber});

  Segments.fromJson(Map<String, dynamic> json) {
    origin = json['origin'];
    originCode = json['originCode'];
    destination = json['destination'];
    destinationCode = json['destinationCode'];
    departureDate = json['departureDate'];
    arrivalDate = json['arrivalDate'];
    carrierCode = json['carrierCode'];
    carrierName = json['carrierName'];
    flightNumber = json['flightNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['origin'] = this.origin;
    data['originCode'] = this.originCode;
    data['destination'] = this.destination;
    data['destinationCode'] = this.destinationCode;
    data['departureDate'] = this.departureDate;
    data['arrivalDate'] = this.arrivalDate;
    data['carrierCode'] = this.carrierCode;
    data['carrierName'] = this.carrierName;
    data['flightNumber'] = this.flightNumber;
    return data;
  }
}
