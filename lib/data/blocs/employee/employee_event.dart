part of 'employee_bloc.dart';

@immutable
abstract class EmployeeEvent {}

class GetEmployeeListEvent extends EmployeeEvent {
  GetEmployeeListEvent();
}

class GetNonEmployeeListEvent extends EmployeeEvent {
  GetNonEmployeeListEvent();
}
