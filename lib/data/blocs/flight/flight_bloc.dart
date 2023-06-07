import 'package:bloc/bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:meta/meta.dart';
import 'package:travelgrid/common/constants/event_types.dart';
import 'package:travelgrid/data/datasources/others/flight_list.dart';
import 'package:travelgrid/domain/usecases/common_usecase.dart';

part 'flight_event.dart';
part 'flight_state.dart';

class FlightBloc extends Bloc<FlightEvent, FlightState> {
  final CommonUseCase apiUseCase;

  FlightBloc(this.apiUseCase) : super(FlightInitialState()) {
    on<GetFlightListEvent>(_init);
  }

  void _init(GetFlightListEvent event, Emitter<FlightState> emit) async {
    emit(FlightInitialState());
    if(event is GetFlightListEvent) {
    //  MetaFlightListResponse? response = await Injector.resolve<CommonUseCase>().getFlightsList();
    //  appNavigatorKey.currentState!.context.read<FlightCubit>().setFlightResponse(response.data!);
      List<Data> list  =[
        Data(
          flight:"Indigo 6E-6129" , from: "Bangalore", to: "Mangalore",
            departDate: "17 Jul 2023 00:00",
            arriveDate: "17 Jul 2023 13:00",
            retailFare:6117, corpFare:6245),
        Data(
            flight:"Indigo 6E-8000" , from: "Mangalore", to: "Bangalore",
            departDate: "18 Sep 2023 12:00",
            arriveDate: "18 Sep 2023 15:00",
            retailFare:12117, corpFare:12245),
        Data(
            flight:"Air Asia I5-1731" , from: "Delhi", to: "Chennai",
            departDate: "20 Oct 2023 02:00",
            arriveDate: "21 Oct 2023 05:00",
            retailFare:12117, corpFare:12245),
        Data(
            flight:"Air Asia I1-2000" , from: "Chennai", to: "Mumbai",
            departDate: "22 Jan 2023 13:00",
            arriveDate: "22 Jan 2023 18:00",
            retailFare:15117, corpFare:14245),
      ];

      emit(FlightLoadedState(data: MetaFlightListResponse(data: list,message: "Data Loaded")));
    }


  }

}
