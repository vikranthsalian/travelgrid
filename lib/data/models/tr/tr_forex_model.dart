class TrForexAdvance {
  double? totalForexAmount;
  int? cash;
  int? card;
  int? currency;
  String? address;
  String? violationMessage;

  TrForexAdvance(
      {this.totalForexAmount, this.cash, this.card, this.currency, this.address, this.violationMessage});

  TrForexAdvance.fromJson(Map<String, dynamic> json) {
    totalForexAmount = json['totalForexAmount'];
    cash = json['cash'];
    card = json['card'];
    currency = json['currency'];
    address = json['address'];
    violationMessage = json['violationMessage'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalForexAmount'] = this.totalForexAmount;
    data['cash'] = this.cash;
    data['currency'] = this.currency;
    data['address'] = this.address;
    data['violationMessage'] = this.violationMessage;
    return data;
  }

}