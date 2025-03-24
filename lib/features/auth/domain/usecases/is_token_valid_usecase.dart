import 'package:injectable/injectable.dart';
import 'package:sync_ops/features/auth/domain/repositories/auth_repository.dart';

@injectable
class IsTokenValidUseCase {
  final AuthRepository repository;

  IsTokenValidUseCase(this.repository);

  Future<bool> call() {
    return repository.isTokenValid();
  }
}
