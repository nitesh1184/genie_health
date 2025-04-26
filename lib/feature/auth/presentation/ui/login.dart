import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/Depenency_injections/app_injector.dart';
import '../../../common/user/cubit/user_cubit.dart';
import '../../../common/widgets/GenieAppProgressDialog.dart';
import '../../../common/widgets/app_genie_button.dart';
import '../../../common/widgets/genie_app_dialog.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  bool _obscurePassword = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFF0C7B79),
          resizeToAvoidBottomInset: true,
          body: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                showDialogBox(context, state.message);
              } else if (state is LoginLoading) {
                GenieAppProgressDialog(
                  text: 'Please wait, we are trying to sign you in...',
                );
              }
              else if(state is PasswordVisibility){
                _obscurePassword=state.visibility;
              }
              if (state is LoginSuccess) {
                context.read<UserCubit>().saveUser(state.data);
                Future.microtask(
                  () => context.go('/home'),
                ); // Navigate to HomeScreen
              }
            },
            builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text.rich(
                        TextSpan(
                          text: 'Dr. Raju\'s\n',
                          style: const TextStyle(
                            color: Color(0xFFB1E63D),
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                          children: [
                            TextSpan(
                              text: 'Digital Health',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage(
                          'assets/images/doctors_team.jpg',
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: const Text(
                                'Welcome Back !',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Align(
                              alignment: Alignment.topCenter,
                              child: const Text(
                                'Sign in to continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black45,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'UserName',
                                border: OutlineInputBorder(),
                              ),
                              controller: emailController,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed:
                                      () => {
                                        context
                                            .read<LoginCubit>()
                                            .togglePasswordVisibility(
                                              _obscurePassword,
                                            ),
                                      },
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(value: false, onChanged: (_) {}),
                                    const Text('Remember me'),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('Forgot Password?'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: AppGenieButton(
                                onPressed:
                                    () => {
                                      context.read<LoginCubit>().login(
                                        emailController.text,
                                        passwordController.text,
                                      ),
                                    },
                                buttonText: 'Login',
                                backgroundColor: const Color(0xFF0C7B79),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void showDialogBox(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return GenieAppDialog(title: 'What goes Wrong...', message: message);
      },
    );
  }
}
