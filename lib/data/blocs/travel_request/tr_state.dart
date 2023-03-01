part of 'tr_bloc.dart';

@immutable
abstract class TravelRequestState {
  TRListResponse? response ;
  GESummaryResponse? responseSum ;
  BlocEventState eventState;
  String message;
  SuccessModel? successModel;
  TravelRequestState({this.response,this.responseSum, this.message="",this.successModel, this.eventState=BlocEventState.LOADING});
}

class TravelRequestInitialState extends TravelRequestState {
  TravelRequestInitialState() : super(eventState: BlocEventState.LOADING);
}

class TravelRequestLoadedState extends TravelRequestState {
  final TRListResponse? data;
  TravelRequestLoadedState({required this.data}) : super(response: data, eventState: BlocEventState.LOADED);
}

class TravelRequestSummaryLoadedState extends TravelRequestState {
  final GESummaryResponse? data;
  TravelRequestSummaryLoadedState({required this.data}) : super(responseSum: data, eventState: BlocEventState.LOADED);
}
class ErrorState extends TravelRequestState{
  String message;
  ErrorState({required this.message}) : super(eventState:  BlocEventState.ERROR,message: message);
}
