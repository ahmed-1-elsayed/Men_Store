import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';

part 'login_dart_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final Dio dio = Dio();

  final TextEditingController userEmailController = TextEditingController();

  final TextEditingController userPasswordController = TextEditingController();

  Future<void> login() async {
    try {
      emit(LoginLoading());

      final Response response = await dio.post(
        "https://api.escuelajs.co/api/v1/auth/login",
        data: {
          "email": userEmailController.text.trim(),
          "password": userPasswordController.text.trim(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final UserModel user = UserModel.fromJson(response.data);

        emit(LoginSuccess(user));
      } else {
        emit(LoginFailure("loginFailed"));
      }
    } on DioException catch (e) {
      emit(
        LoginFailure(
          e.response?.data["message"]?.toString() ??
              e.message ??
              "networkError",
        ),
      );
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    userEmailController.dispose();
    userPasswordController.dispose();
    return super.close();
  }
}
