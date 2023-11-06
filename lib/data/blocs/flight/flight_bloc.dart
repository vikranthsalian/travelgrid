import 'package:bloc/bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelex/common/constants/event_types.dart';
import 'package:travelex/common/injector/injector.dart';
import 'package:travelex/data/datasources/others/flight_list.dart';
import 'package:travelex/domain/usecases/common_usecase.dart';

part 'flight_event.dart';
part 'flight_state.dart';

class FlightBloc extends Bloc<FlightEvent, FlightState> {
  final CommonUseCase apiUseCase;
  List<AirFareResults> list=[];

  FlightBloc(this.apiUseCase) : super(FlightInitialState()) {
    on<FlightEvent>(_init);
  }

  void _init(FlightEvent event, Emitter<FlightState> emit) async {

    if(event is GetFlightListEvent) {

      Map<String,dynamic> data = {
        "from":event.from,
        "to":event.to,
        "departDate":event.date,
        "fareClass":event.fare,
        "paxCount":event.paxCount,
        "segmentType":"",
        "cityPairIndex":"",
        //"returnDate":"",
      };
      emit(FlightInitialState());
      MetaFlightListResponse? response = await Injector.resolve<CommonUseCase>().getFlightList(data);
      list = response.data!.airFareResults ?? [];
      emit(FlightLoadedState(data: response));
    }

    if(event is FlightSearchEvent) {
      List<AirFareResults> newList=[];
      if(event.key!.isEmpty){
        emit(FlightLoadedState(data: MetaFlightListResponse(status: true,data: Data(airFareResults: list))));
      }else{
        for(var item in list){
          print(item.carrierName!.toLowerCase());
          if (item.carrierName!.toLowerCase().contains(event.key!.toLowerCase())) {
            newList.add(item);
          }
        }
        emit(FlightLoadedState(data: MetaFlightListResponse(status: true,data: Data(airFareResults: newList))));
      }

    }

  }

}
