part of 'authorization_bloc.dart';

enum AuthorizationStatus {
  authenticated,
  unauthenticated,
}

final class AuthorizationState extends Equatable {
  const AuthorizationState._({
    required this.status,
    this.user = User.empty,
  });

  const AuthorizationState.authenticated(User user)
      : this._(status: AuthorizationStatus.authenticated, user: user);

  const AuthorizationState.unauthenticated()
      : this._(status: AuthorizationStatus.unauthenticated);

  final AuthorizationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
