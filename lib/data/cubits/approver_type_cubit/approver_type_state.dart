part of 'approver_type_cubit.dart';

@immutable
abstract class ApproverTypeState {}

class ApproverTypeIn extends ApproverTypeState {
  final List<Data> response;
  ApproverTypeIn({required this.response});
}
