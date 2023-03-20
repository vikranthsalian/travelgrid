part of 'employee_bloc.dart';


@immutable
abstract class EmployeeState {
  MetaEmployeeListResponse? response ;
  BlocEventState eventState;
  String message;
  EmployeeState({this.response, this.message="", this.eventState=BlocEventState.LOADING});
}

class EmployeeInitialState extends EmployeeState {
  EmployeeInitialState() : super(eventState: BlocEventState.LOADING);
}

class EmployeeLoadedState extends EmployeeState {
  final MetaEmployeeListResponse? data;
  EmployeeLoadedState({required this.data}) : super(response: data, eventState: BlocEventState.LOADED);
}


class ErrorState extends EmployeeState{
  String message;
  ErrorState({required this.message}) : super(eventState:  BlocEventState.ERROR,message: message);
}
