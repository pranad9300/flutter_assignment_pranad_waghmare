import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../authorization_view_model/login_cubit/login_cubit.dart';
import '../data/repo/authorization_repository.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthorizationRepository>()),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
