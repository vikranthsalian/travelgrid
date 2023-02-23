// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector_config.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$InjectorConfig extends InjectorConfig {
  @override
  void _configureBlocs() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => GeneralExpenseBloc(c<GeUseCase>()))
      ..registerSingleton((c) => TravelExpenseBloc(c<TeUseCase>()))
      ..registerSingleton((c) => CityBloc(c<CommonUseCase>()))
      ..registerSingleton((c) => AccomTypeBloc(c<CommonUseCase>()))
      ..registerSingleton((c) => MiscTypeBloc(c<CommonUseCase>()))
      ..registerSingleton((c) => TravelModeBloc(c<CommonUseCase>()))
      ..registerSingleton((c) => ApproverTypeBloc(c<CommonUseCase>()))
      ..registerSingleton((c) => FareClassBloc(c<CommonUseCase>()));
  }

  @override
  void _configureUsecases() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => LoginUseCase(c<LoginAPIAbstract>()))
      ..registerSingleton((c) => GeUseCase(c<GeAPIAbstract>()))
      ..registerSingleton((c) => TeUseCase(c<TeAPIAbstract>()))
      ..registerSingleton((c) => CommonUseCase(c<CommonAPIAbstract>()));
  }

  @override
  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton<LoginAPIAbstract>(
          (c) => LoginRepository(apiRemoteDatasource: c<APIRemoteDatasource>()))
      ..registerSingleton<GeAPIAbstract>(
          (c) => GeRepository(apiRemoteDatasource: c<APIRemoteDatasource>()))
      ..registerSingleton<TeAPIAbstract>(
          (c) => TeRepository(apiRemoteDatasource: c<APIRemoteDatasource>()))
      ..registerSingleton<CommonAPIAbstract>((c) =>
          CommonRepository(apiRemoteDatasource: c<APIRemoteDatasource>()));
  }

  @override
  void _configureRemoteDataSources() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => APIRemoteDatasource());
  }

  @override
  void _configureCommon() {}
}
