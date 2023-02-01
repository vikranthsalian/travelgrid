part of 'approver_type_bloc.dart';


@immutable
abstract class ApproverTypeState {
  MetaApproverListResponse? response ;
  BlocEventState eventState;
  String message;
  ApproverTypeState({this.response, this.message="", this.eventState=BlocEventState.LOADING});
}

class ApproverTypeInitialState extends ApproverTypeState {
  ApproverTypeInitialState() : super(eventState: BlocEventState.LOADING);
}

class ApproverTypeLoadedState extends ApproverTypeState {
  final MetaApproverListResponse? data;
  ApproverTypeLoadedState({required this.data}) : super(response: data, eventState: BlocEventState.LOADED);
}


class ErrorState extends ApproverTypeState{
  String message;
  ErrorState({required this.message}) : super(eventState:  BlocEventState.ERROR,message: message);
}
