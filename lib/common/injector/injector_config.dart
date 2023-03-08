
import 'package:kiwi/kiwi.dart';
import 'package:travelgrid/data/blocs/accom/accom_type_bloc.dart';
import 'package:travelgrid/data/blocs/approval_expense/ae_bloc.dart';
import 'package:travelgrid/data/blocs/approver/approver_type_bloc.dart';
import 'package:travelgrid/data/blocs/cities/city_bloc.dart';
import 'package:travelgrid/data/blocs/currency/currency_bloc.dart';
import 'package:travelgrid/data/blocs/fare_class/fare_class_bloc.dart';
import 'package:travelgrid/data/blocs/general_expense/ge_bloc.dart';
import 'package:travelgrid/data/blocs/misc/misc_type_bloc.dart';
import 'package:travelgrid/data/blocs/travel/travel_mode_bloc.dart';
import 'package:travelgrid/data/blocs/travel_expense/te_bloc.dart';
import 'package:travelgrid/data/blocs/travel_purpose/travel_purpose_bloc.dart';
import 'package:travelgrid/data/blocs/travel_request/tr_bloc.dart';
import 'package:travelgrid/data/remote/remote_datasource.dart';
import 'package:travelgrid/data/repositories/ae_repo.dart';
import 'package:travelgrid/data/repositories/common_repo.dart';
import 'package:travelgrid/data/repositories/ge_repo.dart';
import 'package:travelgrid/data/repositories/login_repo.dart';
import 'package:travelgrid/data/repositories/te_repo.dart';
import 'package:travelgrid/data/repositories/tr_repo.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';
import 'package:travelgrid/domain/usecases/ae_usecase.dart';
import 'package:travelgrid/domain/usecases/common_usecase.dart';
import 'package:travelgrid/domain/usecases/login_usecase.dart';
import 'package:travelgrid/domain/usecases/ge_usecase.dart';
import 'package:travelgrid/domain/usecases/te_usecase.dart';
import 'package:travelgrid/domain/usecases/tr_usecase.dart';
part 'injector_config.g.dart';

abstract class InjectorConfig {
  static KiwiContainer container = KiwiContainer();

  static void setup() {
    container = KiwiContainer();
    _$InjectorConfig()._configure();
  }

  // ignore: type_annotate_public_apis
  static final resolve = container.resolve;

  void _configure() {
   _configureBlocs();
    _configureUsecases();
    _configureRepositories();
    _configureRemoteDataSources();
    // _configureLocalDataSources();
    _configureCommon();
  }

  // ============ BLOCS ============
  @Register.singleton(TravelRequestBloc)
  @Register.singleton(GeneralExpenseBloc)
  @Register.singleton(TravelExpenseBloc)
  @Register.singleton(ApprovalExpenseBloc)
  @Register.singleton(CityBloc)
  @Register.singleton(AccomTypeBloc)
  @Register.singleton(MiscTypeBloc)
  @Register.singleton(TravelModeBloc)
  @Register.singleton(ApproverTypeBloc)
  @Register.singleton(FareClassBloc)
  @Register.singleton(TravelPurposeBloc)
  @Register.singleton(CurrencyBloc)
  void _configureBlocs();
  //
  // ============ USECASES ============
  @Register.singleton(LoginUseCase)
  @Register.singleton(TrUseCase)
  @Register.singleton(GeUseCase)
  @Register.singleton(TeUseCase)
  @Register.singleton(AeUseCase)
  @Register.singleton(CommonUseCase)
  void _configureUsecases();

  // ============ REPOSITORIES ============
  @Register.singleton(LoginAPIAbstract,from:LoginRepository)
  @Register.singleton(TrAPIAbstract,from:TrRepository)
  @Register.singleton(GeAPIAbstract,from:GeRepository)
  @Register.singleton(TeAPIAbstract,from:TeRepository)
  @Register.singleton(AeAPIAbstract,from:AeRepository)
  @Register.singleton(CommonAPIAbstract,from:CommonRepository)
  void _configureRepositories();

  // ============ REMOTE DATASOURCES ============
  @Register.singleton(APIRemoteDatasource)
  void _configureRemoteDataSources();

  // // ============ LOCAL DATASOURCES ============
  // @Register.singleton(ProductLocalDatasource)
  // void _configureLocalDataSources();

  // ============ COMMON ============
 // @Register.singleton(HttpClient)
  void _configureCommon();

}
