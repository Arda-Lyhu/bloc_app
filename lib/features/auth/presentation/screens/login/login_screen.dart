import '../../../../../app/router/route_name.dart';
import '../../../../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/user_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      AppHaptics.error();
      return;
    }

    context.read<UserBloc>().add(
          LoginSubmited(
            username: _usernameController.text.trim(),
            password: _passwordController.text,
          ),
        );
  }

  void _fillTestCredentials(String username, String password) {
    AppHaptics.selection();
    _usernameController.text = username;
    _passwordController.text = password;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoginError) {
          AppAlerts.showError(context, state.message);
        } else if (state is UserLoginSuccess) {
          AppHaptics.success();
          context.goNamed(RouteName.mainShell);
        }
      },
      builder: (context, state) {
        final isLoading = state is UserLoginLoading;

        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header Icon & Title
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            size: 32,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Welcome Back',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in to continue exploring products',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Username Field
                        AppTextField(
                          controller: _usernameController,
                          labelText: 'Username',
                          hintText: 'e.g. emilys',
                          prefixIcon: const Icon(Icons.person_outline_rounded),
                          textInputAction: TextInputAction.next,
                          validator: (v) =>
                              AppValidators.required(v, fieldName: 'Username'),
                        ),
                        const SizedBox(height: 16),

                        // Password Field
                        AppTextField(
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          isPassword: true,
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          textInputAction: TextInputAction.done,
                          validator: AppValidators.password,
                          onFieldSubmitted: (_) => _submit(context),
                        ),
                        const SizedBox(height: 12),

                        // Quick Test User Fill Chips
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Test Accounts:',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            ActionChip(
                              label: const Text('emilys'),
                              visualDensity: VisualDensity.compact,
                              onPressed: () =>
                                  _fillTestCredentials('emilys', 'emilyspass'),
                            ),
                            ActionChip(
                              label: const Text('michaelw'),
                              visualDensity: VisualDensity.compact,
                              onPressed: () => _fillTestCredentials(
                                  'michaelw', 'michaelwpass'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Login Button
                        AppButton(
                          label: 'SIGN IN',
                          icon: const Icon(Icons.login_rounded, size: 20),
                          isLoading: isLoading,
                          onPressed: () => _submit(context),
                        ),
                        const SizedBox(height: 20),

                        // Register Navigation
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  context.pushNamed(RouteName.register),
                              child: const Text(
                                'Register',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
