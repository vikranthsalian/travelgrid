import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:travelex/data/datasources/others/employee_list.dart' as emp;
import 'package:travelex/data/datasources/others/non_employee_list.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(EmployeeIn(responseEmp: [],responseNonEmp: []));
  List<emp.Data> listEmp=[];
  List<Data> listNonEmp=[];

  setEmployeeResponse(List<emp.Data> response) {
    if(state is EmployeeIn) {
      listEmp=response;
      print("listEmp.length");
      print(listEmp.length);
      emit(EmployeeIn( responseEmp: response));
    }
  }

  setNonEmployeeResponse(List<Data> response) {
    if(state is EmployeeIn) {
      listNonEmp=response;
      emit(EmployeeIn( responseNonEmp: response));
    }
  }
  List<Data> getNonEmployeeResponse() {
    //List<Data> response = [];
    // if(state is EmployeeIn) {
    //   final current = state as EmployeeIn;
    //   return current.response;
    // }
    return listNonEmp;
  }

  List<emp.Data> getEmployeeResponse() {
    List<emp.Data> response = [];
    print("listEmp.length");
    print(listEmp.length);
    // if(state is EmployeeIn) {
    //   final current = state as EmployeeIn;
    //   return current.response;
    // }
    return listEmp;
  }

}
