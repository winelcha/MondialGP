import 'dart:developer';

import 'package:get/get.dart';
import 'package:untitled/features/entities/user_entity.dart';
import 'package:untitled/router/app_router.dart';
import 'package:untitled/ui/styles/styles.dart';

class WelcomeController extends GetxController {
  final selectedUserType = Rx<UserType?>(null);

  void selectUserType(UserType type) {
    log("Usertype $type");
    selectedUserType.value = type;
  }

  void continueToHome() {
    if (selectedUserType.value != null) {
      Get.offAllNamed(AppRouter.MAIN);
    } else {
      Get.snackbar(
        'Attention',
        'Veuillez choisir un profil',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.orange,
        colorText: AppColors.bgWhite,
      );
    }
  }
}