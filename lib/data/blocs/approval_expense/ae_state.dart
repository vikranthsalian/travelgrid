part of 'ae_bloc.dart';

@immutable
abstract class ApprovalExpenseState {
  listtr.TRListResponse? responseTR ;
  TEApprovalList? responseTE ;
  listge.GEListResponse? responseGE ;
  BlocEventState eventState;
  String message;
  ApprovalExpenseState({this.responseTR,this.responseTE,this.responseGE, this.message="", this.eventState=BlocEventState.LOADING});
}

class ApprovalExpenseInitialState extends ApprovalExpenseState {
  ApprovalExpenseInitialState() : super(eventState: BlocEventState.LOADING);
}

class ApprovalExpenseTRLoadedState extends ApprovalExpenseState {
  final listtr.TRListResponse? data;
  ApprovalExpenseTRLoadedState({required this.data}) : super(responseTR: data, eventState: BlocEventState.LOADED);
}

class ApprovalExpenseTELoadedState extends ApprovalExpenseState {
  final TEApprovalList? data;
  ApprovalExpenseTELoadedState({required this.data}) : super(responseTE: data, eventState: BlocEventState.LOADED);
}

class ApprovalExpenseGELoadedState extends ApprovalExpenseState {
  final listge.GEListResponse? data;
  ApprovalExpenseGELoadedState({required this.data}) : super(responseGE: data, eventState: BlocEventState.LOADED);
}


class ErrorState extends ApprovalExpenseState{
  String message;
  ErrorState({required this.message}) : super(eventState:  BlocEventState.ERROR,message: message);
}
