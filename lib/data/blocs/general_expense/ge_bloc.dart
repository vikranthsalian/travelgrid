import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgrid/common/constants/event_types.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/datsources/general_expense_list.dart';
import 'package:travelgrid/domain/usecases/ge_usecase.dart';

part 'ge_event.dart';
part 'ge_state.dart';

class GeneralExpenseBloc extends Bloc<GeneralExpenseEvent, GeneralExpenseState> {
  final GeUseCase apiUseCase;

  GeneralExpenseBloc(this.apiUseCase) : super(GeneralExpenseInitialState()) {
    on<GetGeneralExpenseListEvent>(_init);
  }

  void _init(GetGeneralExpenseListEvent event, Emitter<GeneralExpenseState> emit) async {
    emit(GeneralExpenseInitialState());
    if(event is GetGeneralExpenseListEvent) {
      GEListResponse? response = await Injector.resolve<GeUseCase>().callApi();
      print("GEListResponse");

      if(response!=null && response.status==true){
        print(response.data);
        emit(GeneralExpenseLoadedState(data: response));
      }else{
        emit(GeneralExpenseLoadedState(data: GEListResponse(data: [],message: response.message)));
      }

    }


  }

}
