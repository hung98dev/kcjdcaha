import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sync_ops/core/errors/failures.dart';
import 'package:sync_ops/features/auth/domain/entities/user.dart';
import 'package:sync_ops/features/auth/domain/repositories/auth_repository.dart';

@injectable
class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  Future<Either<Failure, User>> call() {
    return repository.refreshToken();
  }
}
