
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/features/entities/annonce_entity.dart';
import 'package:untitled/features/entities/user_entity.dart';
import 'package:untitled/ui/styles/styles.dart';
import 'package:get/get.dart';
import 'package:untitled/features/presentation/controllers/controllers.dart';
import 'package:untitled/ui/ui_compoments/status_widget.dart';

import '../ui_compoments/ui_compments.dart';

class AnnonceDetailPage extends GetView<AnnonceController> {
  const AnnonceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          final annonce = controller.annonce.value;

          if (annonce == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.bgDark,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    H1(
                      text: 'Détails',
                      colors: AppColors.darkText,
                      fontWeight: FontWeight.w600,
                      appSizes: AppSizes.h_18,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.more_horiz_outlined,
                        color: AppColors.bgDark,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 36.h),
                _buildStatsSection(annonce),
                SizedBox(height: 16.h),
                _buildStatusSection(annonce),

                SizedBox(height: 16.h),
                _buildInfoSection(annonce),
                SizedBox(height: 16.h),
                _buildUsersSection(annonce),

                SizedBox(height: 24.h),
                _buildActionButtons(annonce),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStatusSection(AnnonceEntity annonce) {
    return Container(
      padding: EdgeInsets.all(16.w),
      height: 78.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.scale_04, width: 1.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Statut',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          SizedBox(height: 12.h),
          StatusWidget(
            currentStatus: annonce.status,
            onTap: () {

            }
          ),
        ],
      ),
    );
  }


  Widget _buildStatsSection(AnnonceEntity annonce) {
    return Container(
      height: 159.h,

      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13.r),
        border: Border.all(color: AppColors.scale_04, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statistiques',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.darkText,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Text(
                '${annonce.weight.toInt()}',
                style: TextStyle(
                  fontSize: 45.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                'Kg au total',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.bgDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                '${(annonce.totalPrice * 1.4).toInt()}',
                style: TextStyle(
                  fontSize: 45.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                '€ gagné',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.bgDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(AnnonceEntity annonce) {
    return _buildCard(
      title: 'Informations',
      child: Column(
        children: [
          if (annonce.dateCreated != null)
            _buildInfoRow(
              icon: Icons.schedule,
              label: 'Date de création',
              value: DateFormat(
                'dd/MM/yyyy à HH:mm',
              ).format(annonce.dateCreated!),
            ),
          if (annonce.dateDelivered != null) ...[
            SizedBox(height: 12.h),
            _buildInfoRow(
              icon: Icons.check_circle,
              label: 'Date de livraison',
              value: DateFormat(
                'dd/MM/yyyy à HH:mm',
              ).format(annonce.dateDelivered!),
            ),
          ],
          if (annonce.qrCode != null) ...[
            SizedBox(height: 12.h),
            _buildInfoRow(
              icon: Icons.qr_code,
              label: 'Code QR',
              value: 'Généré',
            ),
          ],
          if (annonce.pinCode != null) ...[
            SizedBox(height: 12.h),
            _buildInfoRow(
              icon: Icons.pin,
              label: 'Code PIN',
              value: annonce.pinCode!,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUsersSection(AnnonceEntity annonce) {
    return _buildCard(
      title: 'Participants',
      child: Column(
        children: [
          if (annonce.demandeur != null)
            _buildUserRow(
              icon: Icons.send,
              label: 'Demandeur',
              user: annonce.demandeur!,
            ),
          if (annonce.porteur != null) ...[
            SizedBox(height: 12.h),
            _buildUserRow(
              icon: Icons.local_shipping,
              label: 'Porteur',
              user: annonce.porteur!,
            ),
          ],
        ],
      ),
    );
  }


  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.orange.withOpacity(0.1),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: AppColors.secondary),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, color: AppColors.secondary),
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

  Widget _buildUserRow({
    required IconData icon,
    required String label,
    required UserEntity user,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: AppColors.secondary),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, color: AppColors.secondary),
        ),
        const Spacer(),
        Text(
          user.name ?? 'Inconnu',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 24.sp, color: AppColors.primary),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: AppColors.secondary),
        ),
      ],
    );
  }

  Widget _buildActionButtons(AnnonceEntity annonce) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton.icon(
            onPressed: controller.reserveAnnonce,
            icon: const Icon(Icons.bookmark),
            label: const Text('Réserver'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: OutlinedButton.icon(
                  onPressed: controller.changeStatus,
                  icon: const Icon(Icons.update),
                  label: const Text('Changer statut'),
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
                child: OutlinedButton.icon(
                  onPressed: controller.generateCode,
                  icon: const Icon(Icons.qr_code),
                  label: const Text('Générer code'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (annonce.status == AnnonceStatus.inTransit) ...[
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton.icon(
              onPressed: controller.handoverPackage,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Remise du colis'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
