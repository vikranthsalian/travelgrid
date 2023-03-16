import 'package:bloc/bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/constants/event_types.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/cubits/curreny_cubit/currency_cubit.dart';
import 'package:travelgrid/data/datasources/others/currency_list.dart';
import 'package:travelgrid/data/models/success_model.dart';
import 'package:travelgrid/domain/usecases/common_usecase.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CommonUseCase apiUseCase;

  CurrencyBloc(this.apiUseCase) : super(CurrencyInitialState()) {
    on<CurrencyEvent>(_init);
  }

  void _init(CurrencyEvent event, Emitter<CurrencyState> emit) async {
    emit(CurrencyInitialState());
    if(event is GetCurrencyListEvent) {
      MetaCurrencyListResponse? response = await Injector.resolve<CommonUseCase>().getCurrencyList();
      appNavigatorKey.currentState!.context.read<CurrencyCubit>().setCurrencyResponse(response.data!);
    }

    if(event is GetExchangeRateEvent) {
      SuccessModel? response = await Injector.resolve<CommonUseCase>().getExchangeRate(event.currency,event.date);
      emit(ExchangeRateLoadedState(data: response));
    }


  }

}
