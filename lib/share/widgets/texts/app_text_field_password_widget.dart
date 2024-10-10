import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'app_text_field_widget.dart';

class AppTextFieldPasswordWidget extends StatefulWidget {
  final String label;
  final String hintText;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int maxLines;
  final bool require;
  final bool isViewTextOnly;
  final String? initValue;
  final String? Function(String? value)? validator;
  final Function(String value)? onChanged;
  final TextInputAction textInputAction;
  final Function(String value)? onActionTap;
  final FocusNode? focusNode;

  const AppTextFieldPasswordWidget({
    super.key,
    required this.label,
    required this.hintText,
    this.textInputFormatter,
    this.keyboardType,
    this.maxLength,
    this.initValue,
    this.validator,
    this.onChanged,
    this.onActionTap,
    this.focusNode,
    required this.maxLines,
    required this.require,
    required this.isViewTextOnly,
    required this.textInputAction,
  });

  @override
  State<AppTextFieldPasswordWidget> createState() =>
      _AppTextFieldPasswordWidgetState();
}

class _AppTextFieldPasswordWidgetState
    extends State<AppTextFieldPasswordWidget> {
  final RxBool isShowPassword = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppTextFieldWidget(
        textFieldFocusNode: widget.focusNode,
        label: widget.label,
        isRequired: widget.require,
        onChanged: widget.onChanged,
        isHidePassword: !isShowPassword.value,
        hintText: widget.hintText,
        maxLength: widget.maxLength,
        initValue: widget.initValue,
        textInputFormatter: widget.textInputFormatter,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        onActionTap: widget.onActionTap,
        maxLines: widget.maxLines,
        validator: widget.validator,
        isViewTextOnly: widget.isViewTextOnly,
        suffixIconConstraints: BoxConstraints.tight(const Size(22, 20)),
        suffixIcon: InkWell(
          customBorder: const CircleBorder(),
          child: SvgPicture.asset(
            isShowPassword.value
                ? 'assets/vectors/ic_trailing.svg'
                : 'assets/vectors/ic_trailing_hide.svg',
          ),
          onTap: () {
            isShowPassword.value = !isShowPassword.value;
          },
        ),
      ),
    );
  }
}
