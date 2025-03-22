import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/Depenency_injections/app_injector.dart';
import '../../../common/user/cubit/user_cubit.dart';
import '../../../common/widgets/app_genie_button.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text('Genie Health'),
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),
          body: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is LoginSuccess) {
                context.read<UserCubit>().saveUser(state.data);
                Future.microtask(
                  () => context.push('/home'),
                ); // Navigate to HomeScreen
              }
            },
            builder: (context, state) {
              return Column( // Column to ensure footer stays at the bottom
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 40), // Adds spacing from top
                            Image.asset(
                              'assets/images/karnataka_logo.png',
                              height: 96,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Welcome to Genie Health',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 30),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                              ),
                              controller: emailController,
                            ),
                            SizedBox(height: 10),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                              controller: passwordController,
                            ),
                            SizedBox(height: 20),
                            state is LoginLoading
                                ? CircularProgressIndicator()
                                : AppGenieButton(
                              onPressed: () =>
                              {

                                context.read<LoginCubit>().login(
                                emailController.text,
                                passwordController.text,
                              ),
                              },
                              buttonText: 'Login',
                              backgroundColor: Colors.blue,
                            ),
                            SizedBox(height: 60), // Extra spacing before footer
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Footer Section (Stays at Bottom)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Powered by'),
                        Image.asset(
                          'assets/images/buildgenie_logo.png',
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
