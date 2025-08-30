import 'package:flutter/material.dart';
import 'package:untitled/features/entities/annonce_entity.dart';
import 'package:get/get.dart';
import 'package:untitled/router/app_router.dart';

class DeliveryConfirmationController extends GetxController
    with GetTickerProviderStateMixin {
  late final Rx<AnnonceEntity> annonce;
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();
    annonce = (Get.arguments as AnnonceEntity).obs;

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.elasticOut),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void goBackToHome() {
    Get.offAllNamed(AppRouter.HOME);
  }

  void viewDeliveryDetails() {
    Get.back();
  }
}
