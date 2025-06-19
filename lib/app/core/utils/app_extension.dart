import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension StringExtension on String {
  String get toCapital {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension IntegetExtension on int? {
  bool get success {
    if (this == 200 || this == 201 || this == 204) {
      return true;
    }
    return false;
  }
}

extension FilePathExtension on String {
  String get extractFileName {
    return split('/').last.trim();
  }
}

extension ContextExtensions on BuildContext {
  void closeKeyboard() {
    if (FocusScope.of(this).hasFocus) {
      FocusScope.of(this).unfocus();
    }
  }
}

extension SizeBoxExtension on num {
  SizedBox get heightBox => SizedBox(height: h.toDouble());
  SizedBox get widthBox => SizedBox(width: w.toDouble());
}

extension GeneralExtension<T> on T {
  bool get isEnum {
    final split = toString().split('.');
    return split.length > 1 && split[0] == runtimeType.toString();
  }

  String get getEnumString => toString().split('.').last.toCapital;
}

extension IterableExtension<T> on Iterable<T> {
  Iterable<E> mapWithIndex<E>(E Function(int index, T value) f) {
    return Iterable.generate(length).map((i) => f(i, elementAt(i)));
  }
}

extension MapExtension on Map {
  String get format {
    if (isEmpty) {
      return "";
    } else {
      var firstKey = entries.first.key;
      var mapValues = entries.first.value;
      return "?$firstKey=$mapValues";
    }
  }
}

extension CustomTextStyleExtension on TextStyle {
  TextStyle copyWith({
    Color? color,
    double? size,
    FontWeight? weight,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    TextOverflow? overflow,
  }) {
    return TextStyle(
      fontSize: size ?? fontSize,
      fontWeight: weight ?? fontWeight,
      color: color ?? this.color,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height ?? this.height,
      fontStyle: fontStyle,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      decorationThickness: decorationThickness,
      backgroundColor: backgroundColor,
      shadows: shadows,
      overflow: overflow ?? this.overflow,
    );
  }
}

//Helper functions
void pop(BuildContext context, int returnedLevel) {
  for (var i = 0; i < returnedLevel; ++i) {
    Navigator.pop(context, true);
  }
}

Color generateRandomColor() {
  final Random random = Random();
  // Generate dark colors to ensure white text visibility
  int red = random.nextInt(156); // 0-155
  int green = random.nextInt(156); // 0-155
  int blue = random.nextInt(156); // 0-155

  return Color.fromARGB(255, red, green, blue); // Full opacity
}
