import '../entities/login_credentials.dart';

abstract class LoginRepository {
  Future<bool> login(LoginCredentials credentials);
}
