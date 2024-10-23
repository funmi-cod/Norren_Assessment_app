import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:norrenberger_app/common/themes/app_colors.dart';

class CustomDropdownButton extends StatelessWidget {
  final String selectedText;
  final String title;
  final Icon? icon;
  final double height;
  double? imgWidth;
  double? imgHeight;
  String? path;
  double? width;
  final bool? enable;
  //  final Color? iconColor;
  final Function onChanged;
  CustomDropdownButton(
      {required this.title,
      this.selectedText = "",
      required this.onChanged,
      this.icon,
      this.height = 58,
      this.width,
      this.path,
      this.imgHeight,
      this.imgWidth,
      this.enable,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged();
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryGray,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(),
              Text(
                selectedText == "" ? title : selectedText,
                style: TextStyle(
                    color: selectedText == ""
                        ? AppColors.grey22.withOpacity(0.4)
                        : AppColors.black),
              ),
              const Spacer(),
              enable == false
                  ? const SizedBox.shrink()
                  : const Icon(
                      Iconsax.arrow_down5,
                      color: AppColors.primaryYellow,
                    )
              //icon!
            ],
          ),
        ),
      ),
    );
  }
}
