
import 'package:travelex/common/enum/dropdown_types.dart';

class ExpenseModel {
  int? id;
  GETypes? type;
  TETypes? teType;
  String? amount;

  ExpenseModel(
      {this.id,
        this.type,
        this.teType,
        this.amount,});

  ExpenseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    teType = json['teType'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['teType'] = this.teType;
    data['amount'] = this.amount;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'type': this.type,
      'teType': this.teType,
      'amount': this.amount,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as int,
      type: map['type'] as GETypes,
      teType: map['teType'] as TETypes,
      amount: map['amount'] as String
    );
  }
}