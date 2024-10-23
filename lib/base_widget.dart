// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:norrenberger_app/common/components/general/internet_not_available.dart';
import 'package:norrenberger_app/common/components/general/spacing.dart';
import 'package:provider/provider.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;
  const BaseWidget({required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Visibility(
            visible: Provider.of<InternetConnectionStatus>(context) ==
                InternetConnectionStatus.disconnected,
            child: Column(
              children: [
                VerticalSpacing(20),
                const InternetNotAvailable(),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
