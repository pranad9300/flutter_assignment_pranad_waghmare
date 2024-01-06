import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../data/models/user.dart';
import '../../data/repo/authorization_repository.dart';
part 'authorization_event.dart';
part 'authorization_sate.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc({
    required AuthorizationRepository authorizationRepository,
    required firebase_auth.FirebaseAuth firebaseAuth,
  })  : _authorizationRepository = authorizationRepository,
        _firebaseAuth = firebaseAuth,
        super(
          authorizationRepository.getCurrentUser().isNotEmpty
              ? AuthorizationState.authenticated(
                  authorizationRepository.getCurrentUser())
              : const AuthorizationState.unauthenticated(),
        ) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription =
        _firebaseAuth.authStateChanges().map<User>((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      return user;
    }).listen((user) {
      unawaited(_authorizationRepository.cacheAppUser(user));
      add(_AppUserChanged(user));
    });
  }

  final AuthorizationRepository _authorizationRepository;
  late final StreamSubscription<User> _userSubscription;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  void _onUserChanged(_AppUserChanged event, Emitter<AuthorizationState> emit) {
    emit(
      event.user.isNotEmpty
          ? AuthorizationState.authenticated(event.user)
          : const AuthorizationState.unauthenticated(),
    );
  }

  void _onLogoutRequested(
    AppLogoutRequested event,
    Emitter<AuthorizationState> emit,
  ) {
    unawaited(_authorizationRepository.logout());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}

extension on firebase_auth.User {
  /// Maps a [firebase_auth.User] into a [User].
  User get toUser {
    return User(
      id: uid,
      email: email,
      name: displayName,
    );
  }
}
