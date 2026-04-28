import '../../domain/entities/login_credentials.dart';

abstract class LoginRemoteDataSource {
  Future<bool> authenticate(LoginCredentials credentials);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  @override
  Future<bool> authenticate(LoginCredentials credentials) async {
    await Future.delayed(const Duration(milliseconds: 850));

    return credentials.email == 'test@example.com' &&
        credentials.password == 'password123';
  }
}
