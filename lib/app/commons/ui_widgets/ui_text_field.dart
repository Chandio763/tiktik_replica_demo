import 'package:firebase_demo_app/app/core/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/app_textstyles.dart';
import 'ui_text.dart';

class UITextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextStyle? textStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final String hintText;
  final TextStyle? hintStyle;
  final bool hideAsterisk;
  final bool? hidePassword;
  final Widget? suffixIcon;
  final Color fieldColor;
  final Color borderColor;
  final Color? labelColor;
  final Color? cursorColor;
  final bool disableTextField;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int maxLines;
  final bool? enabled;
  final bool readOnly;
  final Function(String _)? onChanged;
  final Function(String _)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? trailingImage;
  final IconData? trailingIcon;
  final Function()? onTrailingPressed;
  final FocusNode? focusNode;
  final bool capitalizeText;
  final bool phoneNumberInput;
  final List<String> autofillHintsList;
  final Widget? suffixIconWidget;
  final GlobalKey? identifierKey;
  final VoidCallback? onTap;
  final InputBorder? border;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final InputDecoration? inputDecoration;
  final bool autoFocus;
  final TextAlign textAlign;
  final bool alignLabelTextToCenter;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  const UITextField(
    this.textEditingController, {
    super.key,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.labelText,
    this.labelStyle,
    this.hintText = '',
    this.hintStyle,
    this.hideAsterisk = true,
    this.hidePassword,
    this.suffixIcon,
    this.fieldColor = Colors.white,
    this.borderColor = Colors.grey,
    this.labelColor,
    this.disableTextField = false,
    this.validator,
    this.maxLength,
    this.maxLines = 1,
    this.readOnly = false,
    this.enabled,
    this.onChanged(String _)?,
    this.onFieldSubmitted(String _)?,
    this.onEditingComplete()?,
    this.keyboardType = TextInputType.name,
    this.textInputAction = TextInputAction.next,
    this.trailingImage,
    this.trailingIcon,
    this.onTrailingPressed,
    this.focusNode,
    this.capitalizeText = false,
    this.phoneNumberInput = false,
    this.suffixIconWidget,
    this.autofillHintsList = const [],
    this.identifierKey,
    this.onTap,
    this.border,
    this.borderRadius,
    this.contentPadding,
    this.inputDecoration,
    this.prefixIcon,
    this.autoFocus = false,
    this.cursorColor,
    this.inputFormatters,
    this.alignLabelTextToCenter = false,
  });

  @override
  State<UITextField> createState() => _UITextFieldState();
}

class _UITextFieldState extends State<UITextField> {
  bool? hidePassword;

  @override
  void initState() {
    hidePassword = widget.hidePassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Row(
            mainAxisAlignment:
                widget.alignLabelTextToCenter
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
            children: [
              UIText(
                widget.labelText!,
                style:
                    widget.labelStyle ??
                    AppTextStyles.medium14.copyWith(
                      color: widget.labelColor ?? AppColors.inputFieldHeading,
                    ),
              ),
              UIText(widget.hideAsterisk ? "" : "*", maxLines: 5),
            ],
          ),
        if (widget.labelText != null) 5.heightBox,

        // ✨ Custom form field builder
        TextFormField(
          key: widget.identifierKey,
          controller: widget.textEditingController,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          textAlign: widget.textAlign,
          cursorColor: widget.cursorColor ?? AppColors.black,
          autofocus: widget.autoFocus,
          autofillHints: widget.autofillHintsList,
          textInputAction: widget.textInputAction,
          obscureText: hidePassword ?? false,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          onEditingComplete: widget.onEditingComplete,
          textAlignVertical: TextAlignVertical.top,
          // onChanged: (val) {
          //   fieldState.didChange(val);
          //   widget.onChanged?.call(val);
          // },
          style:
              widget.textStyle ??
              AppTextStyles.regular16.copyWith(color: AppColors.grey900),
          inputFormatters:
              widget.inputFormatters ??
              [
                if (widget.phoneNumberInput) _PhoneCaseTextFormatter(),
                if (widget.capitalizeText) _UpperCaseTextFormatter(),
              ],
          decoration: (widget.inputDecoration ?? InputDecoration()).copyWith(
            counterText: '',
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            fillColor:
                widget.labelColor == null && widget.disableTextField == false
                    ? AppColors.white.withOpacity(0.8)
                    : widget.labelColor,
            enabled: !widget.disableTextField,
            labelText: widget.hintText,
            hintStyle: widget.hintStyle ?? AppTextStyles.inputFieldHeading,
            labelStyle: AppTextStyles.regular14.copyWith(
              color: AppColors.hintColor,
            ),

            // 👇 Use red border when fieldState.hasError is true
            border: _buildBorder(),
            errorBorder: _buildBorder(),
            enabledBorder: _buildBorder(),
            focusedBorder: _buildBorder(),
            disabledBorder: _buildBorder(),

            errorText: null, // suppress default error
            errorMaxLines: 5,
            prefixIconConstraints: _boxConstraints(),
            suffixIconConstraints: _boxConstraints(),
            prefixIcon: widget.prefixIcon,
            isDense: true,
            contentPadding:
                widget.contentPadding ?? EdgeInsets.fromLTRB(14, 10, 14, 10),
            suffixIcon:
                widget.suffixIconWidget ??
                (widget.trailingIcon != null
                    ? Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Icon(widget.trailingIcon),
                    )
                    : widget.trailingImage != null
                    ? GestureDetector(onTap: widget.onTrailingPressed ?? () {})
                    : hidePassword != null
                    ? GestureDetector(
                      child: _iconWidget(),
                      onTap:
                          () => setState(() => hidePassword = !hidePassword!),
                    )
                    : Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: widget.suffixIcon,
                    )),
          ),
        ),

        // FormField<String>(
        //   validator: widget.validator,
        //   autovalidateMode: AutovalidateMode.onUserInteraction,
        //   builder: (fieldState) {
        //     return Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         if (fieldState.hasError)
        //           Padding(
        //             padding: const EdgeInsets.only(top: 5, left: 0),
        //             child: Row(
        //               children: [
        //                 Icon(
        //                   Icons.error_outline,
        //                   color: AppColors.error200,
        //                   size: 20.sp,
        //                 ),
        //                 8.widthBox,
        //                 Expanded(
        //                   child: UIText(
        //                     fieldState.errorText!,
        //                     style: AppTextStyles.medium12.copyWith(
        //                       color: AppColors.error200,
        //                       fontSize: 12,
        //                       fontFamily: AppConstants.appFont,
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //       ],
        //     );
        //   },
        // ),
      ],
    );
  }

  OutlineInputBorder _buildBorder() {
    final borderColor = widget.borderColor;
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
      borderSide: BorderSide(color: borderColor, width: 1),
    );
  }

  BoxConstraints _boxConstraints() =>
      const BoxConstraints(minWidth: 0, minHeight: 0);

  Widget _iconWidget() => Padding(
    padding: const EdgeInsets.only(right: 16),
    child: Icon(
      hidePassword! ? Icons.visibility_off : Icons.visibility,
      // color: ColorConstants.greyTwo,
    ),
  );
}

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class _PhoneCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove any existing non-digit characters from the input
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Ensure we only format if there are at least 5 digits
    if (newText.length > 4) {
      // Insert a dash after the 4th character
      newText = '${newText.substring(0, 4)}-${newText.substring(4)}';
    }

    // Return the new value with the formatted text
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
