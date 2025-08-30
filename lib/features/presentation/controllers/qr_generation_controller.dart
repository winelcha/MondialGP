import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/features/data/services/mock_service.dart';
import 'package:untitled/features/entities/annonce_entity.dart';

import 'package:untitled/ui/styles/styles.dart';

import 'package:share_plus/share_plus.dart';

class QrGenerationController extends GetxController {
  final annonce = Rx<AnnonceEntity?>(null);
  final qrCode = ''.obs;
  final pinCode = ''.obs;
  final isGenerating = false.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null && arguments is AnnonceEntity) {
      annonce.value = arguments;
      generateCodes();
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

  void generateCodes() async {
    isGenerating.value = true;
await Future.delayed(const Duration(milliseconds: 1500));

    final currentAnnonce = annonce.value!;
    final qrData = {
      'type': 'MONDIAL_GP_DELIVERY',
      'annonce_id': currentAnnonce.id,
      'origin': currentAnnonce.origin,
      'destination': currentAnnonce.destination,
      'weight': currentAnnonce.weight,
      'gp_name': currentAnnonce.gpName,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

    qrCode.value = 'MONDIAL_GP_${currentAnnonce.id}_${DateTime.now().millisecondsSinceEpoch}';

    pinCode.value = _generateSecurePinCode();

    isGenerating.value = false;

    Get.snackbar(
      'Codes générés',
      'QR Code et PIN générés avec succès !',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.green,
      colorText: AppColors.bgWhite,
      duration: const Duration(seconds: 2),
    );
  }

  String _generateSecurePinCode() {
    final random = DateTime.now().millisecondsSinceEpoch;
    return ((random % 9000) + 1000).toString();
  }

  void copyPinCode() {
    Clipboard.setData(ClipboardData(text: pinCode.value));
    Get.snackbar(
      'Code copié',
      'Code PIN copié dans le presse-papiers',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: AppColors.bgWhite,
      duration: const Duration(seconds: 1),
    );
  }

  void shareQRCode() async {
    try {
      final currentAnnonce = annonce.value!;
      final shareText = '''
🚚 MondialGP - Code QR de livraison

📦 Trajet: ${currentAnnonce.origin} → ${currentAnnonce.destination}
🏢 Compagnie: ${currentAnnonce.gpName}
⚖️ Poids: ${currentAnnonce.weight} kg
💰 Montant: ${currentAnnonce.totalPrice.toStringAsFixed(2)}€

🔗 Code QR: ${qrCode.value}

Scannez ce code pour confirmer la réception du colis.
      '''.trim();

      await Share.share(
        shareText,
        subject: 'MondialGP - Code QR de livraison',
      );
    } catch (e) {
      Get.snackbar(
        'Erreur de partage',
        'Impossible de partager le code QR',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.bgWhite,
      );
    }
  }

  void shareCodes() async {
    try {
      final currentAnnonce = annonce.value!;
      final shareText = '''
🚚 MondialGP - Codes de livraison

📦 DÉTAILS DU COLIS
━━━━━━━━━━━━━━━━━━━━
🛫 Origine: ${currentAnnonce.origin}
🛬 Destination: ${currentAnnonce.destination}
🏢 Compagnie: ${currentAnnonce.gpName}
⚖️ Poids: ${currentAnnonce.weight} kg
💰 Montant total: ${currentAnnonce.totalPrice.toStringAsFixed(2)}€

🔢 CODE PIN: ${pinCode.value}
🔗 Code QR: ${qrCode.value}

📋 INSTRUCTIONS:
1. Présentez l'un de ces codes au porteur
2. Vérifiez votre identité si demandé
3. Confirmez la réception du colis

⚠️ Ne partagez ces codes qu'avec le destinataire autorisé.

Powered by MondialGP 📱
      '''.trim();

      await Share.share(
        shareText,
        subject: 'MondialGP - Codes de livraison pour ${currentAnnonce.origin} → ${currentAnnonce.destination}',
      );

      Get.snackbar(
        'Codes partagés',
        'Codes envoyés avec succès',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.green,
        colorText: AppColors.bgWhite,
      );
    } catch (e) {
      Get.snackbar(
        'Erreur de partage',
        'Impossible de partager les codes',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.bgWhite,
      );
    }
  }

  void shareViaSMS() async {
    try {
      final currentAnnonce = annonce.value!;
      final smsText = '''
MondialGP - Livraison ${currentAnnonce.origin}→${currentAnnonce.destination}

PIN: ${pinCode.value}
QR: ${qrCode.value}

Présentez ce code au porteur pour récupérer votre colis.
      '''.trim();

      // Utilise le schéma SMS natif
      await Share.share(smsText, subject: 'MondialGP - Code de livraison');
    } catch (e) {
      Get.snackbar(
        'Erreur SMS',
        'Impossible d\'envoyer le SMS',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.bgWhite,
      );
    }
  }

  void shareViaEmail() async {
    try {
      final currentAnnonce = annonce.value!;
      final emailBody = '''
Bonjour,

Voici vos codes de livraison MondialGP pour le colis :

DÉTAILS DU COLIS
────────────────
• Origine : ${currentAnnonce.origin}
• Destination : ${currentAnnonce.destination}
• Compagnie : ${currentAnnonce.gpName}
• Poids : ${currentAnnonce.weight} kg
• Montant : ${currentAnnonce.totalPrice.toStringAsFixed(2)}€

CODES DE LIVRAISON
──────────────────
• Code PIN : ${pinCode.value}
• Code QR : ${qrCode.value}

INSTRUCTIONS
────────────
1. Présentez l'un de ces codes au porteur
2. Vérifiez votre identité si demandé
3. Signez la confirmation de réception

⚠️ IMPORTANT : Ne partagez ces codes qu'avec le destinataire autorisé.

Cordialement,
L'équipe MondialGP
      '''.trim();

      await Share.share(
        emailBody,
        subject: 'MondialGP - Codes de livraison ${currentAnnonce.origin} → ${currentAnnonce.destination}',
      );
    } catch (e) {
      Get.snackbar(
        'Erreur Email',
        'Impossible d\'envoyer l\'email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.bgWhite,
      );
    }
  }

  void regenerateCodes() {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.refresh,
              color: AppColors.orange,
              size: 24.sp,
            ),
            SizedBox(width: 8.w),
            const Text('Régénérer les codes'),
          ],
        ),
        content: const Text(
          'Êtes-vous sûr de vouloir régénérer les codes ?\n\n'
              '⚠️ Les anciens codes ne seront plus valides et devront '
              'être communiqués à nouveau au destinataire.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Annuler',
              style: TextStyle(color: AppColors.secondary),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Get.back();
              generateCodes();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Régénérer'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orange,
            ),
          ),
        ],
      ),
    );
  }

  void showShareOptions() {
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
                    'Options de partage',
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
                        child: _buildShareOption(
                          icon: Icons.share,
                          title: 'Partager tout',
                          onTap: () {
                            Get.back();
                            shareCodes();
                          },
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildShareOption(
                          icon: Icons.qr_code,
                          title: 'QR seulement',
                          onTap: () {
                            Get.back();
                            shareQRCode();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildShareOption(
                          icon: Icons.email,
                          title: 'Email',
                          onTap: () {
                            Get.back();
                            shareViaEmail();
                          },
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildShareOption(
                          icon: Icons.sms,
                          title: 'SMS',
                          onTap: () {
                            Get.back();
                            shareViaSMS();
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

  Widget _buildShareOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.scale_01,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.bgDark),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32.sp,
              color: AppColors.primary,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}