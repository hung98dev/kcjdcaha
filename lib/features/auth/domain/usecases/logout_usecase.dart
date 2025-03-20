import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:sync_ops/core/errors/failures.dart';
import 'package:sync_ops/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.logout();
  }
}
