import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'assets.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key, this.size = 120});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "loading".tr(),
      child: Lottie.asset(
        AppAssets.loading,
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}

class LoadingHelper {
  LoadingHelper._();

  static Widget centered({double size = 120}) {
    return Center(child: AppLoading(size: size));
  }
}
