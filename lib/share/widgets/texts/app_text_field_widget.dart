import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:habit_garden/share/themes/app_theme.dart';
import 'app_text_widget.dart';

class AppTextFieldWidget extends StatefulWidget {
  const AppTextFieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    this.onChanged,
    this.initValue,
    this.maxLines = 10,
    this.maxLength,
    this.isHidePassword = false,
    this.isCounterText = false,
    this.isRequired = false,
    this.textInputFormatter,
    this.keyboardType,
    this.validator,
    this.errorText,
    this.textInputAction = TextInputAction.done,
    this.textFieldFocusNode,
    this.onActionTap,
    this.suffixIcon,
    this.isDisabled = false,
    this.isViewTextOnly = false,
    this.suffixIconConstraints,
    this.helperText,
    this.onBlur,
  });

  final String label;
  final String? initValue;
  final String hintText;
  final int maxLines;
  final int? maxLength;
  final bool isHidePassword;
  final bool isCounterText;
  final bool isRequired;
  final bool isDisabled;
  final bool isViewTextOnly;
  final String? helperText;
  final Function(String value)? onChanged;
  final Function(String value)? onActionTap;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final String? errorText;
  final TextInputAction textInputAction;
  final FocusNode? textFieldFocusNode;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final Function(String value)? onBlur;

  @override
  State<AppTextFieldWidget> createState() => _AppTextFieldWidgetState();
}

class _AppTextFieldWidgetState extends State<AppTextFieldWidget> {
  late final TextEditingController _textEditingController;
  final isFocused = false.obs;
  late FocusNode _textFieldFocusNode;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.initValue);
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
  void didUpdateWidget(covariant AppTextFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initValue != widget.initValue) {
      // https://stackoverflow.com/questions/72365756/setstate-or-markneedsbuild-called-during-build-textfield
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _textEditingController.value = TextEditingValue(
          text: widget.initValue ?? '',
          selection: TextSelection.collapsed(
              offset: (widget.initValue?.length) ?? 0 - 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.isDisabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppTextWidget(
                widget.label,
                textStyle: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.get().neutralColor[60],
                ),
              ),
              if (widget.isRequired) const SizedBox(width: 2),
              if (widget.isRequired && !widget.isViewTextOnly)
                AppTextWidget(
                  '*',
                  textStyle: context.textTheme.bodySmall?.copyWith(
                      color: widget.helperText != null
                          ? AppColors.get().waringColor
                          : context.theme.colorScheme.error),
                )
            ],
          ),
          widget.isViewTextOnly
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: AppTextWidget(
                      widget.initValue?.isNotEmpty == true
                          ? widget.initValue!
                          : '--',
                      textStyle: context.textTheme.bodyMedium),
                )
              : Focus(
                  onFocusChange: (value) {
                    isFocused.value = value;
                    if (!isFocused.value) {
                      widget.onBlur?.call(_textEditingController.value.text);
                    }
                  },
                  child: TextFormField(
                    keyboardType: widget.keyboardType,
                    inputFormatters: widget.textInputFormatter,
                    focusNode: _textFieldFocusNode,
                    controller: _textEditingController,
                    onChanged: (value) => widget.onChanged?.call(value),
                    textAlign: TextAlign.start,
                    maxLines: widget.maxLines,
                    maxLength: widget.maxLength,
                    minLines: 1,
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
                      errorText: widget.errorText,
                      errorMaxLines: 3,
                      enabledBorder: widget.helperText != null
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.get().waringColor,
                              ),
                            )
                          : UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.get().neutralColor[20]!),
                            ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.get().neutralColor[20]!),
                      ),
                      focusedBorder: widget.helperText != null
                          ? UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.get().waringColor,
                              ),
                            )
                          : UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: context.theme.primaryColor),
                            ),
                      hintText: widget.hintText,
                      helperText: widget.helperText,
                      helperMaxLines: 3,
                      helperStyle: context.theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.get().waringColor,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: context.textTheme.bodyMedium
                          ?.copyWith(color: context.theme.hintColor),
                      contentPadding:
                          const EdgeInsets.only(top: 10, bottom: 12),
                      isDense: true,
                      suffixIcon: widget.suffixIcon,
                      suffixIconConstraints: widget.suffixIconConstraints ??
                          BoxConstraints.tight(const Size(24, 24)),
                      counterText: widget.isCounterText ? null : '',
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
