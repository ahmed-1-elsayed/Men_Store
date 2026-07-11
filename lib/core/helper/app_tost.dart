

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String msg,
  required AnimatedSnackBarType type,
}) {
  AnimatedSnackBar.material(
    msg,
    type: type,
    mobileSnackBarPosition: MobileSnackBarPosition.top,
    duration: const Duration(seconds: 2),
  ).show(context);
}