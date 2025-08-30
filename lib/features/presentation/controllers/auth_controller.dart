import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/features/data/services/shared_preferences_service.dart';
import 'package:untitled/features/entities/user_entity.dart';
import 'package:untitled/router/app_router.dart';
import '../../../ui/styles/styles.dart';

class AuthController extends GetxController {
  final SharedPreferencesService _storageService =
      Get.find<SharedPreferencesService>();

  final RxBool isLoading = false.obs;
  final Rx<UserType?> selectedProfile = Rx<UserType?>(null);
  final RxBool isAuthenticated = false.obs;
  final isLoggedIn = false.obs;
  final currentUser = Rx<UserEntity?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() {
    final userType = _storageService.getUserType();
    if (userType != null) {
      selectedProfile.value = userType;
      isAuthenticated.value = true;

      currentUser.value = UserEntity(
        id: '1',
        name: userType == UserType.demandeur ? 'Marie Dupont' : 'Jean Martin',
        type: userType,
        email:
            userType == UserType.demandeur
                ? 'marie@example.com'
                : 'jean@example.com',
      );
    }
  }

  void login(UserEntity user) {
    currentUser.value = user;
    isLoggedIn.value = true;
  }

  Future<void> selectProfile(UserType type) async {
    try {
      isLoading.value = true;

      await Future.delayed(Duration(milliseconds: 1500));

      await _storageService.setUserType(type);
      selectedProfile.value = type;
      isAuthenticated.value = true;

      currentUser.value = UserEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: type == UserType.demandeur ? 'Marie Dupont' : 'Jean Martin',
        type: type,
        email:
            type == UserType.demandeur
                ? 'marie@example.com'
                : 'jean@example.com',
      );
      Get.offAllNamed(AppRouter.HOME);

      Get.snackbar(
        'Profil sélectionné',
        'Bienvenue ${currentUser.value?.name}!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de sélectionner le profil',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      await _storageService.clearUserData();
      selectedProfile.value = null;
      isAuthenticated.value = false;
      currentUser.value = null;

      Get.offAllNamed(AppRouter.INITIAL);
    } finally {
      currentUser.value = null;
      isLoggedIn.value = false;
    }
  }

  bool get isDemandeur => selectedProfile.value == UserType.demandeur;
  bool get isPorteur => selectedProfile.value == UserType.porteur;
  String get profileTitle => isDemandeur ? 'Demandeur' : 'Porteur';
}
