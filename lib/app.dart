import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_pranad/authorization/authorization_view_model/authorization_bloc/authorization_bloc.dart';
import 'package:flutter_assignment_pranad/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authorization/data/repo/authorization_repository.dart';
import 'authorization/views/login_page.dart';
import 'home.dart';

class App extends StatelessWidget {
  const App({
    required AuthorizationRepository authorizationRepository,
    super.key,
  }) : _authorizationRepository = authorizationRepository;

  final AuthorizationRepository _authorizationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authorizationRepository,
      child: BlocProvider(
        create: (_) => AuthorizationBloc(
          authorizationRepository: _authorizationRepository,
          firebaseAuth: FirebaseAuth.instance,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  List<Page<dynamic>> _onGenerateAppViewPages(
      AuthorizationStatus status, List<Page<dynamic>> pages) {
    switch (status) {
      case AuthorizationStatus.authenticated:
        return [HomePage.page()];
      case AuthorizationStatus.unauthenticated:
        return [LoginPage.page()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: FlowBuilder<AuthorizationStatus>(
        state: context.select((AuthorizationBloc bloc) => bloc.state.status),
        onGeneratePages: _onGenerateAppViewPages,
      ),
    );
  }
}
