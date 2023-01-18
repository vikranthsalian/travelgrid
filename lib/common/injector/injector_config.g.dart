// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector_config.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$InjectorConfig extends InjectorConfig {
  @override
  void _configureBlocs() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => GeneralExpenseBloc(c<GeUseCase>()));
  }

  @override
  void _configureUsecases() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => LoginUseCase(c<LoginAPIAbstract>()))
      ..registerSingleton((c) => GeUseCase(c<GeAPIAbstract>()));
  }

  @override
  void _configureRepositories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton<LoginAPIAbstract>(
          (c) => LoginRepository(apiRemoteDatasource: c<APIRemoteDatasource>()))
      ..registerSingleton<GeAPIAbstract>(
          (c) => GeRepository(apiRemoteDatasource: c<APIRemoteDatasource>()));
  }

  @override
  void _configureRemoteDataSources() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => APIRemoteDatasource());
  }

  @override
  void _configureCommon() {}
}
