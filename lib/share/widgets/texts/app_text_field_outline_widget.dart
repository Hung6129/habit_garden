import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/share/themes/app_theme.dart';

import 'app_text_widget.dart';

class AppTextFieldOutlineWidget extends StatefulWidget {
  const AppTextFieldOutlineWidget({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.initValue,
    this.maxLines = 10,
    this.maxLength,
    this.isHidePassword = false,
    this.isWarning = false,
    this.isCounterText = false,
    this.isRequired = false,
    this.textInputFormatter,
    this.keyboardType,
    this.validator,
    this.textInputAction = TextInputAction.done,
    this.textFieldFocusNode,
    this.onActionTap,
    this.suffixIcon,
    this.isDisabled = false,
    this.isViewTextOnly = false,
    this.suffixIconConstraints,
    this.minLines,
    this.filledColor,
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.helperText,
    this.onChangeTextWhenFocus,
    this.textEditingController,
  });

  final String? initValue;
  final String hintText;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final bool isHidePassword;
  final bool isWarning;
  final bool isCounterText;
  final bool isRequired;
  final bool isDisabled;
  final bool isViewTextOnly;
  final Function(String value) onChanged;
  final Function(String value)? onActionTap;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final TextInputAction textInputAction;
  final FocusNode? textFieldFocusNode;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final Color? filledColor;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final String? helperText;
  final Function(TextEditingController controller)? onChangeTextWhenFocus;
  final TextEditingController? textEditingController;

  @override
  State<AppTextFieldOutlineWidget> createState() =>
      _AppTextFieldOutlineWidgetState();
}

class _AppTextFieldOutlineWidgetState extends State<AppTextFieldOutlineWidget> {
  late final TextEditingController _textEditingController;
  final isFocused = false.obs;
  late FocusNode _textFieldFocusNode;

  @override
  void initState() {
    super.initState();
    _textEditingController = widget.textEditingController ??
        TextEditingController(text: widget.initValue);
    _textFieldFocusNode =
        _textFieldFocusNode = widget.textFieldFocusNode ?? FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _textFieldFocusNode.dispose();
  }

  @override
  void didUpdateWidget(covariant AppTextFieldOutlineWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initValue != widget.initValue) {
      // https://stackoverflow.com/questions/72365756/setstate-or-markneedsbuild-called-during-build-textfield
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          _textEditingController.value = TextEditingValue(
              text: widget.initValue ?? '',
              selection: TextSelection.collapsed(
                  offset: (widget.initValue?.length) ?? 0 - 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.isDisabled,
      child: widget.isViewTextOnly
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: widget.textAlign == TextAlign.end
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  AppTextWidget(
                    widget.initValue?.isNotEmpty == true
                        ? widget.initValue!
                        : '--',
                    textStyle: widget.textStyle ?? context.textTheme.bodyMedium,
                    textAlign: widget.textAlign,
                  ),
                  if (widget.suffixIcon != null) widget.suffixIcon!
                ],
              ),
            )
          : Focus(
              onFocusChange: (value) {
                isFocused.value = value;
                if (isFocused.value) {
                  widget.onChangeTextWhenFocus?.call(_textEditingController);
                }
              },
              child: TextFormField(
                keyboardType: widget.keyboardType,
                inputFormatters: widget.textInputFormatter,
                focusNode: _textFieldFocusNode,
                controller: _textEditingController,
                onChanged: (value) => widget.onChanged(value),
                textAlign: widget.textAlign,
                maxLines: widget.maxLines,
                maxLength: widget.maxLength,
                minLines: widget.minLines ?? 1,
                readOnly: false,
                style: context.textTheme.bodyMedium,
                obscureText: widget.isHidePassword,
                validator: widget.validator,
                textInputAction: widget.textInputAction,
                onFieldSubmitted: (v) {
                  if (widget.onActionTap != null) {
                    widget.onActionTap!(v);
                  }
                },
                decoration: InputDecoration(
                  // floatingLabelBehavior: FloatingLabelBehavior.always,
                  errorMaxLines: 3,
                  filled: widget.filledColor != null,
                  fillColor: widget.filledColor ?? Colors.transparent,
                  errorBorder: widget.helperText != null
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.get().waringColor,
                          ),
                          borderRadius: radius,
                        )
                      : OutlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.colorScheme.error,
                          ),
                          borderRadius: radius,
                        ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.get().neutralColor[20]!,
                    ),
                    borderRadius: radius,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.get().neutralColor[20]!,
                    ),
                    borderRadius: radius,
                  ),
                  focusedBorder: widget.helperText != null
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.get().waringColor,
                          ),
                          borderRadius: radius,
                        )
                      : OutlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.primaryColor,
                          ),
                          borderRadius: radius,
                        ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.get().neutralColor[20]!,
                    ),
                  ),
                  hintText: widget.hintText,
                  hintStyle: context.textTheme.bodyMedium
                      ?.copyWith(color: context.theme.hintColor),
                  helperText: widget.helperText,
                  helperMaxLines: 3,
                  helperStyle: context.theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.get().waringColor,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: const EdgeInsets.only(
                      top: 10, bottom: 12, left: 12, right: 12),
                  isDense: true,
                  suffixIcon: widget.suffixIcon,
                  suffixIconConstraints: widget.suffixIconConstraints ??
                      BoxConstraints.tight(const Size(24, 24)),
                  counterStyle: context.theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.get().neutralColor[40],
                    fontWeight: FontWeight.w400,
                  ),
                  counterText: widget.isCounterText ? null : '',
                ),
              ),
            ),
    );
  }

  BorderRadius get radius =>
      BorderRadius.circular(AppUIConstants.boxBorderRadius);
}
