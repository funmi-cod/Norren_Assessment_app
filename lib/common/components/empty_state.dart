import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:norrenberger_app/common/components/general/spacing.dart';
import 'package:norrenberger_app/common/constant/util.dart';
import 'package:norrenberger_app/common/themes/app_colors.dart';
import 'package:norrenberger_app/helpers/styles.dart';

class EmptyState extends StatelessWidget {
  String message;
  EmptyState({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: scaledWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VerticalSpacing(100.h),
          Styles.regular(message,
              fontSize: scaledFontSize(13.sp, context),
              color: AppColors.grey22.withOpacity(.87)),
        ],
      ),
    );
  }
}
