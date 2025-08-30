import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/features/entities/annonce_entity.dart';
import 'package:untitled/ui/styles/styles.dart';

class StatusWidget extends StatelessWidget {
  final AnnonceStatus currentStatus;
  final VoidCallback onTap;

  const StatusWidget({
    Key? key,
    required this.currentStatus,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: _getStatusColor(currentStatus),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.circle,
              size: 8.sp,
              color: Colors.white,
            ),
            SizedBox(width: 8.w),
            Text(
              _getStatusText(currentStatus),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16.sp,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(AnnonceStatus status) {
    switch (status) {
      case AnnonceStatus.preparing:
        return AppColors.primary_01;
      case AnnonceStatus.inTransit:
        return AppColors.orange;
      case AnnonceStatus.delivered:
        return AppColors.green;
      case AnnonceStatus.cancelled:
        return AppColors.red;
    }
  }

  String _getStatusText(AnnonceStatus status) {
    switch (status) {
      case AnnonceStatus.preparing:
        return 'En préparation';
      case AnnonceStatus.inTransit:
        return 'En transit';
      case AnnonceStatus.delivered:
        return 'Livré';
      case AnnonceStatus.cancelled:
        return 'Annulé';
    }
  }
}

