import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:norrenberger_app/common/components/general/spacing.dart';
import 'package:norrenberger_app/common/constant/util.dart';
import 'package:norrenberger_app/common/themes/app_colors.dart';
import 'package:norrenberger_app/helpers/styles.dart';

class DefaultStateError extends StatelessWidget {
  final String msg;
  final double? baseHeight;
  final String buttonLabel;
  final Function()? onTapButton;
  const DefaultStateError(
      {Key? key,
      required this.msg,
      this.baseHeight,
      required this.buttonLabel,
      this.onTapButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: scaledHeight(context).h - (baseHeight! ?? 200.h),
      width: scaledWidth(context).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                msg,
                style: TextStyle(
                  fontSize: scaledFontSize(14.sp, context),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          VerticalSpacing(24.h),
          InkWell(
              onTap: onTapButton ?? () => Navigator.pop(context),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                    height: 50.h,
                    width: 200.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.primaryYellow,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Styles.bold(buttonLabel, color: Colors.white)),
              ))
        ],
      ),
    );
  }
}
