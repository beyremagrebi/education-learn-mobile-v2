import 'package:flutter/material.dart';
import 'package:studiffy/core/extensions/extensions.dart';
import 'package:studiffy/core/localization/loalisation.dart';

import '../../../core/style/dimensions.dart';
import '../../../core/style/themes/app_colors.dart';
import '../from/inputs/input_from_decoration.dart';

class BaseInputWidget<T> extends FormField<T> {
  final EdgeInsets? padding;
  final String? label;
  final bool isCircular;
  final bool isRequired;
  final FormFieldValidator<T>? additionalValidator;
  final ValueNotifier<T?> valueNotifier;
  final Function(FormFieldState<T> state) widgetBuilder;
  final Color? borderColor;
  final Color? shadowColor;

  BaseInputWidget({
    super.key,
    required this.valueNotifier,
    required this.isRequired,
    required this.widgetBuilder,
    this.padding,
    required this.label,
    this.borderColor,
    this.shadowColor,
    this.isCircular = false,
    this.additionalValidator,
  }) : super(
          initialValue: valueNotifier.value,
          onSaved: (value) => valueNotifier.value = value,
          validator: (_) {
            if (isRequired &&
                (valueNotifier.value == null ||
                    (valueNotifier.value is String &&
                        (valueNotifier.value as String).isEmptyOrNull))) {
              return intl.fieldRequiredError;
            }

            return additionalValidator?.call(valueNotifier.value);
          },
          builder: (FormFieldState<T> formState) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputFormDecoration(
                borderColor: borderColor,
                shadowColor: shadowColor,
                label: label,
                padding: padding ?? Dimensions.paddingSmallVertical,
                isCircular: isCircular,
                hasError: formState.hasError,
                child: widgetBuilder(formState),
              ),
              if (formState.hasError)
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimensions.s,
                    left: Dimensions.m,
                  ),
                  child: Text(
                    formState.errorText ?? intl.unspecifiedValidationError,
                    style: const TextStyle(
                      color: dangerColor,
                      fontSize: 11,
                    ),
                  ),
                )
            ],
          ),
        );
}
