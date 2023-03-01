import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgrid/common/constants/event_types.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/datasources/ge_summary_response.dart';
import 'package:travelgrid/data/datasources/list/ge_list_response.dart';
import 'package:travelgrid/data/datasources/te_approval_list.dart';
import 'package:travelgrid/data/datasources/te_summary_response.dart';
import 'package:travelgrid/data/datasources/list/te_list_response.dart';
import 'package:travelgrid/domain/usecases/ae_usecase.dart';
import 'package:travelgrid/domain/usecases/ge_usecase.dart';

part 'ae_event.dart';
part 'ae_state.dart';

class ApprovalExpenseBloc extends Bloc<ApprovalExpenseEvent, ApprovalExpenseState> {
  final AeUseCase apiUseCase;

  ApprovalExpenseBloc(this.apiUseCase) : super(ApprovalExpenseInitialState()) {
    on<ApprovalExpenseEvent>(_init);
  }

  void _init(ApprovalExpenseEvent event, Emitter<ApprovalExpenseState> emit) async {
    emit(ApprovalExpenseInitialState());
    if(event is GetApprovalExpenseTR) {
      GEListResponse? response = await Injector.resolve<AeUseCase>().callGEApi("trlistpendingforapproval");
      if(response!=null && response.status==true){
        emit(ApprovalExpenseTRLoadedState(data: response));
      }else{
        emit(ApprovalExpenseTRLoadedState(data: GEListResponse(data: [])));
      }

    }

    if(event is GetApprovalExpenseGE) {
      GEListResponse? response = await Injector.resolve<AeUseCase>().callGEApi("ge/gelistpendingforapproval");
      if(response!=null && response.status==true){
        emit(ApprovalExpenseGELoadedState(data: response));
      }else{
        emit(ApprovalExpenseGELoadedState(data: GEListResponse(data: [])));
      }

    }

    if(event is GetApprovalExpenseTE) {
      TEApprovalList? response = await Injector.resolve<AeUseCase>().callTEApi("telistpendingforapproval");
      print("---------");
      print(response.toJson());
      if(response!=null && response.status==true){
        emit(ApprovalExpenseTELoadedState(data: response));
      }else{
        emit(ApprovalExpenseTELoadedState(data: TEApprovalList(data: [])));
      }

    }


  }

}
