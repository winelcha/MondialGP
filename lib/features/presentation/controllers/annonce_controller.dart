
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/features/entities/annonce_entity.dart';
import 'package:untitled/router/app_router.dart';

import 'package:untitled/ui/styles/styles.dart';

class AnnonceController extends GetxController {
  final Rx<AnnonceEntity?> annonce = Rx<AnnonceEntity?>(null);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is AnnonceEntity) {
      annonce.value = args;
    } else {
      Get.back();
      Get.snackbar(
        'Erreur',
        'Impossible de charger les détails de l\'annonce',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: Colors.white,
      );
    }
  }

  void changeStatus() {
    if (annonce.value != null) {
      Get.toNamed(AppRouter.STATUS_CHANGE, arguments: annonce.value);
    }
  }

  void generateCode() {
    if (annonce.value != null) {
      Get.toNamed(AppRouter.QR_GENERATION, arguments: annonce.value);
    }
  }

  void reserveAnnonce() {
    Get.snackbar(
      'Réservation',
      'Annonce réservée avec succès !',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.green,
      colorText: Colors.white,
    );
  }

  void handoverPackage() {
    if (annonce.value != null) {
      Get.toNamed(AppRouter.PACKAGE_HANDOVER, arguments: annonce.value);
    }
  }
}
