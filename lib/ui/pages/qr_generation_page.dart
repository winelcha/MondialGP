import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/ui/styles/styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:untitled/features/presentation/controllers/controllers.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../features/entities/annonce_entity.dart';

class QrGenerationPage extends GetView<QrGenerationController> {
  const QrGenerationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Codes de livraison'),
        actions: [
          IconButton(
            onPressed: controller.shareCodes,
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Obx(() {
        final annonceData = controller.annonce.value;

        if (annonceData == null) {
          return _buildErrorState();
        }

        if (controller.isGenerating.value) {
          return _buildGeneratingState();
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAnnonceHeader(annonceData),
              SizedBox(height: 24.h),
              _buildQRCodeSection(),
              SizedBox(height: 24.h),
              _buildPinCodeSection(),
              SizedBox(height: 24.h),
              _buildInstructions(),
              SizedBox(height: 32.h),
              _buildActionButtons(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.sp,
            color: AppColors.red,
          ),
          SizedBox(height: 16.h),
          Text(
            'Erreur de chargement',
            style: TextStyle(fontSize: 18.sp, color: AppColors.darkText),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text('Retour'),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneratingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80.w,
            height: 80.w,
            child: CircularProgressIndicator(
              strokeWidth: 6.w,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Génération des codes...',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Veuillez patienter',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnonceHeader(AnnonceEntity annonce) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.qr_code,
                color: Colors.white,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Codes de livraison',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            '${annonce.origin} → ${annonce.destination}',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'GP: ${annonce.gpName} • ${annonce.weight} kg • ${annonce.totalPrice.toStringAsFixed(2)}€',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRCodeSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.orange.withOpacity(0.3),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.qr_code,
                color: AppColors.primary,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Code QR',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: controller.shareQRCode,
                icon: Icon(
                  Icons.share,
                  color: AppColors.primary,
                  size: 20.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.bgDark),
            ),
            child: QrImageView(
              data: controller.qrCode.value,
              version: QrVersions.auto,
              size: 200.w,
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              errorCorrectionLevel: QrErrorCorrectLevel.H,
              embeddedImage: null, // Vous pouvez ajouter un logo ici
              embeddedImageStyle: null,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Scannez ce code pour confirmer la réception',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.secondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPinCodeSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.orange.withOpacity(0.3),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.pin,
                color: AppColors.primary,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Code PIN',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: controller.copyPinCode,
                icon: Icon(
                  Icons.copy,
                  color: AppColors.primary,
                  size: 20.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Text(
              controller.pinCode.value,
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 8.w,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Partagez ce code avec le destinataire',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.secondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.green.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.green,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Instructions',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildInstructionItem(
            '1. Partagez ces codes avec le destinataire',
          ),
          SizedBox(height: 8.h),
          _buildInstructionItem(
            '2. Le destinataire doit présenter l\'un des codes',
          ),
          SizedBox(height: 8.h),
          _buildInstructionItem(
            '3. Vérifiez l\'identité avant la remise du colis',
          ),
          SizedBox(height: 8.h),
          _buildInstructionItem(
            '4. Prenez une photo de confirmation',
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle_outline,
          color: AppColors.green,
          size: 16.sp,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: OutlinedButton.icon(
                  onPressed: controller.regenerateCodes,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Régénérer'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton.icon(
                  onPressed: controller.shareCodes,
                  icon: const Icon(Icons.share),
                  label: const Text('Partager'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: OutlinedButton.icon(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Retour aux détails'),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.secondary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
