// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i9;
import 'package:flutter/material.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../../cubit/app_cubit.dart' as _i10;
import '../../data/repository/auth_repository.dart' as _i12;
import '../../data/storage/local/app_prefs.dart' as _i8;
import '../../data/storage/remote/auth_api_service.dart' as _i11;
import '../network/network_info.dart' as _i5;
import '../network/save_api.dart' as _i6;
import 'module/di_module.dart' as _i13;
import 'module/dio_module.dart' as _i14; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final dIModule = _$DIModule();
  final dioModule = _$DioModule();
  gh.factory<_i3.InternetConnectionChecker>(() => dIModule.connectionChecker);
  gh.factory<_i4.Key>(() => dIModule.getKey());
  gh.factory<_i5.NetworkInfo>(
      () => _i5.NetworkInfoImpl(get<_i3.InternetConnectionChecker>()));
  gh.factory<_i6.SafeApi>(() => _i6.SafeApi(get<_i5.NetworkInfo>()));
  await gh.factoryAsync<_i7.SharedPreferences>(
    () => dIModule.prefs,
    preResolve: true,
  );
  gh.factory<_i8.AppPreferences>(
      () => _i8.AppPreferences(get<_i7.SharedPreferences>()));
  await gh.factoryAsync<_i9.Dio>(
    () => dioModule.getDio(get<_i8.AppPreferences>()),
    preResolve: true,
  );
  gh.factory<_i10.AppCubit>(() => _i10.AppCubit(get<_i8.AppPreferences>()));
  gh.factory<_i11.AuthServiceClient>(
      () => dIModule.getAuthService(get<_i9.Dio>()));
  gh.factory<_i12.AuthRepository>(() => _i12.AuthRepository(
        get<_i11.AuthServiceClient>(),
        get<_i6.SafeApi>(),
        get<_i8.AppPreferences>(),
      ));
  return get;
}

class _$DIModule extends _i13.DIModule {}

class _$DioModule extends _i14.DioModule {}
