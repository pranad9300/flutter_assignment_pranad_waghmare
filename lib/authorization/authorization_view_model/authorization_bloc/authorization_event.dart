part of 'authorization_bloc.dart';

sealed class AuthorizationEvent {
  const AuthorizationEvent();
}

final class AppLogoutRequested extends AuthorizationEvent {
  const AppLogoutRequested();
}

final class _AppUserChanged extends AuthorizationEvent {
  const _AppUserChanged(this.user);

  final User user;
}
