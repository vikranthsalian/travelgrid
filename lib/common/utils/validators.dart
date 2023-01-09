import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class Validators{


  List<Validator<dynamic>> getValidators(textField) {
    List<Validator<dynamic>> list =[];
    var items = textField['validators'];
    if(items.isNotEmpty){
      for(var item in items){
        if(item['type'] == "empty"){
          list.add(isEmpty);
        }
      }
    }
    return list;

  }

  static dynamic isEmpty(dynamic value){

      if (value.isEmpty) {
        return "Cannot be empty";
      }
      return null;

  }

}