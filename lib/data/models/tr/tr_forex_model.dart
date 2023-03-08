class TrForexAdvance {
  int? totalForexAmount;
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
}