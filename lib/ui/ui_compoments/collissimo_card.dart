import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/ui/styles/colors.dart';
import 'package:untitled/ui/ui_compoments/svg_asset_onpress.dart';

import 'h1.dart';

class CollissimoCard extends StatelessWidget {
  final String title;
  final String count;
  final String imagePath;
  final VoidCallback? onTap;

  const CollissimoCard({
    Key? key,
    required this.title,
    required this.count,
    required this.imagePath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 320.w,
            height: 150,
            margin: EdgeInsets.only(top: 20.h),
            padding: EdgeInsets.fromLTRB(16.w, 18.h, 16.w, 3.h),
            decoration: BoxDecoration(
              color:AppColors.secondary,
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  width: 180.w,
                  child: H1(
                    text: title,
                    appSizes: 19,
                    fontWeight: FontWeight.w500,
                    colors: AppColors.darkText,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            left: 35.w,
            child: H1(
              text: count,
              appSizes: 45.sp,
              fontWeight: FontWeight.w500,
              colors: AppColors.bgDark,
            ),
          ),
          Positioned(
            bottom: -4,
            right: 0.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: SvgAssetOnPress(
                iconString: 'assets/images/vector.svg',
                size: 85.w,
              ),
            ),
          ),
          Positioned(
            bottom: -7,
            right: 2.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                imagePath,
                width: 120.w,
                height: 213.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.luggage,
                      color: Colors.white,
                      size: 30.sp,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
