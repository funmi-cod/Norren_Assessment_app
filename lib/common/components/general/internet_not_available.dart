import 'package:flutter/material.dart';
import 'package:norrenberger_app/common/constant/text_constant.dart';
import 'package:norrenberger_app/common/constant/util.dart';
import 'package:norrenberger_app/common/themes/app_colors.dart';
import 'package:norrenberger_app/helpers/styles.dart';

class InternetNotAvailable extends StatelessWidget {
  const InternetNotAvailable({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: scaledWidth(context),
      color: AppColors.primaryRed,
      child: Center(
          child: Styles.medium(TextLiterals.noInternet,
              color: AppColors.white, fontSize: scaledFontSize(12, context))),
    );
  }
}
