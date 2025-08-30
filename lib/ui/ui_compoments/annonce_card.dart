import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/features/entities/annonce_entity.dart';
import 'package:untitled/ui/styles/styles.dart';

class AnnonceCard extends StatelessWidget {
  final AnnonceEntity annonce;
  final VoidCallback? onTap;

  const AnnonceCard({Key? key, required this.annonce, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 142.w,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13.r),
          border: Border.all(color: AppColors.scale_04, width: 1.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildPriceSection(),
            _buildStatsSection(),
            _buildActionButton(),
            _buildExpirationTimer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCountryChip(_getFlag(annonce.origin), annonce.origin ?? ''),
              SizedBox(width: 8.w),
              SizedBox(width: 8.w),
              _buildCountryChip(
                _getFlag(annonce.destination),
                annonce.destination ?? '',
              ),
            ],
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  Widget _buildCountryChip(String flag, String country) {
    return Container(
      width: 150.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),

      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Text(flag, style: TextStyle(fontSize: 50.sp)),
          SizedBox(width: 4.w),
          Text(
            country,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _formatDate(annonce.dateCreated),
                style: TextStyle(
                  fontSize: 12.sp,
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

  Widget _buildProgressBar() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '${annonce.weight.toInt()}',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.green,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              'Kg reçus',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Text(
              '${(annonce.weight * 1.4).toInt()}',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.orange,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              'Kg disponible',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.orange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Stack(
          children: [
            Container(
              height: 6.h,
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(7.r),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(7.r),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Container(
        height: 110.h,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.scale_01,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              _buildProgressBar(),
              Text(
                'Tarifs: ${annonce.pricePerKg.toStringAsFixed(0)}€ par Kg',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.bgDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 89.h,
            width: 141.w,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.scale_01,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Envoyeurs',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.bgDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '3',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 89.h,
            width: 141.w,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.scale_01,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  'Demande',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.bgDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '1',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: SizedBox(
        width: double.infinity,
        height: 58.h,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
            ),
            elevation: 0,
          ),
          child: Text(
            'Plus de détails',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpirationTimer() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
      child: Container(
        width: 173.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.orange_01,
          borderRadius: BorderRadius.circular(41.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timelapse_rounded, size: 16.sp, color: AppColors.red),
            SizedBox(width: 4.w),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Expire dans : ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.bgDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '0j 23h',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.bgDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFlag(String? country) {
    switch (country?.toLowerCase()) {
      case 'france':
        return '🇫🇷';
      case 'sénégal':
      case 'senegal':
        return '🇸🇳';
      case 'côte d\'ivoire':
      case 'cote d\'ivoire':
        return '🇨🇮';
      case 'mali':
        return '🇲🇱';
      case 'cameroun':
        return '🇨🇲';
      default:
        return '🌍';
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';

    try {
      return DateFormat('dd MMM, yyyy', 'fr_FR').format(date);
    } catch (e) {
      return DateFormat('dd MMM, yyyy').format(date);
    }
  }
}
