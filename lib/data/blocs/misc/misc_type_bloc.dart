import 'package:bloc/bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelex/common/config/navigator_key.dart';
import 'package:travelex/common/constants/event_types.dart';
import 'package:travelex/common/injector/injector.dart';
import 'package:travelex/data/cubits/misc_type_cubit/misc_type_cubit.dart';
import 'package:travelex/data/datasources/others/misc_type_list.dart';
import 'package:travelex/domain/usecases/common_usecase.dart';
import 'package:travelex/domain/usecases/ge_usecase.dart';

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
