import '../entities/login_credentials.dart';
import '../repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  const LoginUseCase(this.repository);

  Future<bool> call(LoginCredentials credentials) {
    return repository.login(credentials);
  }
}
