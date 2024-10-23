import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:norrenberger_app/common/constant/text_constant.dart';
import 'package:norrenberger_app/common/constant/util.dart';
import 'package:norrenberger_app/common/themes/app_colors.dart';

class TimerCounter extends StatelessWidget {
  final String count;
  const TimerCounter({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r), color: AppColors.lightGray),
      padding: EdgeInsets.all(10.r),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
            text: TextLiterals.resendCode,
            style: TextStyle(
                color: AppColors.mediumGray,
                height: 1.6.h,
                fontSize: scaledFontSize(14.sp, context)),
            children: [
              TextSpan(
                  text: " ${count.toString()}s",
                  style: const TextStyle(
                      color: AppColors.black, fontWeight: FontWeight.w700)),
            ]),
      ),
    );
  }
}
