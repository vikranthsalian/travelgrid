import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgrid/common/constants/event_types.dart';
import 'package:travelgrid/common/extensions/capitalize.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/sort_util.dart';
import 'package:travelgrid/data/datasources/summary/ge_summary_response.dart';
import 'package:travelgrid/data/datasources/list/tr_list_response.dart' as trlist;
import 'package:travelgrid/data/datasources/list/tr_upcoming_response.dart' as uplist;
import 'package:travelgrid/data/datasources/summary/tr_summary_response.dart';
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
      trlist.TRListResponse? response = await Injector.resolve<TrUseCase>().callApi();
      if(response!=null && response.status==true){
        if(event.sortID!=0){
          response.data = SortUtil().sort(event.sortID, response.data);
        }

      //  event.filterString.toLowerCase();

        print("Select Filters");
        print(event.filterString);

        if(event.filterString.contains("All")){
          emit(TravelRequestLoadedState(data: response));
        }else{
          List<trlist.Data> items=[];
          for(var item in response.data!){
            if (
            event.filterString.contains(item.currentStatus) ||
                event.filterString.contains( item.tripType) ||
                event.filterString.contains( item.tripPlan)
            ) {
              items.add(item);
            }
          }
          response.data = items;
          emit(TravelRequestLoadedState(data: response));
        }
      }else{
        emit(TravelRequestLoadedState(data: trlist.TRListResponse(data: [],message: response.message)));
      }

    }

    if(event is GetTravelRequestSummaryEvent) {
      TRSummaryResponse? response = await Injector.resolve<TrUseCase>().getSummary(event.recordLocator);
      if(response!=null && response.status == true){
        emit(TravelRequestSummaryLoadedState(data: response));
      }else{
        emit(TravelRequestSummaryLoadedState(data: TRSummaryResponse(message: response.message)));
      }

    }
    if(event is GetUpcomingListEvent) {
      uplist.MetaUpcomingTRResponse? response = await Injector.resolve<TrUseCase>().upcomingApi();
      if(response!=null && response.status == true){
        emit(UpcomingTravelRequestLoadedState(data: response));
      }else{
        emit(UpcomingTravelRequestLoadedState(data: uplist.MetaUpcomingTRResponse(data: [],message: response.message)));
      }

    }

  }

}
