import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helper/app_field.dart';
import '../../core/helper/app_password_field.dart';
import '../../core/helper/app_style.dart';
import '../../core/helper/app_tost.dart';
import '../../core/helper/loading_helper.dart';
import '../home_nav/view.dart';
import '../widgets/app_button.dart';
import '../Sign_up/view.dart';
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
            final message =
                state.msg == "loginFailed" || state.msg == "networkError"
                ? state.msg.tr()
                : state.msg;

            showSnackBar(
              context: context,
              msg: message,
              type: AnimatedSnackBarType.error,
            );
          }

          if (state is LoginSuccess) {
            showSnackBar(
              context: context,
              msg: "loginSuccess".tr(),
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
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),

                            Text("loginTitle".tr(), style: AppStyles.title),

                            const SizedBox(height: 8),

                            Text("loginSubTitle".tr(), style: AppStyles.footer),

                            const SizedBox(height: 40),

                            Text("email".tr(), style: AppStyles.label),

                            const SizedBox(height: 8),

                            AppField(
                              controller: cubit.userEmailController,
                              hintText: "enterEmail".tr(),
                              keyboardType: TextInputType.emailAddress,
                            ),

                            const SizedBox(height: 24),

                            Text("password".tr(), style: AppStyles.label),

                            const SizedBox(height: 8),

                            AppPasswordField(
                              controller: cubit.userPasswordController,
                              hintText: "enterPassword".tr(),
                            ),

                            const SizedBox(height: 35),

                            state is LoginLoading
                                ? LoadingHelper.centered(size: 96)
                                : AppButton(
                                    text: "login".tr(),
                                    onPressed: () {
                                      if (cubit.userEmailController.text
                                              .trim()
                                              .isEmpty ||
                                          cubit.userPasswordController.text
                                              .trim()
                                              .isEmpty) {
                                        showSnackBar(
                                          context: context,
                                          msg: "pleaseFill".tr(),
                                          type: AnimatedSnackBarType.warning,
                                        );
                                        return;
                                      }

                                      cubit.login();
                                    },
                                  ),

                            const Spacer(),

                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "dontHaveAccount".tr(),
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
                                    child: Text(
                                      "join".tr(),
                                      style: AppStyles.link,
                                    ),
                                  ),
                                ],
                              ),
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
        },
      ),
    );
  }
}
