import 'package:get/get.dart';
import 'package:untitled/features/data/services/mock_service.dart';
import 'package:untitled/features/entities/annonce_entity.dart';
import 'package:untitled/router/app_router.dart';

import '../../../ui/styles/styles.dart';

class HomeController extends GetxController {
  final annonces = <AnnonceEntity>[].obs;
  final isLoading = false.obs;
  final currentTabIndex = 0.obs;
  final hasUnreadNotifications = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAnnonces();
    checkNotifications();
  }

  void loadAnnonces() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    annonces.value = MockService.getMockAnnonces();
    isLoading.value = false;
  }

  void goToAnnonceDetail(AnnonceEntity annonce) {
    Get.toNamed(AppRouter.ANNONCE_DETAIL, arguments: annonce);
  }

  void refreshAnnonces() {
    loadAnnonces();
  }

  void changeTab(int index) {
    currentTabIndex.value = index;

    switch (index) {
      case 0:
        break;
      case 1:
        _navigateToDeliveries();
        break;
      case 2:

        _navigateToNotifications();
        break;
      case 3:
        _navigateToProfile();
        break;
    }
  }

  void _navigateToDeliveries() {
    Get.snackbar(
      'Livraisons',
      'Page des livraisons en cours de développement',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: AppColors.bgWhite,
    );
    currentTabIndex.value = 0;
  }

  void _navigateToNotifications() {
    hasUnreadNotifications.value = false;
    Get.snackbar(
      'Notifications',
      'Page des notifications en cours de développement',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: AppColors.bgWhite,
    );
    currentTabIndex.value = 0;
  }

  void _navigateToProfile() {
    Get.snackbar(
      'Profil',
      'Page du profil en cours de développement',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: AppColors.bgWhite,
    );
    // Reset to home tab
    currentTabIndex.value = 0;
  }

  void checkNotifications() {
    Future.delayed(const Duration(seconds: 3), () {
      hasUnreadNotifications.value = true;
    });
  }

  void resetCurrentTab() {
    currentTabIndex.value = 0;
  }
}
