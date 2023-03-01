import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgrid/common/constants/event_types.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/datasources/ge_summary_response.dart';
import 'package:travelgrid/data/datasources/list/tr_list_response.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/usecases/tr_usecase.dart';

part 'tr_event.dart';
part 'tr_state.dart';

class TravelRequestBloc extends Bloc<TravelRequestEvent, TravelRequestState> {
  final TrUseCase apiUseCase;

  TravelRequestBloc(this.apiUseCase) : super(TravelRequestInitialState()) {
    on<TravelRequestEvent>(_init);
  }

  void _init(TravelRequestEvent event, Emitter<TravelRequestState> emit) async {
    emit(TravelRequestInitialState());
    if(event is GetTravelRequestListEvent) {
      TRListResponse? response = await Injector.resolve<TrUseCase>().callApi();
      if(response!=null && response.status==true){
        emit(TravelRequestLoadedState(data: response));
      }else{
        emit(TravelRequestLoadedState(data: TRListResponse(data: [],message: response.message)));
      }

    }

    if(event is GetTravelRequestSummaryEvent) {
      GESummaryResponse? response = await Injector.resolve<TrUseCase>().getSummary(event.recordLocator);
      if(response!=null && response.status == true){
        emit(TravelRequestSummaryLoadedState(data: response));
      }else{
        emit(TravelRequestSummaryLoadedState(data: GESummaryResponse(data: [],message: response.message)));
      }

    }

  }

}
