import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habit_garden/core/constants/app_constants.dart';
import 'package:habit_garden/core/translations/strings.dart';
import 'package:habit_garden/share/widgets/date/app_date_picker_widget.dart';
import 'package:habit_garden/share/widgets/date/app_date_range_picker_widget.dart';
import 'package:habit_garden/share/widgets/texts/app_text_field_outline_widget.dart';
import 'package:habit_garden/share/widgets/texts/app_text_field_password_widget.dart';
import 'package:habit_garden/share/widgets/texts/app_text_field_widget.dart';
import 'package:habit_garden/share/widgets/texts/app_text_widget.dart';
import 'package:habit_garden/share/themes/app_theme.dart';
import 'package:intl/intl.dart';
import 'validator_util.dart';

class FormUtils {
  FormUtils._();

  // static Widget renderDropdownField<BM>(
  //   BuildContext context, {
  //   required key,
  //   required String label,
  //   required String hintText,
  //   required List<DropdownModel> Function() listItem,
  //   bool isHasBorder = true,
  //   bool require = false,
  //   bool isDisabled = false,
  //   bool isViewTextOnly = false,
  //   Function(DropdownModel? value)? onChanged,
  //   String? Function(String? value)? validator,
  // }) {
  //   return FormBuilderField(
  //     name: key,
  //     validator: validator,
  //     builder: (FormFieldState<dynamic> field) {
  //       return AppDropdownFieldWidget(
  //         hint: hintText,
  //         items: listItem(),
  //         label: label,
  //         isRequired: require,
  //         isEnabled: !isDisabled,
  //         validator: field.errorText,
  //         value: field.value,
  //         isViewTextOnly: isViewTextOnly,
  //         onChanged: (object) {
  //           if (onChanged != null && object?.value != field.value) {
  //             onChanged(object);
  //           }
  //           field.didChange(object?.value);
  //         },
  //       );
  //     },
  //   );
  // }

  /// Using for picking date range
  static Widget buildDateRange({
    required String name,
    required String fromName,
    required String toName,
    Function(DateTime?, DateTime?)? onChanged,
    DateTime? initFirstDate,
    DateTime? initLastDate,
  }) {
    return Column(
      children: [
        FormUtils.renderEmptyField(name: fromName),
        FormUtils.renderEmptyField(name: toName),
        FormBuilderField(
          name: name,
          builder: (field) {
            return AppDateRangePickerWidget(
              Strings.time,
              hintText: Strings.timePickerHint,
              initFirstDate: initFirstDate ?? DateTime.now(),
              initLastDate:
                  initLastDate ?? DateTime.now().add(const Duration(days: 7)),
              onChanged: onChanged,
            );
          },
        ),
      ],
    );
  }

  ///
  /// Render a basic input field using formKey and formBuilderField
  ///
  /// With [AppTextFieldWidget]
  ///
  static Widget renderInputField(
    BuildContext context, {
    required key,
    required String label,
    required String hintText,
    List<TextInputFormatter>? textInputFormatter,
    TextInputType? keyboardType,
    int? maxLength,
    int maxLines = 1,
    bool require = false,
    bool isViewTextOnly = false,
    bool isHidePassword = false,
    String? initValue,
    String? Function(String? value)? validator,
    Widget? suffixIcon,
    BoxConstraints? suffixIconConstraints,
    Function(String value)? onChanged,
    TextInputAction textInputAction = TextInputAction.done,
    Function(String value)? onActionTap,
    FocusNode? focusNode,
  }) {
    return FormBuilderField(
      name: key,
      builder: (FormFieldState<dynamic> field) {
        return AppTextFieldWidget(
          textFieldFocusNode: focusNode,
          label: label,
          isRequired: require,
          onChanged: (value) {
            field.didChange(value);
            if (onChanged != null) {
              onChanged(value);
            }
          },
          isHidePassword: isHidePassword,
          hintText: hintText,
          maxLength: maxLength,
          initValue: initValue ?? field.value,
          textInputFormatter: textInputFormatter,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onActionTap: onActionTap,
          maxLines: maxLines,
          validator: validator,
          isViewTextOnly: isViewTextOnly,
          suffixIcon: suffixIcon,
          suffixIconConstraints: suffixIconConstraints,
        );
      },
    );
  }

  ///
  /// Render a basic input field using formKey and formBuilderField
  ///
  /// With [AppTextFieldOutlineWidget]
  ///
  static Widget renderOutlineInputField(
    BuildContext context, {
    required key,
    required String label,
    required String hintText,
    List<TextInputFormatter>? textInputFormatter,
    TextInputType? keyboardType,
    int? maxLength,
    int maxLines = 1,
    int minLines = 1,
    Widget? suffixIcon,
    BoxConstraints? suffixIconConstraints,
    bool require = false,
    bool isViewTextOnly = false,
    bool isHidePassword = false,
    String? initValue,
    String? Function(String? value)? validator,
    Function(String value)? onChanged,
    TextInputAction textInputAction = TextInputAction.done,
    Function(String value)? onActionTap,
    FocusNode? focusNode,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppTextWidget(
              label,
              textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.get().neutralColor[60],
                  ),
            ),
            if (require) const SizedBox(width: 2),
            if (require)
              AppTextWidget(
                '*',
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              )
          ],
        ),
        const SizedBox(height: 4),
        FormBuilderField(
          name: key,
          builder: (FormFieldState<dynamic> field) {
            return AppTextFieldOutlineWidget(
              textFieldFocusNode: focusNode,
              isRequired: require,
              onChanged: (value) {
                field.didChange(value);
                if (onChanged != null) {
                  onChanged(value);
                }
              },
              isHidePassword: isHidePassword,
              hintText: hintText,
              maxLength: maxLength,
              initValue: initValue ?? field.value,
              textInputFormatter: textInputFormatter,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              onActionTap: onActionTap,
              maxLines: maxLines,
              minLines: minLines,
              validator: validator,
              isViewTextOnly: isViewTextOnly,
              suffixIcon: suffixIcon,
              suffixIconConstraints: suffixIconConstraints,
            );
          },
        ),
      ],
    );
  }

  ///
  /// Render a basic input field using formKey and formBuilderField
  ///
  /// With [AppTextFieldPasswordWidget]
  ///
  static Widget renderPasswordField(
    BuildContext context, {
    required key,
    required String label,
    required String hintText,
    List<TextInputFormatter>? textInputFormatter,
    TextInputType? keyboardType,
    int? maxLength,
    int maxLines = 1,
    bool require = false,
    bool isViewTextOnly = false,
    String? initValue,
    String? Function(String? value)? validator,
    Function(String value)? onChanged,
    TextInputAction textInputAction = TextInputAction.done,
    Function(String value)? onActionTap,
    FocusNode? focusNode,
  }) {
    return FormBuilderField(
      name: key,
      builder: (FormFieldState<dynamic> field) {
        return AppTextFieldPasswordWidget(
          focusNode: focusNode,
          label: label,
          require: require,
          onChanged: (value) {
            field.didChange(value);
            if (onChanged != null) {
              onChanged(value);
            }
          },
          hintText: hintText,
          maxLength: maxLength,
          initValue: initValue ?? field.value,
          textInputFormatter: textInputFormatter,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onActionTap: onActionTap,
          maxLines: maxLines,
          validator: validator,
          isViewTextOnly: isViewTextOnly,
        );
      },
    );
  }

  ///
  /// Render a basic input field using formKey and formBuilderField
  ///
  /// With [AppTextFieldWidget], and text input type is number
  ///
  static Widget renderNumberInputField({
    required String label,
    required String hintText,
    required String name,
    List<TextInputFormatter>? textInputFormatter,
    bool isRequired = false,
    bool initValueFromForm = true,
    bool isViewTextOnly = false,
    String? Function(String? value)? validator,
    int? maxLength,
    Function(String value)? onChanged,
  }) {
    return FormBuilderField<String>(
      name: name,
      builder: (field) => AppTextFieldWidget(
        label: label,
        isRequired: isRequired,
        isViewTextOnly: isViewTextOnly,
        maxLength: maxLength,
        initValue: initValueFromForm ? field.value : null,
        validator: isRequired
            ? (validator ?? (value) => ValidatorUtil.requireValidator(value))
            : null,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputFormatter: textInputFormatter,
        hintText: hintText,
        onChanged: (value) {
          field.didChange(value);
          if (onChanged != null) {
            onChanged(value);
          }
        },
      ),
    );
  }

  ///
  /// Render a date picker field
  ///
  /// Using [AppDatePickerWidget]
  ///
  static Widget renderDatePickerField(
    BuildContext context, {
    required key,
    required String label,
    Function(DateTime value)? onChanged,
    bool require = false,
    bool isViewTextOnly = false,
    DateTime? firstDate,
    DateTime? lastDate,
    String? Function(DateTime? value)? validator,
  }) {
    return FormBuilderField<DateTime>(
      name: key,
      validator: require
          ? validator ??
              (value) => ValidatorUtil.requireValidator(value?.toString())
          : null,
      builder: ((field) => AppDatePickerWidget(
            label,
            initValue: field.value,
            isRequired: require,
            isViewTextOnly: isViewTextOnly,
            validator: field.errorText,
            firstDate: firstDate,
            lastDate: lastDate,
            onChanged: ((value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }),
          )),
    );
  }

  ///
  /// Render a emty field, using for mapping a field in form
  ///
  static Widget renderEmptyField({required String name}) {
    return FormBuilderField(
      name: name,
      builder: (field) => const SizedBox(),
    );
  }

  ///
  /// Render a date picker field, but for view only
  ///
  static Widget buildDateOnlyView(
      {required String name, required String label}) {
    return FormBuilderField<DateTime?>(
      name: name,
      builder: (field) => AppDatePickerWidget(
        label,
        initValue: field.value,
        isViewTextOnly: true,
      ),
    );
  }

  ///
  /// Render a field view only, using for view only
  ///
  static Widget buildFieldOnlyView(
      {required String name, required String label}) {
    return FormBuilderField<String?>(
      name: name,
      builder: (field) => AppTextFieldWidget(
        label: label,
        hintText: field.value ?? '--',
        initValue: field.value,
        isViewTextOnly: true,
        isDisabled: true,
        onChanged: (value) => {},
      ),
    );
  }

  static Widget buildFieldOnlyViewWithEmpty({
    required String label,
    required String formKeyName,
    required String formKeyId,
  }) {
    return Column(
      children: [
        FormUtils.buildFieldOnlyView(
          label: label,
          name: formKeyName,
        ),
        FormUtils.renderEmptyField(
          name: formKeyId,
        ),
      ],
    );
  }

  static Widget buildFieldOnlyViewNoLabel({
    required String name,
    TextStyle? textStyle,
  }) {
    return FormBuilderField<String?>(
      name: name,
      builder: (field) => AppTextWidget(
        field.value ?? '--',
        textStyle: textStyle,
      ),
    );
  }

  static Widget buildRowOnlyView(
      {required String leftName,
      required String leftLabel,
      required rightName,
      required rightLabel}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FormUtils.buildFieldOnlyView(
            name: leftName,
            label: leftLabel,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FormUtils.buildFieldOnlyView(
            name: rightName,
            label: rightLabel,
          ),
        ),
      ],
    );
  }

  static Widget buildRowDateOnlyView(
      {required String leftName,
      required String leftLabel,
      required rightName,
      required rightLabel}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FormUtils.buildDateOnlyView(
            name: leftName,
            label: leftLabel,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FormUtils.buildDateOnlyView(
            name: rightName,
            label: rightLabel,
          ),
        ),
      ],
    );
  }

  static Widget buildRowDateWithFieldOnlyView(
      {required String dateName,
      required String dateLabel,
      required String fieldName,
      required String fieldLabel,
      bool isDateLeft = false,
      bool isDateRight = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDateLeft)
          Expanded(
            child: FormUtils.buildDateOnlyView(
              name: dateName,
              label: dateLabel,
            ),
          ),
        if (isDateLeft) const SizedBox(width: 12),
        Expanded(
          child: FormUtils.buildFieldOnlyView(
            name: fieldName,
            label: fieldLabel,
          ),
        ),
        if (isDateRight) const SizedBox(width: 12),
        if (isDateRight)
          Expanded(
            child: FormUtils.buildDateOnlyView(
              name: dateName,
              label: dateLabel,
            ),
          ),
      ],
    );
  }

  static Widget buildRowSingleDateOnlyView(
    BuildContext context,
    String label,
    String name, {
    TextStyle? textStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextWidget(
          label,
          textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.get().neutralColor[60],
              ),
        ),
        FormBuilderField<DateTime?>(
          name: name,
          builder: (field) => AppTextWidget(
            field.value != null
                ? DateFormat(AppConstants.dateTimeDefaultFormat)
                    .format(field.value!)
                : Strings.dateDefaultFormat,
            textStyle: textStyle,
          ),
        ),
      ],
    );
  }

  static Widget buildRowMoneyOnlyView(
    BuildContext context,
    String label,
    String name, {
    bool suffix = true,
    TextStyle? textStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextWidget(
          "$label ${suffix == true ? Strings.textVND : ''}",
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.get().neutralColor[60],
              ),
        ),
        FormUtils.buildFieldOnlyViewNoLabel(
          name: name,
          textStyle: textStyle,
        ),
      ],
    );
  }

  static Widget buildRowInputMoney(
    BuildContext context,
    String label,
    String name, {
    bool isRequired = true,
    String? Function(String? value)? validator,
    List<TextInputFormatter>? textInputFormatter,
    String? helperText,
    String? initValue,
    Function(String value)? onChanged,
    bool isSigned = true,
    bool isDecimal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppTextWidget(
              label,
              textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.get().neutralColor[60],
                  ),
            ),
            if (isRequired)
              AppTextWidget(
                ' *',
                textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 -
              2 * AppUIConstants.majorScalePadding(4),
          child: renderNumberOutlineInputField(
            context,
            require: isRequired,
            name: name,
            validator:
                isRequired ? validator ?? ValidatorUtil.requireValidator : null,
            textInputFormatter: [
              ...?textInputFormatter,
              MoneyTextInputFormatter(),
            ],
            helperText: helperText,
            initValue: initValue,
            hintText: Strings.moneyHint,
            onChanged: onChanged,
            isSigned: isSigned,
            isDecimal: isDecimal,
          ),
        )
      ],
    );
  }

  static Widget buildRowInputNumber(
    BuildContext context,
    String label,
    String name, {
    bool isRequired = true,
    String? Function(String? value)? validator,
    List<TextInputFormatter>? textInputFormatter,
    String? helperText,
    String? initValue,
    Function(String value)? onChanged,
    bool isSigned = true,
    bool isDecimal = false,
    String? hintText,
    int? maxLength,
    bool isViewTextOnly = false,
    Function(TextEditingController controller)? onChangeTextWhenFocus,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppTextWidget(
              label,
              textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.get().neutralColor[60],
                  ),
            ),
            if (isRequired)
              AppTextWidget(
                ' *',
                textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 -
              2 * AppUIConstants.majorScalePadding(4),
          child: renderNumberOutlineInputField(
            context,
            require: isRequired,
            name: name,
            validator:
                isRequired ? validator ?? ValidatorUtil.requireValidator : null,
            textInputFormatter: [
              ...?textInputFormatter,
            ],
            helperText: helperText,
            initValue: initValue,
            hintText: hintText,
            onChanged: onChanged,
            isSigned: isSigned,
            maxLength: maxLength,
            isDecimal: isDecimal,
            isViewTextOnly: isViewTextOnly,
            onChangeTextWhenFocus: onChangeTextWhenFocus,
          ),
        )
      ],
    );
  }

  static Widget renderNumberOutlineInputField(
    BuildContext context, {
    required name,
    List<TextInputFormatter>? textInputFormatter,
    bool require = false,
    String? Function(String? value)? validator,
    String? helperText,
    String? initValue,
    String? hintText,
    Function(String value)? onChanged,
    bool isSigned = true,
    bool isDecimal = false,
    int? maxLength,
    bool isViewTextOnly = false,
    Widget? suffixIcon,
    BoxConstraints? suffixIconConstraints,
    Function(TextEditingController controller)? onChangeTextWhenFocus,
  }) {
    return FormBuilderField(
      name: name,
      builder: (FormFieldState<String?> field) {
        return AppTextFieldOutlineWidget(
          suffixIcon: suffixIcon,
          suffixIconConstraints: suffixIconConstraints,
          isViewTextOnly: isViewTextOnly,
          onChanged: (value) {
            field.didChange(value);
            if (onChanged != null) {
              onChanged(value);
            }
          },
          hintText: hintText ?? '',
          maxLength: maxLength,
          textInputFormatter: [
            ...?textInputFormatter,
          ],
          keyboardType: TextInputType.numberWithOptions(
            decimal: isDecimal,
            signed: isSigned,
          ),
          maxLines: 1,
          minLines: 1,
          isDisabled: false,
          validator: validator,
          initValue: initValue ?? field.value,
          filledColor: Theme.of(context).appColor.neutralColor[0],
          textAlign: TextAlign.end,
          helperText: helperText,
          onChangeTextWhenFocus: onChangeTextWhenFocus,
        );
      },
    );
  }

  static Widget buildInputDouble({
    required String name,
    required String label,
    required String hintText,
    bool isViewTextOnly = false,
  }) {
    return FormBuilderField<String?>(
      name: name,
      builder: (field) {
        return AppTextFieldWidget(
          label: label,
          hintText: hintText,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputFormatter: _doubleInputFormatter,
          validator: ValidatorUtil.requireNumberAndLargerZeroValidator,
          isRequired: true,
          onChanged: (value) => field.didChange(value),
          isViewTextOnly: isViewTextOnly,
          initValue: field.value,
        );
      },
    );
  }

  static final List<TextInputFormatter> _doubleInputFormatter = [
    TextInputFormatter.withFunction(
      (oldValue, newValue) => newValue.copyWith(
        text: newValue.text.replaceAll(',', '.'),
      ),
    ),
    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
  ];

  static Widget buildFieldSingleTap(
      {required String name,
      required String label,
      required String hintText,
      bool isRequired = false,
      bool isViewTextOnly = false,
      Function? onTap}) {
    return InkWell(
      onTap: () => isViewTextOnly ? null : onTap?.call(),
      child: FormBuilderField<String?>(
        name: name,
        builder: (field) => AppTextFieldWidget(
          label: label,
          isViewTextOnly: isViewTextOnly,
          hintText: hintText,
          initValue: field.value,
          validator: isRequired
              ? ((value) => ValidatorUtil.requireValidator(
                  value != null ? value.toString() : ''))
              : null,
          isDisabled: true,
          isRequired: isRequired,
        ),
      ),
    );
  }

  // static Widget province(
  //   List<DropdownModel> items, {
  //   Function(DropdownModel?)? onChanged,
  //   bool isRequired = false,
  //   bool isViewTextOnly = false,
  // }) {
  //   return FormBuilderField<String?>(
  //     name: GeneralFormKey.province,
  //     validator:
  //         isRequired ? (value) => ValidatorUtil.requireValidator(value) : null,
  //     builder: (field) => AppDropdownFieldWidget(
  //       label: Strings.provinceTitle,
  //       hint: Strings.provinceHint,
  //       value: field.value,
  //       items: items,
  //       isRequired: isRequired,
  //       validator: field.errorText,
  //       onChanged: (model) {
  //         if (model?.value == field.value) return;
  //         field.didChange(model?.value);
  //         onChanged?.call(model);
  //       },
  //       isViewTextOnly: isViewTextOnly,
  //     ),
  //   );
  // }

  // static Widget district(List<DropdownModel> Function() items,
  //     {Function(DropdownModel?)? onChanged, bool isRequired = false}) {
  //   return FormBuilderField<String?>(
  //     name: GeneralFormKey.district,
  //     builder: (field) => AppDropdownFieldWidget(
  //       label: Strings.districtTitle,
  //       hint: Strings.districtHint,
  //       value: field.value,
  //       items: items.call(),
  //       isRequired: isRequired,
  //       onChanged: (model) {
  //         if (model?.value == field.value) return;
  //         field.didChange(model?.value);
  //         onChanged?.call(model);
  //       },
  //     ),
  //   );
  // }

  // static Widget village(List<DropdownModel> Function() items,
  //     {Function(DropdownModel?)? onChanged, bool isRequired = false}) {
  //   return FormBuilderField<String?>(
  //     name: GeneralFormKey.village,
  //     builder: (field) => AppDropdownFieldWidget(
  //       label: Strings.wardTitle,
  //       hint: Strings.wardHint,
  //       value: field.value,
  //       items: items.call(),
  //       isRequired: isRequired,
  //       onChanged: (model) {
  //         if (model?.value == field.value) return;
  //         field.didChange(model?.value);
  //         onChanged?.call(model);
  //       },
  //     ),
  //   );
  // }
}

class MoneyTextInputFormatter extends TextInputFormatter {
  final formatter = NumberFormat.decimalPattern();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.extentOffset;
      String newString =
          newValue.text.replaceAll(formatter.symbols.GROUP_SEP, '');
      newString = int.parse(newString).toString();
      newString = formatter.format(int.parse(newString));
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndexFromTheRight,
        ),
      );
    } else {
      return newValue;
    }
  }
}
