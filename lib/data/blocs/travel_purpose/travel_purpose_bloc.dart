import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/constants/event_types.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/cubits/travel_purpose_cubit/travel_purpose_cubit.dart';
import 'package:travelgrid/data/datasources/others/travel_purpose_list.dart';
import 'package:travelgrid/domain/usecases/common_usecase.dart';

part 'travel_purpose_event.dart';
part 'travel_purpose_state.dart';

class TravelPurposeBloc extends Bloc<TravelPurposeEvent, TravelPurposeState> {
  final CommonUseCase apiUseCase;

  TravelPurposeBloc(this.apiUseCase) : super(TravelPurposeInitialState()) {
    on<TravelPurposeEvent>(_init);
  }

  void _init(TravelPurposeEvent event, Emitter<TravelPurposeState> emit) async {
    emit(TravelPurposeInitialState());
    if(event is GetTravelPurposeListEvent) {
      MetaTravelPurposeListResponse? response = await Injector.resolve<CommonUseCase>().getTravelPurposeList();
      appNavigatorKey.currentState!.context.read<TravelPurposeCubit>().setTravelPurposeResponse(response.data!);
    }
  }

}
