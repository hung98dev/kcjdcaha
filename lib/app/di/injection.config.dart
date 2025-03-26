// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../core/network/api_client.dart' as _i1059;
import '../../core/network/network_info.dart' as _i892;
import '../../features/auth/data/datasources/auth_local_data_source.dart'
    as _i852;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i17;
import '../../features/auth/domain/usecases/is_logged_in_usecase.dart' as _i48;
import '../../features/auth/domain/usecases/is_token_valid_usecase.dart'
    as _i955;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/domain/usecases/refresh_token_usecase.dart'
    as _i157;
import '../../features/auth/domain/usecases/refresh_user_permissions_usecase.dart'
    as _i303;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/mes/data/datasources/production_order_remote_data_source.dart'
    as _i224;
import '../../features/mes/data/datasources/quality_control_order_remote_data_source.dart'
    as _i180;
import '../../features/mes/data/repositories/production_order_repository_impl.dart'
    as _i1031;
import '../../features/mes/data/repositories/quality_control_order_repository_impl.dart'
    as _i544;
import '../../features/mes/domain/repositories/production_order_repository.dart'
    as _i537;
import '../../features/mes/domain/repositories/quality_control_order_repository.dart'
    as _i1046;
import '../../features/mes/domain/usecases/get_production_orders_usecase.dart'
    as _i402;
import '../../features/mes/domain/usecases/get_quality_control_orders_usecase.dart'
    as _i834;
import '../../features/mes/domain/usecases/search_production_orders_usecase.dart'
    as _i530;
import '../../features/mes/presentation/bloc/production_order/production_order_bloc.dart'
    as _i150;
import '../../features/mes/presentation/bloc/quality_control_order/quality_control_order_bloc.dart'
    as _i366;
import '../routes/app_router.dart' as _i629;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i892.NetworkInfo>(
    () => _i892.NetworkInfoImpl(gh<_i161.InternetConnection>()),
  );
  gh.factory<_i852.AuthLocalDataSource>(
    () => _i852.AuthLocalDataSourceImpl(
      sharedPreferences: gh<_i460.SharedPreferences>(),
    ),
  );
  gh.lazySingleton<_i1059.ApiClient>(
    () => _i1059.ApiClient(gh<_i519.Client>()),
  );
  gh.lazySingleton<_i180.QualityControlOrderRemoteDataSource>(
    () => _i180.QualityControlOrderRemoteDataSourceImpl(
      gh<_i1059.ApiClient>(),
      client: gh<_i1059.ApiClient>(),
    ),
  );
  gh.factory<_i107.AuthRemoteDataSource>(
    () => _i107.AuthRemoteDataSourceImpl(
      client: gh<_i519.Client>(),
      localDataSource: gh<_i852.AuthLocalDataSource>(),
    ),
  );
  gh.lazySingleton<_i224.ProductionOrderRemoteDataSource>(
    () => _i224.ProductionOrderRemoteDataSourceImpl(
      client: gh<_i1059.ApiClient>(),
    ),
  );
  gh.lazySingleton<_i537.ProductionOrderRepository>(
    () => _i1031.ProductionOrderRepositoryImpl(
      remoteDataSource: gh<_i224.ProductionOrderRemoteDataSource>(),
      networkInfo: gh<_i892.NetworkInfo>(),
    ),
  );
  gh.factory<_i787.AuthRepository>(
    () => _i153.AuthRepositoryImpl(
      remoteDataSource: gh<_i107.AuthRemoteDataSource>(),
      localDataSource: gh<_i852.AuthLocalDataSource>(),
      networkInfo: gh<_i892.NetworkInfo>(),
    ),
  );
  gh.lazySingleton<_i1046.QualityControlOrderRepository>(
    () => _i544.QualityControlOrderRepositoryImpl(
      remoteDataSource: gh<_i180.QualityControlOrderRemoteDataSource>(),
      networkInfo: gh<_i892.NetworkInfo>(),
    ),
  );
  gh.factory<_i17.GetCurrentUserUseCase>(
    () => _i17.GetCurrentUserUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i48.IsLoggedInUseCase>(
    () => _i48.IsLoggedInUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i188.LoginUseCase>(
    () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i48.LogoutUseCase>(
    () => _i48.LogoutUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i941.RegisterUseCase>(
    () => _i941.RegisterUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i955.IsTokenValidUseCase>(
    () => _i955.IsTokenValidUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i157.RefreshTokenUseCase>(
    () => _i157.RefreshTokenUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i303.RefreshUserPermissionsUseCase>(
    () => _i303.RefreshUserPermissionsUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i834.GetQualityControlOrdersUseCase>(
    () => _i834.GetQualityControlOrdersUseCase(
      gh<_i1046.QualityControlOrderRepository>(),
    ),
  );
  gh.factory<_i402.GetProductionOrdersUseCase>(
    () =>
        _i402.GetProductionOrdersUseCase(gh<_i537.ProductionOrderRepository>()),
  );
  gh.factory<_i530.SearchProductionOrdersUseCase>(
    () => _i530.SearchProductionOrdersUseCase(
      gh<_i537.ProductionOrderRepository>(),
    ),
  );
  gh.factory<_i629.AppRouter>(
    () => _i629.AppRouter(gh<_i955.IsTokenValidUseCase>()),
  );
  gh.factory<_i150.ProductionOrderBloc>(
    () => _i150.ProductionOrderBloc(
      gh<_i402.GetProductionOrdersUseCase>(),
      gh<_i530.SearchProductionOrdersUseCase>(),
    ),
  );
  gh.singleton<_i797.AuthBloc>(
    () => _i797.AuthBloc(
      gh<_i188.LoginUseCase>(),
      gh<_i941.RegisterUseCase>(),
      gh<_i48.LogoutUseCase>(),
      gh<_i17.GetCurrentUserUseCase>(),
      gh<_i955.IsTokenValidUseCase>(),
      gh<_i157.RefreshTokenUseCase>(),
    ),
  );
  gh.factory<_i366.QualityControlOrderBloc>(
    () => _i366.QualityControlOrderBloc(
      gh<_i834.GetQualityControlOrdersUseCase>(),
    ),
  );
  return getIt;
}
