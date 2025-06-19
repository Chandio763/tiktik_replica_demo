import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';

class UILoaderView extends StatelessWidget {
  final Color? color;

  final double strokeWidth;

  UILoaderView({
    Key? key,
    this.color=AppColors.white,
    this.strokeWidth = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 16.w,
        height: 16.h,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? Theme.of(context).primaryColor,
          ),
          strokeWidth: strokeWidth.w,
        ),
      ),
    );
  }
}