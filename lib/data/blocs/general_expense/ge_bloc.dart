import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgrid/common/constants/event_types.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/datasources/ge_summary_response.dart';
import 'package:travelgrid/data/datasources/general_expense_list.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/usecases/ge_usecase.dart';

part 'ge_event.dart';
part 'ge_state.dart';

class GeneralExpenseBloc extends Bloc<GeneralExpenseEvent, GeneralExpenseState> {
  final GeUseCase apiUseCase;

  GeneralExpenseBloc(this.apiUseCase) : super(GeneralExpenseInitialState()) {
    on<GeneralExpenseEvent>(_init);
  }

  void _init(GeneralExpenseEvent event, Emitter<GeneralExpenseState> emit) async {
    emit(GeneralExpenseInitialState());
    if(event is GetGeneralExpenseListEvent) {
      GEListResponse? response = await Injector.resolve<GeUseCase>().callApi();
      if(response!=null && response.status==true){
        emit(GeneralExpenseLoadedState(data: response));
      }else{
        emit(GeneralExpenseLoadedState(data: GEListResponse(data: [],message: response.message)));
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
