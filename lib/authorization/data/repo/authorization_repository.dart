import '../datasources/authorization_local_data_source.dart';
import '../datasources/authorization_remote_data_source.dart';
import '../models/user.dart';

class AuthorizationRepository {
  AuthorizationRepository({
    required AuthorizationLocalDataSource localDataSource,
    required AuthorizationRemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;
  final AuthorizationLocalDataSource _localDataSource;
  final AuthorizationRemoteDataSource _remoteDataSource;

  User getCurrentUser() => _localDataSource.getCurrentUser();

  Future<void> cacheAppUser(User appUser) async =>
      await _localDataSource.cacheCurrentUser(appUser);

  Future<void> login({required String email, required String password}) async =>
      await _remoteDataSource.login(email: email, password: password);

  Future<void> logout() async => await _remoteDataSource.logout();
}
