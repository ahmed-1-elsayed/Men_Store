import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mens_store/features/Sign_up/view.dart';

import '../../core/helper/app_field.dart';
import '../../core/helper/app_password_field.dart';
import '../../core/helper/app_style.dart';
import '../../core/helper/app_tost.dart';
import '../home_nav/view.dart';
import '../widgets/app_button.dart';
import 'login_dart_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            showSnackBar(
              context: context,
              msg: state.msg,
              type: AnimatedSnackBarType.error,
            );
          }

          if (state is LoginSuccess) {
            showSnackBar(
              context: context,
              msg: "Login Successfully",
              type: AnimatedSnackBarType.success,
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Navbar()),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Text("Login to your account", style: AppStyles.title),
                          const SizedBox(height: 8),
                          Text(
                            "It's great to see you again",
                            style: AppStyles.footer,
                          ),
                          const SizedBox(height: 40),
                          Text("Email", style: AppStyles.label),
                          const SizedBox(height: 8),
                          AppField(
                            controller: cubit.userEmailController,
                            hintText: "Enter your email",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 24),
                          Text("Password", style: AppStyles.label),
                          const SizedBox(height: 8),
                          AppPasswordField(
                            controller: cubit.userPasswordController,
                            hintText: "Enter your password",
                          ),
                          const SizedBox(height: 35),
                          state is LoginLoading
                              ? const Center(child: CircularProgressIndicator())
                              : AppButton(
                                  text: "Sign In",
                                  onPressed: () {
                                    if (cubit.userEmailController.text
                                            .trim()
                                            .isEmpty ||
                                        cubit.userPasswordController.text
                                            .trim()
                                            .isEmpty) {
                                      showSnackBar(
                                        context: context,
                                        msg: "Please fill all fields",
                                        type: AnimatedSnackBarType.warning,
                                      );
                                      return;
                                    }
                                    cubit.login();
                                  },
                                ),
                         SizedBox(height: 360,),

                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: AppStyles.footer,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: Text("Join", style: AppStyles.link),
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
          );
        },
      ),
    );
  }
}
