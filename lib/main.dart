import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_assignment_pranad/authorization/data/datasources/authorization_local_data_source.dart';
import 'package:flutter_assignment_pranad/authorization/data/datasources/authorization_remote_data_source.dart';
import 'package:flutter_assignment_pranad/authorization/data/repo/authorization_repository.dart';
import 'package:flutter_assignment_pranad/bloc_obsserver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // inject Dependencies
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  // authorization
  final AuthorizationLocalDataSource authorizationLocalDataSource =
      AuthorizationLocalDataSource(sharedPreferences: sharedPreferences);
  final AuthorizationRemoteDataSource authorizationRemoteDataSource =
      AuthorizationRemoteDataSource(firebaseAuth: FirebaseAuth.instance);
  final authorizationRepository = AuthorizationRepository(
      localDataSource: authorizationLocalDataSource,
      remoteDataSource: authorizationRemoteDataSource);

  runApp(App(authorizationRepository: authorizationRepository));
}
