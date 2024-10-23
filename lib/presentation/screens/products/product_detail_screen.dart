import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:norrenberger_app/common/components/general/spacing.dart';
import 'package:norrenberger_app/common/constant/text_constant.dart';
import 'package:norrenberger_app/common/constant/util.dart';
import 'package:norrenberger_app/common/themes/app_colors.dart';
import 'package:norrenberger_app/data/models/product_history.dart';
import 'package:norrenberger_app/helpers/styles.dart';
import 'package:norrenberger_app/helpers/utilities.dart';

class ProductDetailScreen extends StatelessWidget {
  Result? data;
  ProductDetailScreen({this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      color: AppColors.white,
      padding: EdgeInsets.only(
        top: 20.r,
      ),
      width: scaledWidth(context).w,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          VerticalSpacing(10.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  alignment: Alignment.center,
                  height: 44.h,
                  width: 44.w,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.10),
                        blurRadius: 7,
                        spreadRadius: 3,
                      )
                    ],
                  ),
                  child: const Icon(Iconsax.arrow_left4),
                ),
              ),
              const Spacer(),
              Styles.semiBold(
                TextLiterals.details,
                fontSize: scaledFontSize(18.sp, context),
              ),
              HorizontalSpacing(20.w),
              const Spacer(),
            ],
          ),
          VerticalSpacing(50.h),
          productContainer(context),
          VerticalSpacing(100.h),
        ],
      ),
    )));
  }

  Widget productContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30.r,
            child: Styles.regular(data?.productId ?? '',
                fontSize: scaledFontSize(12.sp, context)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Styles.medium(
                data?.productName ?? '',
                fontSize: scaledFontSize(16.sp, context),
              ),
              VerticalSpacing(10.h),
              Styles.regular(data?.description ?? '',
                  softWrap: true, fontSize: scaledFontSize(14.sp, context)),
              VerticalSpacing(10.h),
              RichText(
                text: TextSpan(
                  children: [
                    Styles.spanBold("${TextLiterals.features}: ",
                        fontSize: scaledFontSize(12.sp, context)),
                    Styles.spanRegular(data?.features ?? '',
                        color: AppColors.transparentBlack,
                        fontSize: scaledFontSize(13.sp, context)),
                  ],
                ),
              )
            ],
          ),
          VerticalSpacing(10.h),
          Styles.medium(
              "${TextLiterals.minFund}:${Utilities.productAmount(currency: data?.currency ?? '', amount: data?.minFund?.toDouble() ?? 0.0)}",
              fontSize: scaledFontSize(12.sp, context),
              color: AppColors.primaryGreen),
          VerticalSpacing(5.h),
          Styles.medium(
              "${TextLiterals.minWithdrawal}:${Utilities.productAmount(currency: data?.currency ?? '', amount: data?.minWithrawal?.toDouble() ?? 0.0)}",
              fontSize: scaledFontSize(12.sp, context),
              color: AppColors.grey95),
          VerticalSpacing(10.h),
        ],
      ),
    );
  }
}
