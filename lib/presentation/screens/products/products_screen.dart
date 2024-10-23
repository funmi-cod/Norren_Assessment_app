import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:norrenberger_app/common/bottomsheet/sub_category_products.dart';
import 'package:norrenberger_app/common/components/empty_state.dart';
import 'package:norrenberger_app/common/components/general/default_error_state.dart';
import 'package:norrenberger_app/common/components/general/spacing.dart';
import 'package:norrenberger_app/common/constant/route_constant.dart';
import 'package:norrenberger_app/common/constant/text_constant.dart';
import 'package:norrenberger_app/common/constant/util.dart';
import 'package:norrenberger_app/common/themes/app_colors.dart';
import 'package:norrenberger_app/data/enums/view_state.dart';
import 'package:norrenberger_app/data/models/product_history.dart';
import 'package:norrenberger_app/helpers/styles.dart';
import 'package:norrenberger_app/helpers/utilities.dart';
import 'package:norrenberger_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchProductHistory();
    });
  }

  fetchProductHistory() async {
    ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    await productsProvider.fetchProductHistory();
  }

  Widget _mainContent() {
    return Consumer<ProductsProvider>(builder: (context, model, _) {
      if (model.productListViewState == ViewState.busy) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryYellow,
          ),
        );
      }

      if (model.productListViewState == ViewState.error) {
        return DefaultStateError(
          msg: model.errorMessage,
          buttonLabel: TextLiterals.tapToRetry,
          baseHeight: 150.h,
          onTapButton: () {
            fetchProductHistory();
          },
        );
      }

      if (model.productListViewState == ViewState.completed &&
          model.productHistory != null &&
          model.productHistory!.result!.isEmpty) {
        return EmptyState(message: TextLiterals.noProductYet);
      }

      if (model.productListViewState == ViewState.completed &&
          model.productHistory != null &&
          model.productHistory!.result!.isNotEmpty) {
        return Expanded(
          child: RefreshIndicator(
            color: AppColors.primaryYellow,
            onRefresh: () {
              return fetchProductHistory();
            },
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: model.productHistory?.result?.length,
                itemBuilder: (context, index) {
                  Result singleResult = model.productHistory!.result![index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: productContainer(singleResult),
                  );
                }),
          ),
        );
      }

      return const SizedBox.shrink();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryYellow,
        title: Styles.bold(TextLiterals.appName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              RouteLiterals.userLogin, (Route<dynamic> route) => false);
        },
        backgroundColor: AppColors.primaryYellow,
        tooltip: 'Log Out',
        child: const Icon(Iconsax.logout_14),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        child: SizedBox(
          width: scaledWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpacing(30.h),
              Styles.medium(TextLiterals.norrenProducts,
                  fontSize: scaledFontSize(16.sp, context)),
              VerticalSpacing(10.h),
              _mainContent()
            ],
          ),
        ),
      ),
    );
  }

  Widget productContainer(Result data) {
    return InkWell(
      onTap: () {
        if (data.subProduct != null && data.subProduct!.isNotEmpty) {
          showModalBottomSheet(
            context: context,
            elevation: 2.0,
            isDismissible: false,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.r),
                  topLeft: Radius.circular(10.r)),
            ),
            builder: (context) => SubCategoryProductsBottomsheet(
              data: data,
            ),
          );
        } else {
          Navigator.pushNamed(context, RouteLiterals.productDetails,
              arguments: data);
        }
      },
      child: Container(
        width: scaledWidth(context),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.r,
                  child: Styles.regular(data.productId ?? '',
                      fontSize: scaledFontSize(12.sp, context)),
                ),
                HorizontalSpacing(6.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Styles.medium(
                        data.productName ?? '',
                        fontSize: scaledFontSize(16.sp, context),
                      ),
                      VerticalSpacing(5.h),
                      Styles.regular(
                        data.description ?? '',
                        fontSize: 12.sp,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        lines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            VerticalSpacing(10.h),
            Styles.medium("${TextLiterals.currency}: ${data.currency}",
                fontSize: scaledFontSize(12.sp, context),
                color: AppColors.primaryGreen),
            VerticalSpacing(5.h),
            Styles.medium(
                "${TextLiterals.createdOn}:${Utilities.productDate(data.createdAt ?? DateTime.now())}",
                fontSize: scaledFontSize(12.sp, context),
                color: AppColors.grey95),
            VerticalSpacing(10.h),
          ],
        ),
      ),
    );
  }
}
