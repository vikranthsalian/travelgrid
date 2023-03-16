import 'package:bloc/bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/constants/event_types.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/cubits/travel_mode_cubit/travel_mode_cubit.dart';
import 'package:travelgrid/data/datasources/others/travel_mode_list.dart';
import 'package:travelgrid/domain/usecases/common_usecase.dart';

part 'travel_mode_event.dart';
part 'travel_mode_state.dart';

class TravelModeBloc extends Bloc<TravelModeEvent, TravelModeState> {
  final CommonUseCase apiUseCase;

  TravelModeBloc(this.apiUseCase) : super(TravelModeInitialState()) {
    on<GetTravelModeListEvent>(_init);
  }

  void _init(GetTravelModeListEvent event, Emitter<TravelModeState> emit) async {
    emit(TravelModeInitialState());
    if(event is GetTravelModeListEvent) {
      MetaTravelModeListResponse? response = await Injector.resolve<CommonUseCase>().getTravelModeList();
      print(response.toJson());
      appNavigatorKey.currentState!.context.read<TravelModeCubit>().setTravelModeResponse(response.data!);
    }


  }

}
