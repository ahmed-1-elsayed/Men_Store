import 'package:easy_localization/easy_localization.dart';
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
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
                      const SizedBox(height: 15),
                      Text("createAccount".tr(), style: AppStyles.title),
                      const SizedBox(height: 8),
                      Text("signUpSubTitle".tr(), style: AppStyles.footer),
                      const SizedBox(height: 40),
                      Text("fullName".tr(), style: AppStyles.label),
                      const SizedBox(height: 8),
                      AppField(
                        controller: fullNameController,
                        hintText: "enterFullName".tr(),
                      ),
                      const SizedBox(height: 20),
                      Text("username".tr(), style: AppStyles.label),
                      const SizedBox(height: 8),
                      AppField(
                        controller: userNameController,
                        hintText: "enterUsername".tr(),
                      ),
                      const SizedBox(height: 20),
                      Text("password".tr(), style: AppStyles.label),
                      const SizedBox(height: 8),
                      AppPasswordField(
                        controller: passwordController,
                        hintText: "enterPassword".tr(),
                      ),
                      const SizedBox(height: 20),
                      Text("confirmPassword".tr(), style: AppStyles.label),
                      const SizedBox(height: 8),
                      AppPasswordField(
                        controller: confirmPasswordController,
                        hintText: "confirmYourPassword".tr(),
                      ),
                      const SizedBox(height: 32),
                      AppButton(text: "createAccount".tr(), onPressed: () {}),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${"alreadyHaveAccount".tr()} ",
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
                            child: Text(
                              "loginAction".tr(),
                              style: AppStyles.link,
                            ),
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
