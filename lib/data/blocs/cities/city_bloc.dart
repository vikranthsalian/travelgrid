import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgrid/common/constants/event_types.dart';
import 'package:travelgrid/common/injector/injector.dart';
import 'package:travelgrid/data/datasources/cities_list.dart';
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
      MetaCityListResponse? response = await Injector.resolve<CommonUseCase>().getCities("IN","D");


      print(response.toJson());
      if(response!=null && response.status == true){

        emit(CityLoadedState(data: response));
      }else{
        emit(CityLoadedState(data: MetaCityListResponse(data: [],message: response.message)));
      }

    }

    if(event is SearchCityListEvent) {
    emit(CityLoadedState(data: MetaCityListResponse(data: event.list,message: "") ));
    }


  }

}
