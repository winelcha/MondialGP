import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../styles/styles.dart';
import 'h1.dart';

enum TypeButton { text, button }

class CustomButton<T extends GetxController> extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? textColor;
  final double? sizeText;
  final Color? colorSide;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final T? controller;
  final FontWeight? fontWeight;
  final double? radius;
  final TypeButton? type;
  final String? loadingProperty;
  final bool? Function(T)? isLoadingCallback;

  const CustomButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.textColor,
    this.sizeText,
    this.colorSide,
    this.type = TypeButton.button,
    this.controller,
    this.fontWeight,
    this.radius,
    this.loadingProperty,
    this.isLoadingCallback,
  });

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return _buildButton(false);
    }

    return GetBuilder<T>(
      init: controller,
      builder: (ctrl) {
        bool isLoading = false;

        if (isLoadingCallback != null) {
          isLoading = isLoadingCallback!(ctrl) ?? false;
        } else if (loadingProperty != null) {
          try {
            final dynamic value = _getPropertyValue(ctrl, loadingProperty!);
            isLoading = value is bool ? value : false;
          } catch (e) {
            isLoading = false;
          }
        } else {
          isLoading = _detectCommonLoadingStates(ctrl);
        }

        return _buildButton(isLoading);
      },
    );
  }

  Widget _buildButton(bool isLoading) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      child: type == TypeButton.text
          ? Padding(
              padding: const EdgeInsets.only(top: 1),
              child: SizedBox(
                child: isLoading
                    ? Center(
                        child: LoadingAnimationWidget.twistingDots(
                          leftDotColor: const Color(0xFF1A1A3F),
                          rightDotColor: AppColors.bgWhite,
                          size: AppSizes.h_24,
                        ),
                      )
                    : H1(
                        text: text,
                        colors: backgroundColor,
                        appSizes: 14,
                        fontWeight: FontWeight.w600,
                      ),
              ),
            )
          : SizedBox(
              width: double.infinity,
              height: AppSizes.h_40,
              child: ElevatedButton(
                onPressed: isLoading ? null : onPressed,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius ?? AppSizes.h_8),
                    side: BorderSide(
                      color: colorSide ?? AppColors.scale_01.withOpacity(0.6),
                    ),
                  ),
                ),
                child: Center(
                  child: isLoading
                      ? LoadingAnimationWidget.twistingDots(
                          leftDotColor: const Color(0xFF1A1A3F),
                          rightDotColor: AppColors.bgWhite,
                          size: AppSizes.h_24,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            H1(
                              text: text,
                              colors: textColor ?? AppColors.bgWhite,
                              appSizes: sizeText ?? AppSizes.h_13,
                              letterSpacing: 0,
                              fontWeight: fontWeight ?? FontWeight.w600,
                            ),
                            if (icon != null) ...[
                              const SizedBox(width: AppSizes.h_8),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: AppSizes.h_4,
                                  right: AppSizes.h_4,
                                ),
                                child: Icon(
                                  icon,
                                  color: textColor ?? AppColors.bgWhite,
                                ),
                              ),
                            ],
                          ],
                        ),
                ),
              ),
            ),
    );
  }

  dynamic _getPropertyValue(T controller, String propertyName) {
    try {
      switch (propertyName.toLowerCase()) {
        case 'isloading':
          if (controller.toString().contains('isLoading')) {
            return (controller as dynamic).isLoading?.value ?? false;
          }
          break;
        case 'issubmitting':
          if (controller.toString().contains('isSubmitting')) {
            return (controller as dynamic).isSubmitting?.value ?? false;
          }
          break;
        case 'issaving':
          if (controller.toString().contains('isSaving')) {
            return (controller as dynamic).isSaving?.value ?? false;
          }
          break;
      }

      return (controller as dynamic)[propertyName];
    } catch (e) {
      return false;
    }
  }

  bool _detectCommonLoadingStates(T controller) {
    try {
      final dynamic ctrl = controller as dynamic;

      if (ctrl.isLoading != null && ctrl.isLoading is RxBool) {
        return ctrl.isLoading.value;
      }
      if (ctrl.isSubmitting != null && ctrl.isSubmitting is RxBool) {
        return ctrl.isSubmitting.value;
      }
      if (ctrl.isSaving != null && ctrl.isSaving is RxBool) {
        return ctrl.isSaving.value;
      }
      if (ctrl.isProcessing != null && ctrl.isProcessing is RxBool) {
        return ctrl.isProcessing.value;
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
