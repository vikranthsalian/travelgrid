import 'package:bloc/bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelex/common/config/navigator_key.dart';
import 'package:travelex/common/constants/event_types.dart';
import 'package:travelex/common/injector/injector.dart';
import 'package:travelex/data/cubits/accom_type_cubit/accom_type_cubit.dart';
import 'package:travelex/data/datasources/others/accom_type_list.dart';
import 'package:travelex/domain/usecases/common_usecase.dart';

part 'accom_type_event.dart';
part 'accom_type_state.dart';

class AccomTypeBloc extends Bloc<AccomTypeEvent, AccomTypeState> {
  final CommonUseCase apiUseCase;

  AccomTypeBloc(this.apiUseCase) : super(AccomTypeInitialState()) {
    on<GetAccomTypeListEvent>(_init);
  }

  void _init(GetAccomTypeListEvent event, Emitter<AccomTypeState> emit) async {
    emit(AccomTypeInitialState());
    if(event is GetAccomTypeListEvent) {
      MetaAccomTypeListResponse? response = await Injector.resolve<CommonUseCase>().getAccomTypesList();
      appNavigatorKey.currentState!.context.read<AccomTypeCubit>().setAccomTypeResponse(response.data!);
    }


  }

}
