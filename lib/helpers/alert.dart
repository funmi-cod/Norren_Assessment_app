import 'package:flutter/material.dart';
import 'package:norrenberger_app/common/themes/app_colors.dart';
import 'package:norrenberger_app/main.dart';

class AlertToast {
  final context;
  final int? duration;
  const AlertToast({Key? key, required this.context, this.duration});

  showSuccess(text) {
    final snackbar = SnackBar(
        duration: Duration(seconds: duration ?? 5),
        content: Text(text),
        action: SnackBarAction(
            label: "OK",
            onPressed: (() {
              ScaffoldMessenger.of(context ?? navigatorKey.currentContext)
                  .hideCurrentSnackBar();
            })),
        backgroundColor: AppColors.primaryGreen);
    ScaffoldMessenger.of(context ?? navigatorKey.currentContext)
        .showSnackBar(snackbar);
    // scaffold.currentState.showSnackBar(snackbar);
  }

  showNeautral(text) {
    final snackbar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
          label: "OK",
          onPressed: (() {
            ScaffoldMessenger.of(context ?? navigatorKey.currentContext)
                .hideCurrentSnackBar();
          })),
    );
    ScaffoldMessenger.of(context ?? navigatorKey.currentContext)
        .showSnackBar(snackbar);
  }

  showError(text) {
    final snackbar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
          label: "OK",
          onPressed: (() {
            ScaffoldMessenger.of(context ?? navigatorKey.currentContext)
                .hideCurrentSnackBar();
          })),
      backgroundColor: AppColors.primaryRed,
      duration: Duration(seconds: duration ?? 5),
    );
    ScaffoldMessenger.of(context ?? navigatorKey.currentContext)
        .showSnackBar(snackbar);
  }

  showTripError(text, context) {
    final snackbar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
          label: "OK",
          onPressed: (() {
            ScaffoldMessenger.of(context ?? navigatorKey.currentContext)
                .hideCurrentSnackBar();
          })),
      backgroundColor: AppColors.primaryRed,
      duration: Duration(seconds: duration ?? 5),
    );
    ScaffoldMessenger.of(context ?? navigatorKey.currentContext)
        .showSnackBar(snackbar);
  }
}
