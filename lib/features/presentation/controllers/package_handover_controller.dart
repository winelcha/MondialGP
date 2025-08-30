import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/features/entities/annonce_entity.dart';
import 'package:untitled/router/app_router.dart';
import 'dart:io';
import 'package:untitled/ui/styles/styles.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PackageHandoverController extends GetxController {
  final annonce = Rx<AnnonceEntity?>(null);
  final photos = <File>[].obs;
  final enteredPinCode = ''.obs;
  final scannedQrCode = ''.obs;
  final isValidatingCode = false.obs;
  final validationMethod = ''.obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null && arguments is AnnonceEntity) {
      annonce.value = arguments;
    } else {
      Get.snackbar(
        'Erreur',
        'Aucune annonce sélectionnée',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.bgWhite,
      );
      Get.back();
    }
  }

  Future<void> takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (photo != null) {
        photos.add(File(photo.path));
        Get.snackbar(
          'Photo ajoutée',
          'Photo prise avec succès !',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.green,
          colorText: AppColors.bgWhite,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de prendre la photo',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.bgWhite,
      );
    }
  }

  Future<void> pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (image != null) {
        photos.add(File(image.path));
        Get.snackbar(
          'Photo ajoutée',
          'Photo sélectionnée avec succès !',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.green,
          colorText: AppColors.bgWhite,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de sélectionner la photo',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.bgWhite,
      );
    }
  }

  void removePhoto(int index) {
    if (index >= 0 && index < photos.length) {
      photos.removeAt(index);
    }
  }

  void showImageSourceDialog() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: AppColors.bgWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(top: 8.h),
              decoration: BoxDecoration(
                color: AppColors.bgDark,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  Text(
                    'Ajouter une photo',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildImageSourceOption(
                          icon: Icons.camera_alt,
                          title: 'Caméra',
                          onTap: () {
                            Get.back();
                            takePhoto();
                          },
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildImageSourceOption(
                          icon: Icons.photo_library,
                          title: 'Galerie',
                          onTap: () {
                            Get.back();
                            pickFromGallery();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.scale_01,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.bgDark),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32.sp, color: AppColors.primary),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scanQrCode() async {
    try {
      final result = await Get.toNamed('/qr-scanner');
      if (result != null && result is String) {
        scannedQrCode.value = result;
        validationMethod.value = 'qr';
        Get.snackbar(
          'QR Code scanné',
          'Code QR lu avec succès !',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.green,
          colorText: AppColors.bgWhite,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de scanner le QR code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.bgWhite,
      );
    }
  }

  // Méthode de validation améliorée (garde l'ancien nom pour compatibilité)
  void validatePinCode() async => validateCode();

  void validateCode() async {
    if (photos.isEmpty) {
      Get.snackbar(
        'Photo requise',
        'Veuillez prendre au moins une photo du colis',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.orange,
        colorText: AppColors.bgWhite,
      );
      return;
    }

    final hasPinCode = enteredPinCode.value.length == 4;
    final hasQrCode = scannedQrCode.value.isNotEmpty;

    if (!hasPinCode && !hasQrCode) {
      Get.snackbar(
        'Code requis',
        'Veuillez saisir le code PIN ou scanner le QR code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.orange,
        colorText: AppColors.bgWhite,
      );
      return;
    }

    final currentAnnonce = annonce.value;
    if (currentAnnonce == null) {
      Get.snackbar(
        'Erreur',
        'Aucune annonce sélectionnée',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.bgWhite,
      );
      return;
    }

    isValidatingCode.value = true;

    await Future.delayed(const Duration(milliseconds: 2000));

    bool isValid = false;
    String validationMessage = '';

    if (hasQrCode) {
      // Validation QR code
      isValid = _validateQrCode(scannedQrCode.value, currentAnnonce);
      validationMessage =
          isValid ? 'QR Code valide !' : 'QR Code invalide ou expiré';
    } else if (hasPinCode) {
      isValid = _validatePinCode(enteredPinCode.value);
      validationMessage = isValid ? 'Code PIN valide !' : 'Code PIN incorrect';
    }

    isValidatingCode.value = false;

    if (isValid) {
      await _updateAnnonceStatusToDelivered(currentAnnonce);

      Get.snackbar(
        'Validation réussie',
        validationMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.green,
        colorText: AppColors.bgWhite,
      );

      Get.offNamed(AppRouter.DELIVERY_CONFIRMATION, arguments: currentAnnonce);
    } else {
      Get.snackbar(
        'Validation échouée',
        validationMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.bgWhite,
      );
    }
  }

  bool _validateQrCode(String qrCode, AnnonceEntity annonce) {
    if (qrCode.startsWith('MONDIAL_GP_')) {
      final parts = qrCode.split('_');
      if (parts.length >= 3) {
        final annonceId = parts[2];
        return annonceId == annonce.id;
      }
    }
    return false;
  }

  bool _validatePinCode(String pinCode) {
    return pinCode == '1234';
  }

  Future<void> _updateAnnonceStatusToDelivered(AnnonceEntity annonce) async {}

  void updatePinCode(String value) {
    if (value.length <= 4 && RegExp(r'^\d*$').hasMatch(value)) {
      enteredPinCode.value = value;
      if (value.length == 4) {
        validationMethod.value = 'pin';
      }
    }
  }

  void clearCodes() {
    enteredPinCode.value = '';
    scannedQrCode.value = '';
    validationMethod.value = '';
  }

  void showValidationMethodDialog() {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.help_outline, color: AppColors.primary, size: 24.sp),
            SizedBox(width: 8.w),
            const Text('Méthodes de validation'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vous pouvez valider la livraison avec :',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 16.h),
            _buildValidationMethodItem(
              icon: Icons.qr_code,
              title: 'Scanner le QR Code',
              description: 'Scannez le code affiché par le destinataire',
            ),
            SizedBox(height: 12.h),
            _buildValidationMethodItem(
              icon: Icons.pin,
              title: 'Saisir le code PIN',
              description: 'Demandez le code PIN à 4 chiffres',
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.orange,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Une seule méthode suffit pour valider',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Compris')),
        ],
      ),
    );
  }

  Widget _buildValidationMethodItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: 20.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                description,
                style: TextStyle(fontSize: 12.sp, color: AppColors.secondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
