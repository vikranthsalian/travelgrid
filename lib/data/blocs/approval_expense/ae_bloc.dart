import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelex/common/constants/event_types.dart';
import 'package:travelex/common/injector/injector.dart';
import 'package:travelex/common/utils/sort_util.dart';
import 'package:travelex/data/datasources/list/ge_list_response.dart' as listge;
import 'package:travelex/data/datasources/list/tr_list_response.dart' as listtr;
import 'package:travelex/data/datasources/list/te_approval_list.dart';
import 'package:travelex/data/datasources/summary/te_summary_response.dart';
import 'package:travelex/domain/usecases/ae_usecase.dart';


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
      listtr.TRListResponse? response = await Injector.resolve<AeUseCase>().callTRApi("trlistpendingforapproval");
      if(response!=null && response.status==true){
        if(event.sortID!=0){
          response.data = SortUtil().sort(event.sortID, response.data);
        }

        if(event.filterString.contains("All")){
          emit(ApprovalExpenseTRLoadedState(data: response));
        }else{


          List<listtr.Data> items=[];
          for(var item in response.data!){
            if (event.filterString.contains(item.currentStatus!)) {
              items.add(item);
            }
          }
          response.data = items;
          emit(ApprovalExpenseTRLoadedState(data: response));
        }
      }else{
        emit(ApprovalExpenseTRLoadedState(data: listtr.TRListResponse(data: [])));
      }

    }

    if(event is GetApprovalExpenseGE) {
      listge.GEListResponse? response = await Injector.resolve<AeUseCase>().callGEApi("ge/gelistpendingforapproval");
      if(response!=null && response.status==true){


        if(event.sortID!=0){
          response.data = SortUtil().sort(event.sortID, response.data);
        }

        if(event.filterString.contains("All")){
          emit(ApprovalExpenseGELoadedState(data: response));

        }else{
          List<listge.Data> items=[];
          for(var item in response.data!){
            if (event.filterString.contains(item.status!)) {
              items.add(item);
            }
          }
          response.data = items;
          emit(ApprovalExpenseGELoadedState(data: response));
        }

      }else{
        emit(ApprovalExpenseGELoadedState(data: listge.GEListResponse(data: [])));
      }

    }

    if(event is GetApprovalExpenseTE) {
      TEApprovalList? response = await Injector.resolve<AeUseCase>().callTEApi("telistpendingforapproval");

      if(response!=null && response.status==true){

        if(event.sortID!=0){
          response.data = SortUtil().sort(event.sortID, response.data);
        }

        if(event.filterString.contains("All")){
          emit(ApprovalExpenseTELoadedState(data: response));
        }else{


          List<Data> items=[];
          for(var item in response.data!){
            if (event.filterString.contains(item.currentStatus!)) {
              items.add(item);
            }
          }
          response.data = items.cast<Data>();
          emit(ApprovalExpenseTELoadedState(data: response));
        }

      }else{
        emit(ApprovalExpenseTELoadedState(data: TEApprovalList(data: [])));
      }

    }


  }

}
