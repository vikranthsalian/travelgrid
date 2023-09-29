import 'package:bloc/bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelex/common/config/navigator_key.dart';
import 'package:travelex/common/constants/event_types.dart';
import 'package:travelex/common/injector/injector.dart';
import 'package:travelex/data/cubits/approver_type_cubit/approver_type_cubit.dart';
import 'package:travelex/data/datasources/list/approver_list.dart';
import 'package:travelex/domain/usecases/common_usecase.dart';
import 'package:travelex/domain/usecases/ge_usecase.dart';

part 'approver_type_event.dart';
part 'approver_type_state.dart';

class ApproverTypeBloc extends Bloc<ApproverTypeEvent, ApproverTypeState> {
  final CommonUseCase apiUseCase;

  ApproverTypeBloc(this.apiUseCase) : super(ApproverTypeInitialState()) {
    on<GetApproverTypeListEvent>(_init);
  }

  void _init(GetApproverTypeListEvent event, Emitter<ApproverTypeState> emit) async {
    emit(ApproverTypeInitialState());
    if(event is GetApproverTypeListEvent) {
      MetaApproverListResponse? response = await Injector.resolve<CommonUseCase>().getApproverTypeList();
      print(response.toJson());
      appNavigatorKey.currentState!.context.read<ApproverTypeCubit>().setApproverTypeResponse(response.data!);
    }


  }

}
