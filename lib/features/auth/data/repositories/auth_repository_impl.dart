import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sync_ops/core/errors/failures.dart';
import 'package:sync_ops/core/network/network_info.dart';
import 'package:sync_ops/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:sync_ops/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:sync_ops/features/auth/data/models/user_model.dart';
import 'package:sync_ops/features/auth/domain/entities/user.dart';
import 'package:sync_ops/features/auth/domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.login(email, password);
        await localDataSource.cacheUser(userModel);
        return Right(userModel.toEntity());
      } catch (e) {
        // Tạo user ảo khi không có kết nối mạng
        final offlineUser = UserModel(
          id: 'offline-${DateTime.now().millisecondsSinceEpoch}',
          email: email,
          fullName: 'Offline User',
          roles: [
            'admin',
            'manager',
            'user',
            'operator',
            'crm.customers.manage',
            'crm.leads.manage',
            'wms.inventory.manage',
            'wms.warehouses.manage',
            'mes.production.manage',
            'mes.quality.manage',
            'erp.finance.manage',
            'erp.hr.manage',
            'admin.users.manage',
            'admin.roles.manage',
            'admin.settings.manage',
            'account.all',
          ],
          isActive: true,
          createdAt: DateTime.now(),
          lastLogin: DateTime.now(),
        );
        await localDataSource.cacheUser(offlineUser);
        return Right(offlineUser.toEntity());
        //return Left(InvalidCredentialsFailure());
      }
    } else {
      // Tạo user ảo khi không có kết nối mạng
      final offlineUser = UserModel(
        id: 'offline-${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        fullName: 'Offline User',
        roles: [
          'admin',
          'manager',
          'user',
          'operator',
          'crm.customers.manage',
          'crm.leads.manage',
          'wms.inventory.manage',
          'wms.warehouses.manage',
          'mes.production.manage',
          'mes.quality.manage',
          'erp.finance.manage',
          'erp.hr.manage',
          'admin.users.manage',
          'admin.roles.manage',
          'admin.settings.manage',
          'account.all',
        ],
        isActive: true,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
      );
      await localDataSource.cacheUser(offlineUser);
      return Right(offlineUser.toEntity());
      //return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register(
    String email,
    String password,
    String fullName,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.register(
          email,
          password,
          fullName,
        );
        await localDataSource.cacheUser(userModel);
        return Right(userModel.toEntity());
      } catch (e) {
        return Left(EmailAlreadyInUseFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearUser();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final userModel = await localDataSource.getLastUser();
      if (userModel != null) {
        return Right(userModel.toEntity());
      } else {
        return const Right(null);
      }
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final user = await localDataSource.getLastUser();
      if (user == null) {
        return false;
      }
      // Kiểm tra token có hợp lệ không
      return await isTokenValid();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isTokenValid() async {
    return await localDataSource.isTokenValid();
  }

  @override
  Future<Either<Failure, User>> refreshToken() async {
    try {
      final user = await localDataSource.getLastUser();
      if (user == null || user.token == null) {
        return Left(InvalidCredentialsFailure());
      }

      if (await networkInfo.isConnected) {
        try {
          final userModel = await remoteDataSource.refreshToken(user.token!);
          await localDataSource.cacheUser(userModel);
          return Right(userModel.toEntity());
        } catch (e) {
          return Left(ServerFailure());
        }
      } else {
        return Left(NetworkFailure());
      }
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.forgotPassword(email);
        return const Right(null);
      } catch (e) {
        return Left(UserNotFoundFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.changePassword(oldPassword, newPassword);
        return const Right(null);
      } catch (e) {
        return Left(InvalidCredentialsFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
