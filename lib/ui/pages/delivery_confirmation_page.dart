import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/features/presentation/controllers/delivery_confirmation_controller.dart';
import 'package:untitled/ui/styles/styles.dart';
import 'package:get/get.dart';


class DeliveryConfirmationPage extends GetView<DeliveryConfirmationController> {
  const DeliveryConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: controller.animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: controller.fadeAnimation,
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScaleTransition(
                            scale: controller.scaleAnimation,
                            child: _buildSuccessIcon(),
                          ),
                          SizedBox(height: 32.h),
                          _buildSuccessMessage(),
                          SizedBox(height: 24.h),
                          _buildDeliveryInfo(),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildActionButtons(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: BoxDecoration(
        color: AppColors.green,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.green.withOpacity(0.3),
            blurRadius: 20.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.check,
            size: 60.sp,
            color: Colors.white,
          ),
          // Animation de cercle
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.green.withOpacity(0.3),
                width: 3.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Column(
      children: [
        Text(
          'Colis livré avec succès !',
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.green,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          'La livraison a été confirmée\net enregistrée dans le système',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.secondary,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDeliveryInfo() {
    return Obx(() {
      final annonce = controller.annonce.value;
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.green.withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            _buildInfoRow(
              icon: Icons.flight_takeoff,
              label: 'Trajet',
              value: '${annonce.origin} → ${annonce.destination}',
            ),
            SizedBox(height: 12.h),
            _buildInfoRow(
              icon: Icons.business,
              label: 'Compagnie',
              value: annonce.gpName ?? 'N/A',
            ),
            SizedBox(height: 12.h),
            _buildInfoRow(
              icon: Icons.scale,
              label: 'Poids',
              value: '${annonce.weight} kg',
            ),
            SizedBox(height: 12.h),
            _buildInfoRow(
              icon: Icons.schedule,
              label: 'Livré le',
              value: DateFormat('dd/MM/yyyy à HH:mm').format(DateTime.now()),
            ),
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.euro,
                    size: 18.sp,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Montant: ${annonce.totalPrice.toStringAsFixed(2)}€',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20.sp,
          color: AppColors.green,
        ),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.secondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton.icon(
            onPressed: controller.goBackToHome,
            icon: const Icon(Icons.home),
            label: const Text('Retour à l\'accueil'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: OutlinedButton.icon(
            onPressed: controller.viewDeliveryDetails,
            icon: const Icon(Icons.info_outline),
            label: const Text('Voir les détails'),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 24.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Icon(
                Icons.star,
                color: AppColors.primary,
                size: 24.sp,
              ),
              SizedBox(height: 8.h),
              Text(
                'Merci d\'utiliser MondialGP !',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),
              Text(
                'Votre colis a été livré en toute sécurité',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.primary.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}