import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mens_store/features/location/view.dart';

import 'features/home_nav/Controller/cart/cart_cubit.dart';
import 'features/sign_in/view.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CartCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
    );
  }
}