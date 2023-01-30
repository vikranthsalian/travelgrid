part of 'misc_type_cubit.dart';

@immutable
abstract class MiscTypeState {}

class MiscTypeIn extends MiscTypeState {
  final List<Data> response;
  MiscTypeIn({required this.response});
}
