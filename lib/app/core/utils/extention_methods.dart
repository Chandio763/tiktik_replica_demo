import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension StringExtension on String {
  String get toCapitalize {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension SizeBoxExtension on num {
  SizedBox get heightBox => SizedBox(height: h.toDouble());
  SizedBox get widthBox => SizedBox(width: w.toDouble());
}

extension ContextExtensions on BuildContext {
  void closeKeyboard() {
    if (FocusScope.of(this).hasFocus) {
      FocusScope.of(this).unfocus();
    }
  }
}

extension DateTimeExtension on DateTime {
  String get to12HourFormat {
    final hour = this.hour % 12 == 0 ? 12 : this.hour % 12;
    final period = this.hour < 12 ? 'am' : 'pm';
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
}
