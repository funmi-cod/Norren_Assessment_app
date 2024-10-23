import 'package:flutter/material.dart';

class VerticalSpacing extends StatelessWidget {
  final double value;
  VerticalSpacing(this.value);
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: value);
  }
}

class HorizontalSpacing extends StatelessWidget {
  final double value;
  HorizontalSpacing(this.value);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: value);
  }
}
