import 'package:injectable/injectable.dart';
import 'package:sync_ops/features/auth/domain/repositories/auth_repository.dart';

@injectable
class IsLoggedInUseCase {
  final AuthRepository repository;

  IsLoggedInUseCase(this.repository);

  Future<bool> call() {
    return repository.isLoggedIn();
  }
}
