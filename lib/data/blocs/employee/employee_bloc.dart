import 'package:bloc/bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelex/common/config/navigator_key.dart';
import 'package:travelex/common/constants/event_types.dart';
import 'package:travelex/common/injector/injector.dart';
import 'package:travelex/data/cubits/accom_type_cubit/accom_type_cubit.dart';
import 'package:travelex/data/cubits/employee_cubit/employee_cubit.dart';
import 'package:travelex/data/datasources/others/accom_type_list.dart';
import 'package:travelex/data/datasources/others/employee_list.dart';
import 'package:travelex/data/datasources/others/non_employee_list.dart';
import 'package:travelex/domain/usecases/common_usecase.dart';
import 'package:travelex/domain/usecases/ge_usecase.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final CommonUseCase apiUseCase;

  EmployeeBloc(this.apiUseCase) : super(EmployeeInitialState()) {
    on<EmployeeEvent>(_init);
  }

  void _init(EmployeeEvent event, Emitter<EmployeeState> emit) async {

    if(event is GetEmployeeListEvent) {
      MetaEmployeeListResponse? response = await Injector.resolve<CommonUseCase>().getEmployeesList();
      appNavigatorKey.currentState!.context.read<EmployeeCubit>().setEmployeeResponse(response.data!);
    }


    if(event is GetNonEmployeeListEvent) {
      MetaNonEmployeeListResponse? response = await Injector.resolve<CommonUseCase>().getNonEmployeesList();
      appNavigatorKey.currentState!.context.read<EmployeeCubit>().setNonEmployeeResponse(response.data!);
    }

  }

}
