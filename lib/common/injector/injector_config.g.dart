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
      ..registerSingleton((c) => CityBloc(c<GeUseCase>()))
      ..registerSingleton((c) => AccomTypeBloc(c<GeUseCase>()))
      ..registerSingleton((c) => MiscTypeBloc(c<GeUseCase>()))
      ..registerSingleton((c) => TravelModeBloc(c<GeUseCase>()));
  }

  @override
  void _configureUsecases() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => LoginUseCase(c<LoginAPIAbstract>()))
      ..registerSingleton((c) => GeUseCase(c<GeAPIAbstract>()))
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
