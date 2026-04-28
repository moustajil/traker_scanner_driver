import '../../domain/entities/login_credentials.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  const LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<bool> login(LoginCredentials credentials) {
    return remoteDataSource.authenticate(credentials);
  }
}
