class OwnVehicleModel {
  String? origin;
  String? destination;
  String? distance;
  String? sTime;
  String? eTime;
  String? amount;

  OwnVehicleModel({this.origin,this.destination, this.distance, this.sTime,this.eTime, this.amount});

  OwnVehicleModel.fromJson(Map<String, dynamic> json) {
    origin = json['origin'];
    destination = json['destination'];
    distance = json['distance'];
    sTime = json['sTime'];
    eTime = json['eTime'];
    amount = json['amount'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> amount = new Map<String, dynamic>();
    amount['origin'] = this.origin;
    amount['destination'] = this.destination;
    amount['distance'] = this.distance;
    amount['sTime'] = this.sTime;
    amount['eTime'] = this.eTime;
    amount['amount'] = this.amount;
    return amount;
  }


}
