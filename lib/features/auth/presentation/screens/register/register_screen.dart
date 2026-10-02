import '../../../../../app/router/route_name.dart';
import '../../../../../core/core.dart';
import '../../bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      AppHaptics.error();
      return;
    }

    context.read<UserBloc>().add(
          RegisterSubmited(
            username: _usernameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserRegisterError) {
          AppAlerts.showError(context, state.message);
        } else if (state is UserRegisterSuccess) {
          AppAlerts.showSuccess(
            context,
            'Account registered successfully! Please login.',
          );
          context.goNamed(RouteName.login);
        }
      },
      builder: (context, state) {
        final theme = Theme.of(context);
        final isLoading = state is UserRegisterLoading;

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
                        // Header Icon
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person_add_outlined,
                            size: 32,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Create Account',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Fill in the details below to get started',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Username Field
                        AppTextField(
                          labelText: 'Username',
                          hintText: 'Choose a unique username',
                          controller: _usernameController,
                          prefixIcon: const Icon(Icons.person_outline_rounded),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (v) =>
                              AppValidators.required(v, fieldName: 'Username'),
                        ),
                        const SizedBox(height: 16),

                        // Email Field
                        AppTextField(
                          labelText: 'Email',
                          hintText: 'name@example.com',
                          controller: _emailController,
                          prefixIcon: const Icon(Icons.email_outlined),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: AppValidators.email,
                        ),
                        const SizedBox(height: 16),

                        // Password Field
                        AppTextField(
                          labelText: 'Password',
                          hintText: 'At least 6 characters',
                          controller: _passwordController,
                          isPassword: true,
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submit(),
                          validator: AppValidators.password,
                        ),
                        const SizedBox(height: 24),

                        // Register Button
                        AppButton(
                          label: 'CREATE ACCOUNT',
                          icon: const Icon(Icons.how_to_reg_rounded, size: 20),
                          isLoading: isLoading,
                          onPressed: _submit,
                        ),
                        const SizedBox(height: 20),

                        // Back to Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            TextButton(
                              onPressed: () => context.goNamed(RouteName.login),
                              child: const Text(
                                'Sign In',
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
