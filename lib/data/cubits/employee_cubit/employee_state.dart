part of 'employee_cubit.dart';

@immutable
abstract class EmployeeState {}

class EmployeeIn extends EmployeeState {
  final List<emp.Data>? responseEmp;
  final List<Data>? responseNonEmp;
  EmployeeIn({this.responseEmp,this.responseNonEmp});
}
