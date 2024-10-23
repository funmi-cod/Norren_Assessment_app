import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:norrenberger_app/common/components/general/spacing.dart';
import 'package:norrenberger_app/common/constant/route_constant.dart';
import 'package:norrenberger_app/common/constant/text_constant.dart';

import 'package:norrenberger_app/common/constant/util.dart';
import 'package:norrenberger_app/common/themes/app_colors.dart';
import 'package:norrenberger_app/data/models/product_history.dart';
import 'package:norrenberger_app/helpers/styles.dart';
import 'package:norrenberger_app/helpers/utilities.dart';

class SubCategoryProductsBottomsheet extends StatefulWidget {
  Result data;
  SubCategoryProductsBottomsheet({required this.data, super.key});

  @override
  State<SubCategoryProductsBottomsheet> createState() =>
      _SubCategoryProductsBottomsheetState();
}

class _SubCategoryProductsBottomsheetState
    extends State<SubCategoryProductsBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.r), topLeft: Radius.circular(10.r)),
      child: SizedBox(
        height: scaledHeight(context).h / 1.8.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Center(
                    child: Styles.bold(TextLiterals.subProducts,
                        fontSize: scaledFontSize(16.sp, context)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Iconsax.close_circle5,
                      color: AppColors.primaryRed,
                    ),
                  )
                ],
              ),
              VerticalSpacing(20.h),
              Expanded(
                child: ListView.builder(
                    itemCount: widget.data.subProduct?.length,
                    itemBuilder: (context, index) {
                      SubProduct subProduct = widget.data.subProduct![index];
                      return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: DropdowmButton(
                            title: subProduct.title ?? '',
                            id: subProduct.productId ?? '',
                            date: Utilities.productDate(
                                subProduct.createdAt ?? DateTime.now()),
                            onChanged: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, RouteLiterals.subProductDetails,
                                  arguments: subProduct);
                            },
                          ));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DropdowmButton extends StatelessWidget {
  final String title;
  final String? selectedTitle;
  final Function onChanged;
  final String id;
  final String date;
  const DropdowmButton(
      {required this.title,
      required this.onChanged,
      this.selectedTitle,
      required this.id,
      required this.date,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.lightGray,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.r,
              child:
                  Styles.regular(id, fontSize: scaledFontSize(12.sp, context)),
            ),
            HorizontalSpacing(5.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Styles.medium(title,
                    color: selectedTitle == title
                        ? AppColors.black
                        : AppColors.mediumGray),
                VerticalSpacing(3.h),
                Styles.medium("${TextLiterals.createdOn}:$date",
                    fontSize: scaledFontSize(12.sp, context),
                    color: AppColors.grey95),
                VerticalSpacing(5.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
