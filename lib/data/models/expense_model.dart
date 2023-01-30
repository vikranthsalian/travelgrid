
import 'package:travelgrid/common/enum/dropdown_types.dart';

class ExpenseModel {
  int? id;
  GETypes? type;
  String? amount;

  ExpenseModel(
      {this.id,
        this.type,
        this.amount,});

  ExpenseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['amount'] = this.amount;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'type': this.type,
      'amount': this.amount,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as int,
      type: map['type'] as GETypes,
      amount: map['amount'] as String
    );
  }
}