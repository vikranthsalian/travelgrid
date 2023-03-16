import 'package:bloc/bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/constants/event_types.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/cubits/misc_type_cubit/misc_type_cubit.dart';
import 'package:travelgrid/data/datasources/others/misc_type_list.dart';
import 'package:travelgrid/domain/usecases/common_usecase.dart';
import 'package:travelgrid/domain/usecases/ge_usecase.dart';

part 'misc_type_event.dart';
part 'misc_type_state.dart';

class MiscTypeBloc extends Bloc<MiscTypeEvent, MiscTypeState> {
  final CommonUseCase apiUseCase;

  MiscTypeBloc(this.apiUseCase) : super(MiscTypeInitialState()) {
    on<GetMiscTypeListEvent>(_init);
  }

  void _init(GetMiscTypeListEvent event, Emitter<MiscTypeState> emit) async {
    emit(MiscTypeInitialState());
    if(event is GetMiscTypeListEvent) {
      MetaMiscTypeListResponse? response = await Injector.resolve<CommonUseCase>().getMiscTypeList();
      print(response.toJson());
      appNavigatorKey.currentState!.context.read<MiscTypeCubit>().setMiscTypeResponse(response.data!);
    }


  }

}
