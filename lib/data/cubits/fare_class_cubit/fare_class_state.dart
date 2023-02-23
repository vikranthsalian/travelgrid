part of 'fare_class_cubit.dart';

@immutable
abstract class FareClassState {}

class FareClassIn extends FareClassState {
  final List<Data>? airResponse;
  final List<Data>? roadResponse;
  final List<Data>? railResponse;
  FareClassIn({this.airResponse,this.railResponse,this.roadResponse});
}
