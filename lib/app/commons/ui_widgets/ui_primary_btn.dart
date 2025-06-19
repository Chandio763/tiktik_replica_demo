import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_extension.dart';

import '../../core/utils/app_spacing.dart';
import '../../core/utils/app_textstyles.dart';
import 'ui_svg.dart';
import 'ui_text.dart';

class UIPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final String? leftIconSvg;

  final double? width;
  final double? height;
  final bool isOutline;
  final String? icon;
  final Color? backgroundColor;
  final double? elevation;
  final double? borderRadius;
  final Widget? trailingIcon;
  final Widget? child;
  final MainAxisAlignment mainAxisAlignment;
  const UIPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.child,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.borderRadius,
    this.backgroundColor,
    this.elevation,
    this.height,
    this.width,
    this.padding,
    this.textStyle,
    this.icon,
    this.isOutline = false,
    this.leftIconSvg,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isOutline ? AppColors.primary : Colors.white;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor ?? (isOutline ? Colors.white : AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? AppSpacing.primaryButtonRadius.r,
            ),
            side:
                isOutline
                    ? BorderSide(color: AppColors.primary, width: 1.5)
                    : BorderSide.none,
          ),
          padding: padding ?? EdgeInsets.fromLTRB(18.sp, 9.sp, 18.sp, 9.sp),
          elevation: elevation ?? (isOutline ? 0 : null),
        ),
        child:
            child ??
            Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                if (icon != null)
                  Padding(
                    padding: EdgeInsets.only(right: 6.sp),
                    child: UISvg(svg: icon!),
                  ),
                if (leftIconSvg != null) ...[
                  UISvg(svg: leftIconSvg!),
                  8.widthBox,
                ],
                UIText(
                  label,
                  style:
                      textStyle ??
                      AppTextStyles.bold14.copyWith(color: textColor),
                ),
                if (trailingIcon != null) ...[6.widthBox, trailingIcon!],
              ],
            ),
      ),
    );
  }
}
