import 'package:bloc/bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgrid/common/config/navigator_key.dart';
import 'package:travelgrid/common/constants/event_types.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/cubits/common/city_cubit/city_cubit.dart';
import 'package:travelgrid/data/datasources/others/cities_list.dart';
import 'package:travelgrid/data/datasources/others/countries_list.dart';
import 'package:travelgrid/domain/usecases/common_usecase.dart';
import 'package:travelgrid/domain/usecases/ge_usecase.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CommonUseCase apiUseCase;

  CityBloc(this.apiUseCase) : super(CityInitialState()) {
    on<CityEvent>(_init);
  }

  void _init(CityEvent event, Emitter<CityState> emit) async {
    emit(CityInitialState());
    if(event is GetCityListEvent) {
      MetaCityListResponse? response = await Injector.resolve<CommonUseCase>().getCities(event.countryCode,event.tripType);

  //    if(event.countryCode=="IN"){
        appNavigatorKey.currentState!.context.read<CityCubit>().setCityResponse(response.data!);
      // }else{
      //   emit(CityLoadedState(data: response));
      // }


    }

    if(event is GetCountryListEvent) {

      MetaCountryListResponse? response = await Injector.resolve<CommonUseCase>().getCountriesList();
      appNavigatorKey.currentState!.context.read<CityCubit>().setCountryResponse(response.data!);

    }


    if(event is GetCountryListEvent) {

      MetaCityListResponse? response = await Injector.resolve<CommonUseCase>().getCities(event.countryCode,event.tripType);
      appNavigatorKey.currentState!.context.read<CityCubit>().setOverSeasCitiesResponse(response.data!);
    //  MetaCountryListResponse? response = await Injector.resolve<CommonUseCase>().getCountriesList();

    //  emit(CountryLoadedState(data: response));
    }



  }

}
