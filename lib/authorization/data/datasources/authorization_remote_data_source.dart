import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../utils/failures.dart';

class AuthorizationRemoteDataSource {
  AuthorizationRemoteDataSource({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  /// Instance of [FirebaseAuth] to handle sign in and sign out operations.
  final FirebaseAuth _firebaseAuth;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on SocketException {
      throw InternetFailure();
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on SocketException {
      throw InternetFailure();
    } catch (e) {
      throw LogOutFailure();
    }
  }
}
