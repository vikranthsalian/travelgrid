class GeConveyanceModel {
  int? city;
  String? origin;
  String? destination;
  String? conveyanceDate;
  String? startTime;
  String? endTime;
  double? amount;
  double? distance;
  int? fuelPricePerLitre;
  String? voucherNumber;
  bool? withBill;
  String? voilationMessage;
  bool? violated;
  int? travelMode;
  String? travelModeName;
  String? description;
  String? voucherPath;
  List<MaGeConveyanceCityPair>? maGeConveyanceCityPair;

  GeConveyanceModel(
      {this.city,
        this.origin,
        this.destination,
        this.conveyanceDate,
        this.startTime,
        this.endTime,
        this.amount,
        this.distance,
        this.fuelPricePerLitre,
        this.voucherNumber,
        this.withBill,
        this.voilationMessage,
        this.violated,
        this.travelMode,
        this.travelModeName,
        this.description,
        this.voucherPath,
        this.maGeConveyanceCityPair});

  GeConveyanceModel.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    origin = json['origin'];
    destination = json['destination'];
    conveyanceDate = json['conveyanceDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    amount = json['amount'];
    distance = json['distance'];
    fuelPricePerLitre = json['fuelPricePerLitre'];
    voucherNumber = json['voucherNumber'];
    withBill = json['withBill'];
    voilationMessage = json['voilationMessage'];
    violated = json['violated'];
    travelMode = json['travelMode'];
    travelModeName = json['travelModeName'];
    description = json['description'];
    voucherPath = json['voucherPath'];
    if (json['maGeConveyanceCityPair'] != null) {
      maGeConveyanceCityPair = <MaGeConveyanceCityPair>[];
      json['maGeConveyanceCityPair'].forEach((v) {
        maGeConveyanceCityPair!.add(new MaGeConveyanceCityPair.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['origin'] = this.origin;
    data['destination'] = this.destination;
    data['conveyanceDate'] = this.conveyanceDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['amount'] = this.amount;
    data['distance'] = this.distance;
    data['fuelPricePerLitre'] = this.fuelPricePerLitre;
    data['voucherNumber'] = this.voucherNumber;
    data['withBill'] = this.withBill;
    data['voilationMessage'] = this.voilationMessage;
    data['violated'] = this.violated;
    data['travelMode'] = this.travelMode;
    data['travelModeName'] = this.travelModeName;
    data['description'] = this.description;
    data['voucherPath'] = this.voucherPath;
    if (this.maGeConveyanceCityPair != null) {
      data['maGeConveyanceCityPair'] =
          this.maGeConveyanceCityPair!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'city': this.city,
      'origin': this.origin,
      'destination': this.destination,
      'conveyanceDate': this.conveyanceDate,
      'startTime': this.startTime,
      'endTime': this.endTime,
      'amount': this.amount,
      'distance': this.distance,
      'fuelPricePerLitre': this.fuelPricePerLitre,
      'voucherNumber': this.voucherNumber,
      'withBill': this.withBill,
      'voilationMessage': this.voilationMessage,
      'violated': this.violated,
      'travelMode': this.travelMode,
      'travelModeName': this.travelModeName,
      'description': this.description,
      'voucherPath': this.voucherPath,
      'maGeConveyanceCityPair': this.maGeConveyanceCityPair,
    };
  }

  factory GeConveyanceModel.fromMap(Map<String, dynamic> map) {
    return GeConveyanceModel(
      city: map['city'] ?? 0,
      origin: map['origin'] as String,
      destination: map['destination'] as String,
      conveyanceDate: map['conveyanceDate'] as String,
      startTime: map['startTime'] ?? "",
      endTime: map['endTime'] ?? "",
      amount: map['amount'] as double,
      distance: map['distance'] ?? 0,
      fuelPricePerLitre: map['fuelPricePerLitre'] ?? 0,
      voucherNumber: map['voucherNumber'] as String,
      withBill: map['withBill'] as bool,
      voilationMessage: map['voilationMessage'] ?? "",
      violated: map['violated'] ?? false,
      travelMode: map['travelMode'] as int,
      travelModeName: map['travelModeName'] as String,
      description: map['description'] as String,
      voucherPath: map['voucherPath'] as String,
    //  maGeConveyanceCityPair: map['maGeConveyanceCityPair'].toList(List<MaGeConveyanceCityPair>)

    );
  }
}

class MaGeConveyanceCityPair {
  double? distance;
  double? amount;
  String? srcLatLog;
  String? desLatLog;
  String? origin;
  String? destination;
  int? travelMode;
  String? startTime;
  String? endTime;

  MaGeConveyanceCityPair(
      {this.distance,
        this.amount,
        this.srcLatLog,
        this.desLatLog,
        this.origin,
        this.destination,
        this.travelMode,
        this.startTime,
        this.endTime});

  MaGeConveyanceCityPair.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    amount = json['amount'];
    srcLatLog = json['srcLatLog'];
    desLatLog = json['desLatLog'];
    origin = json['origin'];
    destination = json['destination'];
    travelMode = json['travelMode'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['amount'] = this.amount;
    data['srcLatLog'] = this.srcLatLog;
    data['desLatLog'] = this.desLatLog;
    data['origin'] = this.origin;
    data['destination'] = this.destination;
    data['travelMode'] = this.travelMode;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'distance': this.distance,
      'amount': this.amount,
      'srcLatLog': this.srcLatLog,
      'desLatLog': this.desLatLog,
      'origin': this.origin,
      'destination': this.destination,
      'travelMode': this.travelMode,
      'startTime': this.startTime,
      'endTime': this.endTime,
    };
  }

  factory MaGeConveyanceCityPair.fromMap(Map<String, dynamic> map) {
    return MaGeConveyanceCityPair(
      distance: map['distance'] as double,
      amount: map['amount'] as double,
      srcLatLog: map['srcLatLog'] as String,
      desLatLog: map['desLatLog'] as String,
      origin: map['origin'] as String,
      destination: map['destination'] as String,
      travelMode: map['travelMode'] as int,
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
    );
  }
}
