import 'package:flutter/material.dart';
import 'package:mens_store/core/helper/app_colors.dart';
import 'package:mens_store/core/helper/app_field.dart';
import 'package:mens_store/core/helper/app_password_field.dart';
import 'package:mens_store/core/helper/app_style.dart';
import 'package:mens_store/features/sign_in/view.dart';

import '../widgets/app_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15,),
                      Text('Create Account', style: AppStyles.title),

                      const SizedBox(height: 8),

                      Text('Let’s create your account.', style: AppStyles.footer),

                      const SizedBox(height: 40),

                      Text('Full Name', style: AppStyles.label),
                      const SizedBox(height: 8),
                      AppField(
                        controller: fullNameController,
                        hintText: 'Enter your full name',
                      ),

                      const SizedBox(height: 20),

                      Text('Username', style: AppStyles.label),
                      const SizedBox(height: 8),
                      AppField(
                        controller: userNameController,
                        hintText: 'Enter your username',
                      ),

                      const SizedBox(height: 20),

                      Text('Password', style: AppStyles.label),
                      const SizedBox(height: 8),
                      AppPasswordField(
                        controller: passwordController,
                        hintText: 'Enter your password',
                      ),

                      const SizedBox(height: 20),

                      Text('Confirm Password', style: AppStyles.label),
                      const SizedBox(height: 8),
                      AppPasswordField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm your password',
                      ),

                      const SizedBox(height: 32),

                      AppButton(text: 'Create Account', onPressed: () {}),

                      const Spacer(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: AppStyles.footer,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginView(),
                                ),
                              );
                            },
                            child: Text("Login", style: AppStyles.link),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
