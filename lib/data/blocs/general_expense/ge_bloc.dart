import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgrid/common/constants/event_types.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/common/utils/sort_util.dart';
import 'package:travelgrid/data/datasources/summary/ge_summary_response.dart';
import 'package:travelgrid/data/datasources/list/ge_list_response.dart' as list;
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/usecases/ge_usecase.dart';

part 'ge_event.dart';
part 'ge_state.dart';

class GeneralExpenseBloc extends Bloc<GeneralExpenseEvent, GeneralExpenseState> {
  final GeUseCase apiUseCase;
 // GEListResponse? item;
  GeneralExpenseBloc(this.apiUseCase) : super(GeneralExpenseInitialState()) {
    on<GeneralExpenseEvent>(_init);
  }

  void _init(GeneralExpenseEvent event, Emitter<GeneralExpenseState> emit) async {
    emit(GeneralExpenseInitialState());
    if(event is GetGeneralExpenseListEvent) {
      list.GEListResponse? response = await Injector.resolve<GeUseCase>().callApi();
      if(response!=null && response.status==true){

        if(event.sortID!=0){
          response.data = SortUtil().sort(event.sortID, response.data);
        }

        if(event.filterString.contains("All")){
          emit(GeneralExpenseLoadedState(data: response));
        }else{

          List<list.Data> items=[];
          for(var item in response.data!){
            if (event.filterString.contains(item.status)) {
              items.add(item);
            }
          }
          response.data = items;
          emit(GeneralExpenseLoadedState(data: response));
        }



      }else{
        emit(GeneralExpenseLoadedState(data: list.GEListResponse(data: [],message: response.message)));
      }

    }


    if(event is GetGeneralExpenseSummaryEvent) {
      GESummaryResponse? response = await Injector.resolve<GeUseCase>().getSummary(event.recordLocator);
      if(response!=null && response.status == true){
        emit(GeneralExpenseSummaryLoadedState(data: response));
      }else{
        emit(GeneralExpenseSummaryLoadedState(data: GESummaryResponse(data: [],message: response.message)));
      }

    }

  }

}
