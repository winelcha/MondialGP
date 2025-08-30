import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/features/entities/annonce_entity.dart';
import 'package:untitled/ui/styles/styles.dart';
import 'package:get/get.dart';

class StatusChangeController extends GetxController
    with GetTickerProviderStateMixin {
  late final Rx<AnnonceEntity> annonce;
  final selectedStatus = Rx<AnnonceStatus?>(null);
  late AnimationController animationController;

  final statusOptions = [
    AnnonceStatus.preparing,
    AnnonceStatus.inTransit,
    AnnonceStatus.delivered,
  ];

  @override
  void onInit() {
    super.onInit();
    annonce = (Get.arguments as AnnonceEntity).obs;
    selectedStatus.value = annonce.value.status;
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void selectStatus(AnnonceStatus status) {
    if (selectedStatus.value != status) {
      selectedStatus.value = status;
      animationController.forward(from: 0);
    }
  }

  void confirmStatusChange() {
    if (selectedStatus.value != null &&
        selectedStatus.value != annonce.value.status) {
      // Ici on mettrait à jour l'entité dans un vrai cas
      Get.back();
      Get.snackbar(
        'Statut mis à jour',
        'Le statut a été changé avec succès !',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.green,
        colorText: Colors.white,
      );
    } else {
      Get.back();
    }
  }

  String getStatusDescription(AnnonceStatus status) {
    switch (status) {
      case AnnonceStatus.preparing:
        return 'Le colis est en préparation';
      case AnnonceStatus.inTransit:
        return 'Le colis est en cours de transport';
      case AnnonceStatus.delivered:
        return 'Le colis a été livré';
      case AnnonceStatus.cancelled:
        return 'La commande a été annulée';
    }
  }

  String getStatusText(AnnonceStatus status) {
    switch (status) {
      case AnnonceStatus.preparing:
        return 'À préparer';
      case AnnonceStatus.inTransit:
        return 'En transit';
      case AnnonceStatus.delivered:
        return 'Livré';
      case AnnonceStatus.cancelled:
        return 'Annulé';
    }
  }

  Color getStatusColor(AnnonceStatus status) {
    switch (status) {
      case AnnonceStatus.preparing:
        return AppColors.orange;
      case AnnonceStatus.inTransit:
        return AppColors.orange;
      case AnnonceStatus.delivered:
        return AppColors.green;
      case AnnonceStatus.cancelled:
        return AppColors.red;
    }
  }

  IconData getStatusIcon(AnnonceStatus status) {
    switch (status) {
      case AnnonceStatus.preparing:
        return Icons.build;
      case AnnonceStatus.inTransit:
        return Icons.local_shipping;
      case AnnonceStatus.delivered:
        return Icons.check_circle;
      case AnnonceStatus.cancelled:
        return Icons.cancel;
    }
  }
}

class StatusChangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatusChangeController());
  }
}

