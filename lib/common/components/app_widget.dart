import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:norrenberger_app/common/themes/app_colors.dart';

class AppWidget {
  static Widget loadingIndicator({double? radius, Color? color}) {
    return SizedBox(
      height: radius ?? 25,
      width: radius ?? 25,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        backgroundColor: color ?? Colors.transparent,
      ),
    );
  }

  static TextStyle userInputStyle() =>
      TextStyle(color: AppColors.grey22.withOpacity(0.4), fontSize: 15.sp);

  static Widget buildUserInput(
      {String? hint,
      bool moreLines = false,
      String? labelText,
      TextAlign textAlign = TextAlign.start,
      Function(String? val)? onSaved,
      String? Function(String? val)? validate,
      Function(String val)? onChanged,
      TextInputType? keyboardType,
      BorderRadius borderRadius = BorderRadius.zero,
      TextEditingController? controller,
      String? initialValue,
      String? errorText,
      Widget? suffixIcon,
      Widget? suffix,
      Widget? prefixIcon,
      Widget? prefix,
      bool hasBorder = true,
      EdgeInsetsGeometry? contentPadding,
      bool filled = false,
      bool enabled = true,
      Color? fillColor,
      Color? enabledBorderColor,
      Color? focusedBorderColor,
      Color? color,
      double? width,
      TextStyle? style,
      TextStyle? hintStyle,
      int maxLines = 1,
      List<TextInputFormatter>? inputFormatters,
      TextInputAction? textInputAction,
      bool obscureText = false}) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.primaryGray,
      ),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        enabled: enabled,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validate,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textAlign: textAlign,
        maxLines: moreLines == true ? null : 1,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        cursorColor: AppColors.transparentBlack,
        style: style ?? TextStyle(),
        decoration: InputDecoration(
          contentPadding: contentPadding,
          filled: filled,
          fillColor: fillColor,
          errorText: errorText,
          hintText: hint,
          labelText: labelText,
          suffixIcon: suffixIcon,
          suffix: suffix,
          prefix: prefix,
          prefixIcon: prefixIcon,
          prefixIconColor: AppColors.black,
          labelStyle: userInputStyle(),
          hintStyle: hintStyle ?? userInputStyle(),
          border: hasBorder
              ? borderRadius != BorderRadius.zero
                  ? OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: enabledBorderColor ??
                            AppColors.greyD5.withOpacity(.2),
                      ))
                  : UnderlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: enabledBorderColor ?? AppColors.primaryGray,
                          width: 1))
              : InputBorder.none,
          focusedBorder: hasBorder
              ? borderRadius != BorderRadius.zero
                  ? OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: focusedBorderColor ?? AppColors.secondaryColor,
                          width: 1))
                  : UnderlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: focusedBorderColor ?? AppColors.secondaryColor,
                          width: 1))
              : InputBorder.none,
          enabledBorder: hasBorder
              ? borderRadius != BorderRadius.zero
                  ? OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: enabledBorderColor ?? AppColors.greyD5,
                          width: 1))
                  : UnderlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: enabledBorderColor ?? AppColors.greyD5,
                          width: 1))
              : InputBorder.none,
        ),
      ),
    );
  }
}
