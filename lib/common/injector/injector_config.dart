
import 'package:kiwi/kiwi.dart';
import 'package:travelgrid/common/http/http_client.dart';
import 'package:travelgrid/data/blocs/general_expense/ge_bloc.dart';
import 'package:travelgrid/data/remote/remote_datasource.dart';
import 'package:travelgrid/data/repositories/ge_repo.dart';
import 'package:travelgrid/data/repositories/login_repo.dart';
import 'package:travelgrid/domain/repo_abstract/api_abstract.dart';
import 'package:travelgrid/domain/usecases/login_usecase.dart';
import 'package:travelgrid/domain/usecases/ge_usecase.dart';
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
  // @Register.singleton(StatementBloc)
  // @Register.singleton(CustomerCareBloc)
  // @Register.singleton(IntRatesBloc)
  // @Register.singleton(AccountOpenBloc)
  // @Register.singleton(TransactionBloc)
  // @Register.singleton(ViewPayeeBloc)
  @Register.singleton(GeneralExpenseBloc)
  void _configureBlocs();
  //
  // ============ USECASES ============
  @Register.singleton(LoginUseCase)
  @Register.singleton(GeUseCase)
  void _configureUsecases();

  // ============ REPOSITORIES ============
  @Register.singleton(LoginAPIAbstract,from:LoginRepository)
  @Register.singleton(GeAPIAbstract,from:GeRepository)
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
