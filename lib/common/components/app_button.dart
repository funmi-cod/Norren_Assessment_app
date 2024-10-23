import 'package:flutter/material.dart';
import 'package:norrenberger_app/common/components/app_widget.dart';
import 'package:norrenberger_app/common/components/general/spacing.dart';
import 'package:norrenberger_app/common/themes/app_colors.dart';

class AppButton extends StatelessWidget {
  final bool enabled;
  final String text;
  final IconData? icon;
  final IconData? endIcon;
  final Function()? onPressed;
  final backgroundColor;
  final fontColor;
  final fontWeight;
  final borderColor;
  final iconColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final mainAxisAlignment;
  final BorderRadiusGeometry? borderRadius;
  final double? height;
  final double? iconSize;
  final double? width;
  final bool isLoading;
  AppButton({
    required this.text,
    this.enabled = false,
    this.fontWeight,
    this.icon,
    this.onPressed,
    this.backgroundColor,
    this.fontColor,
    this.borderColor,
    this.iconColor,
    this.fontSize,
    this.padding,
    this.margin,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.height,
    this.borderRadius,
    this.isLoading = false,
    this.width,
    this.endIcon,
    this.iconSize,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height ?? 45,
      width: width,
      child: TextButton(
          onPressed: enabled ? onPressed : null,
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  padding ?? EdgeInsets.symmetric(horizontal: 16)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                side: enabled
                    ? BorderSide(
                        color: borderColor ??
                            backgroundColor ??
                            Theme.of(context).primaryColor)
                    : BorderSide(color: Colors.grey.withOpacity(.6)),
                borderRadius: borderRadius ?? BorderRadius.circular(10.0),
              )),
              backgroundColor: MaterialStateProperty.all(
                  enabled ? backgroundColor : Colors.grey.withOpacity(.6))),
          child: isLoading
              ? Center(
                  child: AppWidget.loadingIndicator(color: AppColors.white))
              : FittedBox(
                  child: Row(
                    mainAxisAlignment: mainAxisAlignment,
                    children: [
                      if (icon != null)
                        Row(
                          children: [
                            HorizontalSpacing(3),
                            Icon(
                              icon,
                              color: iconColor ?? AppColors.black,
                              size: iconSize ?? 40,
                            ),
                          ],
                        ),
                      HorizontalSpacing(8),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          text,
                          style: TextStyle(
                            color: enabled
                                ? fontColor ?? AppColors.black
                                : AppColors.white,
                            fontSize: fontSize ??
                                13 * MediaQuery.of(context).textScaleFactor,
                            fontWeight: fontWeight ?? FontWeight.normal,
                          ),
                        ),
                      ),
                      if (endIcon != null)
                        Row(
                          children: [
                            HorizontalSpacing(3),
                            Icon(
                              endIcon,
                              size: 40,
                              color: AppColors.black,
                            ),
                          ],
                        )
                    ],
                  ),
                )),
    );
  }
}
