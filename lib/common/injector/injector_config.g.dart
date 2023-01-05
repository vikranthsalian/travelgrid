// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector_config.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$InjectorConfig extends InjectorConfig {
  @override
  void _configureBlocs() {}
  @override
  void _configureUsecases() {}
  @override
  void _configureRepositories() {}
  @override
  void _configureRemoteDataSources() {}
  @override
  void _configureCommon() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => HttpClient());
  }
}
