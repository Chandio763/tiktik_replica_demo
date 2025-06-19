import 'package:firebase_demo_app/app/core/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_spacing.dart';
import '../../core/utils/app_textstyles.dart';

class UIOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Color? borderColor;
  final Color? backgroundColor;
  final Widget? icon;

  const UIOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.padding,
    this.textStyle,
    this.borderColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor ?? AppColors.primary, width: 1.sp),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.outlinedButtonRadius.r,
          ),
        ),
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
      child:
          icon != null
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon!,
                  8.widthBox,
                  Text(
                    label,
                    style:
                        textStyle ??
                        AppTextStyles.bold12.copyWith(color: AppColors.primary),
                  ),
                ],
              )
              : Text(
                label,
                style:
                    textStyle ??
                    AppTextStyles.bold12.copyWith(color: AppColors.primary),
              ),
    );
  }
}
