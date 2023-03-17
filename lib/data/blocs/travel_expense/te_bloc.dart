import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgrid/common/constants/event_types.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/sort_util.dart';
import 'package:travelgrid/data/datasources/summary/te_summary_response.dart';
import 'package:travelgrid/data/datasources/list/te_list_response.dart' as list;
import 'package:travelgrid/domain/usecases/te_usecase.dart';

part 'te_event.dart';
part 'te_state.dart';

class TravelExpenseBloc extends Bloc<TravelExpenseEvent, TravelExpenseState> {
  final TeUseCase apiUseCase;

  TravelExpenseBloc(this.apiUseCase) : super(TravelExpenseInitialState()) {
    on<TravelExpenseEvent>(_init);
  }

  void _init(TravelExpenseEvent event, Emitter<TravelExpenseState> emit) async {
    emit(TravelExpenseInitialState());


    if(event is GetTravelExpenseListEvent) {
      list.TEListResponse? response = await Injector.resolve<TeUseCase>().callApi();
      if(response!=null && response.status==true){

        if(event.sortID!=0){
          response.data = SortUtil().sort(event.sortID, response.data);
        }

        if(event.filterString!="Default"){
          List<list.Data> items=[];
          for(var item in response.data!){
            if (item.status!.toLowerCase().contains(event.filterString.toLowerCase())) {
              items.add(item);
            }
          }
          response.data = items;
          emit(TravelExpenseLoadedState(data: response));
        }else{
          emit(TravelExpenseLoadedState(data: response));
        }




      }else{
        emit(TravelExpenseLoadedState(data: list.TEListResponse(data: [],message: response.message)));
      }

    }

    if(event is GetTravelExpenseSummaryEvent) {
      TESummaryResponse? response = await Injector.resolve<TeUseCase>().getSummary(event.recordLocator);
      if(response!=null && response.status == true){
        emit(TravelExpenseSummaryLoadedState(data: response));
      }else{
        emit(ErrorState(message: response.message!));
      }

    }


  }

}
