import 'package:bloc/bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/constants/event_types.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/cubits/fare_class_cubit/fare_class_cubit.dart';
import 'package:travelgrid/data/cubits/misc_type_cubit/misc_type_cubit.dart';
import 'package:travelgrid/data/datasources/fare_class_list.dart';
import 'package:travelgrid/data/datasources/misc_type_list.dart';
import 'package:travelgrid/domain/usecases/common_usecase.dart';
import 'package:travelgrid/domain/usecases/ge_usecase.dart';

part 'fare_class_event.dart';
part 'fare_class_state.dart';

class FareClassBloc extends Bloc<FareClassEvent, FareClassState> {
  final CommonUseCase apiUseCase;

  FareClassBloc(this.apiUseCase) : super(FareClassInitialState()) {
    on<FareClassEvent>(_init);
  }

  void _init(FareClassEvent event, Emitter<FareClassState> emit) async {
    emit(FareClassInitialState());
    if(event is GetAirFareClassListEvent) {
      MetaFareClassListResponse? response = await Injector.resolve<CommonUseCase>().getFareClassList("A");
      appNavigatorKey.currentState!.context.read<FareClassCubit>().setAirFareClassResponse(response.data! ?? []);
    }

    if(event is GetRailFareClassListEvent) {
      MetaFareClassListResponse? response = await Injector.resolve<CommonUseCase>().getFareClassList("R");
      appNavigatorKey.currentState!.context.read<FareClassCubit>().setRailFareClassResponse(response.data! ?? []);
    }

    if(event is GetRoadFareClassListEvent) {
      MetaFareClassListResponse? response = await Injector.resolve<CommonUseCase>().getFareClassList("B");
      appNavigatorKey.currentState!.context.read<FareClassCubit>().setRoadFareClassResponse(response.data! ?? []);
    }
  }

}
