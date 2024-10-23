import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:norrenberger_app/common/constant/util.dart';
import 'package:norrenberger_app/common/themes/app_colors.dart';

class ProgressHUD extends StatelessWidget {
  final Widget? child;
  final bool? inAsyncCall;
  final double? opacity;
  final Color? color;
  final Animation<Color>? valueColor;

  const ProgressHUD({
    Key? key,
    @required this.child,
    @required this.inAsyncCall,
    this.opacity = 0,
    this.color = Colors.white,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child!);
    if (inAsyncCall!) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: 0.8,
            child: Container(
              width: scaledWidth(context).w,
              height: scaledHeight(context).h,
              color: AppColors.transparentBlack,
            ),
          ),
          const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryYellow,
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Scaffold(
      body: Stack(
        children: widgetList,
      ),
    );
  }
}
